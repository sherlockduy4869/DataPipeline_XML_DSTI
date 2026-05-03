<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- Lookup keys: fast access to TEAM and FACILITY nodes by their ID -->
    <xsl:key name="teamById" match="TEAM" use="ID"/>
    <xsl:key name="facilityById" match="FACILITY" use="ID"/>

    <!-- Output the result as indented HTML -->
    <xsl:output method="html" indent="yes"/>

    <!-- Match the document root and build the page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Training Schedule</title>
            </head>
            <body>
                <h2>Training Schedule</h2>
                <table border="1">
                    <!-- Table header row -->
                    <tr>
                        <th>Session ID</th>
                        <th>Team</th>
                        <th>Facility</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Equipment</th>
                    </tr>

                    <!-- Iterate through each training session, sorted chronologically -->
                    <xsl:for-each select="CLUB/TRAININGSESSIONS/TRAININGSESSION">
                        <xsl:sort select="TIME" order="ascending"/>
                        <!-- Resolve related team and facility via the keys defined above -->
                        <xsl:variable name="team" select="key('teamById', TEAMID)"/>
                        <xsl:variable name="facility" select="key('facilityById', FACILITYID)"/>
                        <!-- Split the ISO timestamp "YYYY-MM-DDThh:mm:ss" into date and time parts -->
                        <xsl:variable name="datePart" select="substring-before(TIME, 'T')"/>
                        <xsl:variable name="timePart" select="substring-after(TIME,  'T')"/>
                        <tr>
                            <td><xsl:value-of select="ID"/></td>
                            <td><xsl:value-of select="$team/NAME"/></td>
                            <td><xsl:value-of select="$facility/NAME"/></td>
                            <td><xsl:value-of select="$facility/LOCATION"/></td>
                            <td><xsl:value-of select="$datePart"/></td>
                            <td><xsl:value-of select="$timePart"/></td>
                            <td>
                                <!-- Join all EQUIPMENT names with commas -->
                                <xsl:for-each select="EQUIPMENTS/EQUIPMENT">
                                    <xsl:value-of select="."/>
                                    <xsl:if test="position() != last()">, </xsl:if>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </xsl:for-each>

                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
