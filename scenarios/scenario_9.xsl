<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Output the result as plain text to generate valid JSON format -->
    <xsl:output method="text" encoding="UTF-8"/>

    <!-- Match the document root and generate JSON output with team summaries -->
    <xsl:template match="/">
        <!-- Start JSON root object with teamsummary array -->
{
  "teamsSummary": [
        <!-- Iterate through each TEAM element and generate JSON objects -->
    <xsl:for-each select="CLUB/TEAMS/TEAM">
      <!-- Build a JSON object for each team with computed data -->
      {
        <!-- Team ID: unique identifier for the team -->
        "teamId": <xsl:value-of select="ID"/>,
        <!-- Team Name: name of the team -->
        "teamName": "<xsl:value-of select="NAME"/>",
        <!-- Coach ID: the coach assigned to this team -->
        "coachId": <xsl:value-of select="REF/@idCoach"/>,
        <!-- Total Members: computed count of all members in the team -->
        "totalMembers": <xsl:value-of select="count(MEMBERS/MEMBER)"/>
      }<!-- Add comma between objects, but not after the last one (proper JSON syntax) --><xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
  ]
}
    </xsl:template>

</xsl:stylesheet>