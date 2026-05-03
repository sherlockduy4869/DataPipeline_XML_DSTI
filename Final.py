"""
Main Python program for XML Sports Club Data Pipeline Project.

This program performs:
1. XML validation against XSD schema
2. XSLT transformation execution
3. Output generation in HTML, XML, or JSON format depending on scenario

Uses lxml library for XML processing.
"""

from lxml import etree
import os


# ------------------------------------------------------------
# PROJECT DIRECTORY CONFIGURATION
# ------------------------------------------------------------
# Base directory of the project
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Input XML and XSD files
XML_FILE = os.path.join(BASE_DIR, "sport_club.xml")
XSD_FILE = os.path.join(BASE_DIR, "sport_club.xsd")

# Folder containing all XSLT scenario files
SCENARIOS_DIR = os.path.join(BASE_DIR, "scenarios")

# Folder where output results will be stored
RESULTS_DIR = os.path.join(BASE_DIR, "results")


# ------------------------------------------------------------
# FUNCTION: VALIDATE XML AGAINST XSD
# ------------------------------------------------------------
def validate_xml(xml_path, xsd_path):
    """
    Validates an XML document against an XSD schema.

    Args:
        xml_path (str): Path to XML file
        xsd_path (str): Path to XSD schema file

    Returns:
        etree.ElementTree: Parsed XML document if valid

    Raises:
        Exception: If XML does not conform to XSD
    """

    # Load and parse XSD schema
    with open(xsd_path, "rb") as schema_file:
        schema_root = etree.XML(schema_file.read())
        schema = etree.XMLSchema(schema_root)

    # Load and parse XML document
    with open(xml_path, "rb") as xml_file:
        xml_doc = etree.parse(xml_file)

    # Validate XML against schema
    if schema.validate(xml_doc):
        return xml_doc
    else:
        # Print validation errors
        for error in schema.error_log:
            print(error.message)
        raise Exception("XML validation failed against XSD")


# ------------------------------------------------------------
# FUNCTION: APPLY XSLT TRANSFORMATION
# ------------------------------------------------------------
def apply_xslt(xml_doc, xslt_path, output_path):
    """
    Apply XSL transformation
    and save HTML/XML/JSON output.
    """

    xslt_doc = etree.parse(xslt_path)
    transform = etree.XSLT(xslt_doc)

    result = transform(xml_doc)

    # Save transformation result
    with open(output_path, "wb") as output_file:

        # HTML/XML outputs
        if result.getroot() is not None:

            output_file.write(
                etree.tostring(
                    result,
                    pretty_print=True,
                    encoding="utf-8"
                )
            )

        # TEXT outputs (JSON)
        else:

            output_file.write(
                str(result).encode("utf-8")
            )

# ------------------------------------------------------------
# FUNCTION: RUN A SCENARIO
# ------------------------------------------------------------
def run_scenario(scenario_number):
    """
    Executes a given scenario transformation.

    Args:
        scenario_number (int): Scenario index (1–10)
    """

    # Build XSLT file path
    xslt_file = os.path.join(SCENARIOS_DIR, f"scenario_{scenario_number}.xsl")

    # Determine output format based on scenario type
    if 1 <= scenario_number <= 6:
        extension = "html"
    elif 7 <= scenario_number <= 8:
        extension = "xml"
    else:
        extension = "json"

    # Output file path
    output_file = os.path.join(RESULTS_DIR, f"scenario_{scenario_number}.{extension}")

    # Validate XML before transformation
    xml_doc = validate_xml(XML_FILE, XSD_FILE)

    # Apply XSLT transformation
    apply_xslt(xml_doc, xslt_file, output_file)


# ------------------------------------------------------------
# MAIN PROGRAM ENTRY POINT
# ------------------------------------------------------------
if __name__ == "__main__":

    # Display program header
    print("SPORTS CLUB XML DATA PIPELINE SYSTEM")

    # User selects scenario
    scenario = int(input("Enter scenario number (1–10): "))

    # Execute selected scenario
    run_scenario(scenario)

    print("Execution completed.")