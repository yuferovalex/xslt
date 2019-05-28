<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

<html>
<head>
    <meta charset="utf-8"/>
    <title>
        <xsl:value-of select="cv/lastName"/>
        <xsl:value-of select="' '"/>
        <xsl:value-of select="cv/firstName"/>
    </title>
    <link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>
    <table class="main-table">
		<tr>
			<td class="col first-col">
				<h1>
                    <xsl:value-of select="cv/lastName"/><br/>
                    <xsl:value-of select="cv/firstName"/>
                </h1>
			</td>
			<td></td>
		</tr>
        <tr>
            <td class="col first-col">	
                <!-- Дефолтная Фотка -->
                <xsl:if test="not(boolean(cv/photo))">
                    <img class="photo" src="default-user-img.jpg" alt="photo"/>
                </xsl:if>
                <!-- Фотка -->
				<xsl:if test="boolean(cv/photo)">
                    <xsl:element name="img">
                        <xsl:attribute name="src">
                            <xsl:value-of select="cv/photo/@href"/>
                        </xsl:attribute>
                        <xsl:attribute name="class">
                            <xsl:value-of select="'photo'"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:if>
                
                <!-- Основные данные -->
				<p>
					<xsl:value-of select="cv/birthdate"/><br/>
					<xsl:value-of select="cv/sex"/><br/>
                    <xsl:value-of select="cv/status"/>
				</p>
				<p class="border-dashed">
                    г. <xsl:value-of select="cv/address/city"/>,<br/>
					ул. <xsl:value-of select="cv/address/street"/>, д. <xsl:value-of select="cv/address/house"/>,<br/>
                    кв. <xsl:value-of select="cv/address/flat"/><br/>
					<xsl:value-of select="cv/contacts/phone"/><br/>
					<xsl:value-of select="cv/contacts/email"/><br/>
                    <!-- Ссылка на профиль в соц.сети -->
                    <xsl:for-each select="cv/contacts/smedia">
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="text()"/>
                            </xsl:attribute>
                            <xsl:value-of select="text()"/>
                        </xsl:element>
                        <br/>
                    </xsl:for-each>
				</p>
			</td>
            <td class="col second-col">
                <!-- Вакансия -->
                <div>
                    <h2>Objective</h2>
                    <p><xsl:value-of select="cv/objective/position"/>, <xsl:value-of select="cv/objective/salary"/> руб.</p>
                </div>
                
                <!-- Образование -->
                <xsl:if test="boolean(cv/educations) and count(cv/educations/education) &gt; 0">
                    <div>
                        <h2>Education</h2>
                        <xsl:for-each select="cv/educations/education">
                        <p>
                            <xsl:value-of select="@from"/>
                            <xsl:if test="boolean(@to)">
                                - 
                                <xsl:value-of select="@to"/>
                            </xsl:if>, <xsl:value-of select="institution"/>
                            <ul>
                                <li>Degree: <xsl:value-of select="@type"/></li>
                                <li>Program: <xsl:value-of select="program"/></li>
                            </ul>
                        </p>
                        </xsl:for-each>
                    </div>
                </xsl:if>
                
                <!-- Умения -->
                <div>
                    <h2>Skills</h2>
                    <xsl:if test="boolean(cv/skills/systems) and count(cv/skills/systems/system) &gt; 0">
                        <p>
                            <h3>Operating Systems</h3>
                            <ul>
                            <xsl:for-each select="cv/skills/systems/system">
                                <li><xsl:value-of select="text()"/></li>
                            </xsl:for-each>
                            </ul>
                        </p>
                    </xsl:if>
                    <xsl:if test="boolean(cv/skills/environments) and count(cv/skills/environments/environment) &gt; 0">
                        <p>
                            <h3>Programming Environments</h3>
                            <ul>
                            <xsl:for-each select="cv/skills/environments/environment">
                                <li><xsl:value-of select="text()"/></li>
                            </xsl:for-each>
                            </ul>
                        </p>
                    </xsl:if>
                    <xsl:if test="boolean(cv/skills/programmingLanguages) and count(cv/skills/programmingLanguages/language) &gt; 0">
                        <p>
                            <h3>Programming Languages</h3>
                            <ul>
                            <xsl:for-each select="cv/skills/programmingLanguages/language">
                                <li><xsl:value-of select="text()"/></li>
                            </xsl:for-each>
                            </ul>
                        </p>
                    </xsl:if>
                    <xsl:if test="boolean(cv/skills/platforms) and count(cv/skills/platforms/platform) &gt; 0">
                        <p>
                            <h3>Hardware Platforms</h3>
                            <ul>
                            <xsl:for-each select="cv/skills/platforms/platform">
                                <li><xsl:value-of select="text()"/></li>
                            </xsl:for-each>
                            </ul>
                        </p>
                    </xsl:if>
                </div>
                
                <!-- Языки -->
                <xsl:if test="boolean(cv/skills/systems) and count(cv/skills/systems/system) &gt; 0">
                    <div>
                        <h2>Languages</h2>
                        <p>
                            <ul>
                            <xsl:for-each select="cv/languages/language">
                                <li><xsl:value-of select="text()"/></li>
                            </xsl:for-each>
                            </ul>
                        </p>
                    </div>
                </xsl:if>
                
                <!-- Опыт -->
                <xsl:if test="boolean(cv/experience) and count(cv/experience/case) &gt; 0">
                    <div>
                        <h2>Experience</h2>
                        <p>
                            <ul>
                                <xsl:for-each select="cv/experience/case">
                                    <li> 
                                        <xsl:value-of select="@from"/> 
                                        <xsl:if test="boolean(@to)">
                                            - 
                                            <xsl:value-of select="@to"/>
                                        </xsl:if>
                                        <xsl:value-of select="concat(' ', position, ', ', company)"/>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </p>
                    </div>
                </xsl:if>
            </td>
        </tr>
    </table>
</body>
</html>    

</xsl:template>

</xsl:stylesheet>