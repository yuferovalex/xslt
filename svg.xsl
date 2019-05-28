<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="arrow_top" select="100"/>
  <xsl:variable name="arrow_bottom" select="300"/>
  <xsl:variable name="arrow_padding" select="30"/>
  
  <xsl:variable name="legend_left" select="230"/>
  <xsl:variable name="legend_square_size" select="10"/>
  <xsl:variable name="legend_padding" select="30"/>
  <xsl:variable name="legend_text_padding" select="10"/>

  <xsl:variable name="edu_count" select="count(cv/educations/education)" />
  <xsl:variable name="legend_top" select="$arrow_top + ($arrow_bottom - $arrow_top - $edu_count * ($legend_padding)) div 2"/>  

  <xsl:variable name="min_year">
    <xsl:for-each select="cv/educations/education/@from">
      <xsl:sort select="." data-type="number" order="ascending"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="current()"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="max_year">
    <xsl:for-each select="cv/educations/education/@to">
      <xsl:sort select="." data-type="number" order="descending"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="current()"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  
  <xsl:template match="/">
    <html>
      <body>
        <svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000">
          <!-- Окончание стрелки -->
          <defs>
            <marker id="arrow" refX="3.5" refY="3.5" markerWidth="10" markerHeight="10" orient="auto">
              <path d="M 0 0 L 7 3.5 L 0 7 z"/>
            </marker>
          </defs>

          <xsl:for-each select="cv/educations/education">
            <xsl:sort select="@to" order="descending"/>

            <xsl:variable name="top" select="$arrow_bottom - $arrow_padding - ($arrow_bottom - $arrow_top - 2 * $arrow_padding) * (@to - $min_year) div ($max_year - $min_year)"/>
            <xsl:variable name="bottom" select="$arrow_bottom - $arrow_padding - ($arrow_bottom - $arrow_top - 2 * $arrow_padding) * (@from - $min_year) div ($max_year - $min_year)"/>
            <xsl:variable name="height" select="$bottom - $top"/>
            <xsl:variable name="color">
              <xsl:choose>
                <xsl:when test="(position() = 1)">
                  <xsl:text>#fdae45</xsl:text>
                </xsl:when>
                <xsl:when test="(position() = 2)">
                  <xsl:text>#ebf28a</xsl:text>
                </xsl:when>
                <xsl:when test="(position() = 3)">
                  <xsl:text>#55efc4</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>#ffac37</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            
            <!-- Подпись конца -->
            <xsl:element name="text">
              <xsl:attribute name="text-anchor">end</xsl:attribute>
              <xsl:attribute name="x">140</xsl:attribute>
              <xsl:attribute name="y">
                <xsl:value-of select="$top"/>
              </xsl:attribute>
              <xsl:value-of select="@to"/>
            </xsl:element>

            <!-- Подпись начала -->
            <xsl:element name="text">
              <xsl:attribute name="text-anchor">end</xsl:attribute>
              <xsl:attribute name="x">140</xsl:attribute>
              <xsl:attribute name="y">
                <xsl:value-of select="$bottom"/>
              </xsl:attribute>
              <xsl:value-of select="@from"/>
            </xsl:element>

            <!-- Прямоугольник -->
            <xsl:element name="rect">
              <xsl:attribute name="x">150</xsl:attribute>
              <xsl:attribute name="width">30</xsl:attribute>
              <xsl:attribute name="y">
                <xsl:value-of select="$top"/>
              </xsl:attribute>
              <xsl:attribute name="height">
                <xsl:value-of select="$height"/>
              </xsl:attribute>
              <xsl:attribute name="fill">
                <xsl:value-of select="$color"/>
              </xsl:attribute>
              <xsl:attribute name="stroke">
                #7f7f7f
              </xsl:attribute>
            </xsl:element>
            
            <!-- Легенда квадрат -->
            <xsl:element name="rect">
              <xsl:attribute name="width">
                <xsl:value-of select="$legend_square_size"/>
              </xsl:attribute>
              <xsl:attribute name="height">
                <xsl:value-of select="$legend_square_size"/>
              </xsl:attribute>
              <xsl:attribute name="x">
                <xsl:value-of select="$legend_left"/>
              </xsl:attribute>
              <xsl:attribute name="y">
                <xsl:value-of select="$legend_top + (position() - 1) * $legend_padding"/>
              </xsl:attribute>
              <xsl:attribute name="stroke">
                #7f7f7f
              </xsl:attribute>
              <xsl:attribute name="fill">
                <xsl:value-of select="$color"/>
              </xsl:attribute>
            </xsl:element>

            <!-- Легенда текст -->
            <xsl:element name="text">
              <xsl:attribute name="x">
                <xsl:value-of select="$legend_left + $legend_square_size + $legend_text_padding"/>
              </xsl:attribute>
              <xsl:attribute name="y">
                <xsl:value-of select="$legend_top + (position() - 1) * $legend_padding + 10"/>
              </xsl:attribute>
              <xsl:value-of select="concat(program/text(), ', ', institution/text())"/>
            </xsl:element>
            
          </xsl:for-each>

          <text id="title" x="200" y="50">Education</text>
          <!-- Стрелка -->
          <path id="main_arrow" stroke="#000" stroke-width="2" marker-end="url(#arrow)" d="M150,300 L150,100"/>
        </svg>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>