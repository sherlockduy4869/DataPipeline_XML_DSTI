<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- Output the result as indented HTML -->
    <xsl:output method="html" indent="yes" />

    <!-- Match the document root and build the page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Team Sizes</title>
            </head>
            <body>
                <h2>Team Size Comparison</h2>
                <table border="1">
                    <!-- Table header row -->
                    <tr>
                        <th>Team Name</th>
                        <th>Number of Members</th>
                    </tr>

                    <!-- Iterate through every TEAM under CLUB/TEAMS -->
                    <xsl:for-each select="CLUB/TEAMS/TEAM">
                        <tr>
                            <!-- Team name -->
                            <td>
                                <xsl:value-of select="NAME" />
                            </td>
                            <!-- Count of MEMBER nodes in this team -->
                            <td>
                                <xsl:value-of select="count(MEMBERS/MEMBER)" />
                            </td>
                        </tr>
                    </xsl:for-each>

                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>