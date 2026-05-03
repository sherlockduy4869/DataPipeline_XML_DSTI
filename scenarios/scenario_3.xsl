<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Output the result as indented HTML -->
    <xsl:output method="html" indent="yes"/>

    <!-- Root template: matches the CLUB element -->
    <xsl:template match="/CLUB">
        <html>
            <head>
                <title>Teams and Coaches</title>
            </head>
            <body>

                <h1>Teams with Their Coaches</h1>

                <table border="1">
                    <!-- Table header row -->
                    <tr>
                        <th>Team Name</th>
                        <th>Coach Name</th>
                    </tr>

                    <!-- Iterate through every TEAM -->
                    <xsl:for-each select="TEAMS/TEAM">
                        <tr>
                            <!-- Team name -->
                            <td>
                                <xsl:value-of select="NAME"/>
                            </td>

                            <td>
                                <!-- Read the coach id referenced by this team -->
                                <xsl:variable name="coachId" select="REF/@idCoach"/>

                                <!-- Look up the COACH whose ID matches and output its NAME -->
                                <xsl:value-of select="/CLUB/COACHES/COACH[ID=$coachId]/NAME"/>
                            </td>
                        </tr>
                    </xsl:for-each>

                </table>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>