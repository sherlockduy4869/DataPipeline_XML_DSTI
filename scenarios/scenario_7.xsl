<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- Output the result as indented XML -->
    <xsl:output method="xml" indent="yes"/>

    <!-- Match the CLUB element and build the public directory -->
    <xsl:template match="/CLUB">
        <publicDirectory>
            <!-- Iterate through each TEAM element in the CLUB -->
            <xsl:for-each select="TEAMS/TEAM">
                <!-- Build the team structure with ID, name, coach, and members -->
                <team>
                    <id><xsl:value-of select="ID"/></id>
                    <name><xsl:value-of select="NAME"/></name>
                    <coachId><xsl:value-of select="REF/@idCoach"/></coachId>

                    <!-- Members section: contains all members of the team -->
                    <members>
                        <!-- Iterate through each MEMBER of the current team -->
                        <xsl:for-each select="MEMBERS/MEMBER">
                            <!-- Extract member details: ID, name, email, and membership level -->
                            <member>
                                <id><xsl:value-of select="ID"/></id>
                                <name><xsl:value-of select="NAME"/></name>
                                <email><xsl:value-of select="EMAIL"/></email>
                                <membershipLevel><xsl:value-of select="MEMBERSHIPS"/></membershipLevel>
                            </member>
                        </xsl:for-each>
                    </members>
                </team>
            </xsl:for-each>
        </publicDirectory>
    </xsl:template>

</xsl:stylesheet>