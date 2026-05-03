<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- Lookup key: fast access to TEAM nodes by their ID -->
    <xsl:key name="teamById" match="TEAM" use="ID"/>

    <!-- Output the result as indented HTML -->
    <xsl:output method="html" indent="yes"/>

    <!-- Match the document root and build the page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Competition Calendar</title>
            </head>
            <body>
                <h2>Competition Calendar</h2>
                <table border="1">
                    <!-- Table header row -->
                    <tr>
                        <th>Competition ID</th>
                        <th>Name</th>
                        <th>Date</th>
                        <th>Team</th>
                    </tr>

                    <!-- Iterate through each competition, sorted chronologically -->
                    <xsl:for-each select="CLUB/COMPETITIONS/COMPETITION">
                        <xsl:sort select="DATE" order="ascending"/>
                        <!-- Resolve the participating team via the key defined above -->
                        <xsl:variable name="team" select="key('teamById', TEAMID)"/>
                        <tr>
                            <td><xsl:value-of select="ID"/></td>
                            <td><xsl:value-of select="NAME"/></td>
                            <td><xsl:value-of select="DATE"/></td>
                            <td><xsl:value-of select="$team/NAME"/></td>
                        </tr>
                    </xsl:for-each>

                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
