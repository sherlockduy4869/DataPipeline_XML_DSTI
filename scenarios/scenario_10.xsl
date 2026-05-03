<?xml version="1.0" encoding="UTF-8"?>

<!--
     ========================================================
     SCENARIO 10
     ========================================================
     Purpose:
     Export TRAINING SESSIONS from XML database into JSON format.
     
     For each training session, we extract:
     - Session ID
     - Date & Time
     - Team Name (linked via TEAMID)
     - Facility Name (linked via FACILITYID)
     
     This demonstrates:
     - XPath navigation
     - Cross-entity referencing
     - JSON-like output generation using XSLT 1.0
     ========================================================
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
  
  <!-- Output as plain text because XSLT 1.0 has no JSON mode -->
  <xsl:output method="text" encoding="UTF-8"/>
  
  <!-- Root template: start transformation from document root -->
  <xsl:template match="/">
    
    {
    "sessions": [
    
    <!-- Loop through all training sessions in the CLUB -->
    <xsl:for-each select="CLUB/TRAININGSESSIONS/TRAININGSESSION">
      
      <!--
           VARIABLES:
           We retrieve related data using XPath relationships
           instead of duplicating information.
      -->
      
      <!-- Get corresponding TEAM node using TEAMID -->
      <xsl:variable name="team"
        select="/CLUB/TEAMS/TEAM[ID = current()/TEAMID]"/>
      
      <!-- Get corresponding FACILITY node using FACILITYID -->
      <xsl:variable name="facility"
        select="/CLUB/FACILITIES/FACILITY[ID = current()/FACILITYID]"/>
      
      <!-- JSON object for one training session -->
      {
      "sessionId": "<xsl:value-of select="ID"/>",
      "time": "<xsl:value-of select="TIME"/>",
      "team": "<xsl:value-of select="$team/NAME"/>",
      "facility": "<xsl:value-of select="$facility/NAME"/>"
      }
      
      <!-- Add comma between JSON objects except last one -->
      <xsl:if test="position() != last()">,</xsl:if>
      
    </xsl:for-each>
    
    ]
    }
    
  </xsl:template>
  
</xsl:stylesheet>