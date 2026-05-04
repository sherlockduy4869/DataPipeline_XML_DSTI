<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- Output the result as indented XML -->
    <xsl:output method="xml" indent="yes"/>

    <!-- Match the document root and build the teams hierarchy -->
    <xsl:template match="/">
        <teamsHierarchy>
            <!-- Iterate through each TEAM element in the document -->
            <xsl:for-each select="CLUB/TEAMS/TEAM">
                <!-- Store the current team's ID in a variable for reusability -->
                <xsl:variable name="tId" select="ID"/>
                
                <!-- Build the team structure with ID, name, coach, and roster -->
                <team>
                    <id><xsl:value-of select="$tId"/></id>
                    <name><xsl:value-of select="NAME"/></name>
                    <coachId><xsl:value-of select="REF/@idCoach"/></coachId>
                    
                    <!-- Roster section: contains all members of the team -->
                    <roster>
                        <!-- Iterate through each MEMBER of the current team -->
                        <xsl:for-each select="MEMBERS/MEMBER">
                            <!-- Filter: only include members with GOLD membership level -->
                            <xsl:if test="MEMBERSHIPS='GOLD'">
                                <!-- Extract member details: ID, name, email, and membership level -->
                                <member>
                                    <id><xsl:value-of select="ID"/></id>
                                    <name><xsl:value-of select="NAME"/></name>
                                    <email><xsl:value-of select="EMAIL"/></email>
                                    <membership><xsl:value-of select="MEMBERSHIPS"/></membership>
                                </member>
                            </xsl:if>
                        </xsl:for-each>
                    </roster>
                </team>
            </xsl:for-each>
        </teamsHierarchy>
    </xsl:template>

</xsl:stylesheet>