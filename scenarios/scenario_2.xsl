<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Output the result as indented HTML -->
<xsl:output method="html" indent="yes"/>

<!-- Root template: matches the CLUB element -->
<xsl:template match="/CLUB">
    <html>
        <head>
            <title>Membership Statistics</title>
        </head>
        <body>

            <h1>Membership Level Summary</h1>

            <table border="1">
                <!-- Table header row -->
                <tr>
                    <th>Membership Type</th>
                    <th>Total Members</th>
                </tr>

                <!-- Count members whose MEMBERSHIPS value is GOLD -->
                <tr>
                    <td>GOLD</td>
                    <td>
                        <xsl:value-of select="count(TEAMS/TEAM/MEMBERS/MEMBER[MEMBERSHIPS='GOLD'])"/>
                    </td>
                </tr>

                <!-- Count members whose MEMBERSHIPS value is SILVER -->
                <tr>
                    <td>SILVER</td>
                    <td>
                        <xsl:value-of select="count(TEAMS/TEAM/MEMBERS/MEMBER[MEMBERSHIPS='SILVER'])"/>
                    </td>
                </tr>

                <!-- Count members whose MEMBERSHIPS value is BRONZE -->
                <tr>
                    <td>BRONZE</td>
                    <td>
                        <xsl:value-of select="count(TEAMS/TEAM/MEMBERS/MEMBER[MEMBERSHIPS='BRONZE'])"/>
                    </td>
                </tr>

            </table>

        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
