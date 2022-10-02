<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:s="urn:vse.cz:LEC2022:sivv01"
    exclude-result-prefixes="xs s"
    version="2.0">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="stranka" page-height="297mm" page-width="210mm" margin="20mm">
                    <fo:region-body/>
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="stranka" font-family="Arial">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center">
                        <xsl:text>Strana </xsl:text><fo:page-number />
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="s:LEC">
                
        <fo:block margin-top="40%" text-align="center">
            <fo:external-graphic src="url(logo.jpg)" content-width="15cm" width="100%" />
        </fo:block>
        
        <fo:block font-size="200%" font-weight="600" text-align="center" margin-top="5mm">LEC</fo:block>
        <fo:block font-size="200%" font-weight="600" text-align="center">Ročník <xsl:apply-templates select="@rok"/></fo:block>
        
        <fo:block page-break-before="always" font-size="150%" font-weight="bold" margin-top="2cm" margin-bottom="0.5cm" id='obsah'> Obsah </fo:block>
                          
        <fo:block>           
            <xsl:for-each select="/s:LEC/s:tym">
                <fo:block text-align-last="justify"  margin-top="0.5cm">
                    <fo:basic-link internal-destination="{generate-id(@umisteni)}">
                        <xsl:value-of select="s:informace/s:nazev" />
                        <fo:leader leader-pattern="dots" />
                        <fo:page-number-citation ref-id="{generate-id(@umisteni)}" />
                    </fo:basic-link>
                </fo:block>
            </xsl:for-each>     
        </fo:block>
                          
        <xsl:apply-templates select="s:tym"/>
        
    </xsl:template>
    
    <xsl:template match="s:tym">
        <fo:block page-break-before="always" font-size="150%" margin-top="1cm" margin-bottom="5mm" font-weight="bold" text-align="center" id="{generate-id(@umisteni)}">
            <xsl:apply-templates select="s:informace/s:nazev"/>
        </fo:block>
        <fo:block font-size="120%" font-weight="bold" margin-bottom="5mm">Základní informace</fo:block>
        <fo:block>
            <fo:table border-width="3px" border-color="black" border-style="solid" width="100%" >
                <fo:table-header font-size="100%" font-weight="bold" text-align="center">
                    <fo:table-row border-bottom-color="black" border-bottom-width="3px" border-bottom-style="solid" line-height="80px">
                        <fo:table-cell><fo:block>Sídlo</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Vlastník</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Založení</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Partneři</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Web</fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body font-size="80%" text-align="center">
                    <xsl:apply-templates select="s:informace"/>
                </fo:table-body>
            </fo:table>
        </fo:block>
        
        <fo:block font-size="120%" margin-bottom="5mm" margin-top="15mm" font-weight="bold">Statistiky</fo:block>
        <fo:block margin-top="5mm">
            <fo:table border-width="3px" border-color="black" border-style="solid" width="100%">
                <fo:table-header font-size="100%" font-weight="bold" text-align="center">
                    <fo:table-row border-bottom-color="black" border-bottom-width="3px" border-bottom-style="solid" line-height="80px">
                        <fo:table-cell><fo:block>Role</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Přezdívka</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Národnost</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Narozen</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Zabití</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Smrti</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Asistence</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Farma/min</fo:block></fo:table-cell>
                        <fo:table-cell><fo:block>Zlano/min</fo:block></fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body font-size="80%" text-align="center">
                    <xsl:apply-templates select="s:hraci/s:hrac"/>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="s:informace">    
        <fo:table-row border-bottom-color="black" border-bottom-width="3px" border-bottom-style="solid" line-height="80px">
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:sidlo"/> </fo:block> </fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:vlastnik"/> </fo:block> </fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:zalozeni"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:partneri"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:web"/> <fo:basic-link external-destination="url('{.}')"/> </fo:block></fo:table-cell>
        </fo:table-row>    
    </xsl:template>
    
    <xsl:template match="s:hraci/s:hrac">    
        <fo:table-row border-bottom-color="black" border-bottom-width="3px" border-bottom-style="solid" line-height="80px">
            <fo:table-cell > <fo:block> <xsl:apply-templates select="@role"/> </fo:block> </fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:informace/s:prezdivka"/> </fo:block> </fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:informace/s:narodnost"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:informace/s:narozen"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:statistiky/s:zabiti"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:statistiky/s:smrti"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:statistiky/s:asistence"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:statistiky/s:farmaZaMinutu"/> </fo:block></fo:table-cell>
            <fo:table-cell > <fo:block> <xsl:apply-templates select="s:statistiky/s:zlatoZaMinutu"/> </fo:block></fo:table-cell>
        </fo:table-row>    
    </xsl:template>
    
    
</xsl:stylesheet>