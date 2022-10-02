<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:s="urn:vse.cz:LEC2022:sivv01"
    exclude-result-prefixes="xs s"
    version="2.0">
    
    <xsl:output method="html" encoding="UTF-8" version="5"/>
    <xsl:output name="html5" method="html" encoding="UTF-8" version="5"/>
    
    <xsl:template match="/">
        <html lang="cs">
            <head>
                <title>LEC 2022</title>
                <link rel="stylesheet" href="LEC_2022_style.css"/>
            </head>
            <body>
                <xsl:apply-templates select="s:LEC"/>
            </body>
        </html>    
    </xsl:template>
    
    <xsl:template match="s:LEC">
        <header>
            <div class="text_center">
                <img src="logo.jpg"/>
                <div class="margin">
                    <h1>Ročník <xsl:apply-templates select="@rok"/></h1>
                </div>               
            </div>
        </header>
        <main>
            <xsl:apply-templates select="s:tym"/>            
        </main>
    </xsl:template>
    
    <xsl:template match="s:tym">      
        <table class="table1">
            <thead>
                <title>Tymy</title>
            </thead>
            <tbody>
                <tr>
                    <th class="t1">Umístění</th>
                    <th class="t1">Název</th>
                    <th class="t1">Logo</th>
                    <th class="t1">Informace</th>
                </tr>
                
                <tr>
                    <td class="t1"><xsl:apply-templates select="@umisteni"/></td>
                    <td class="t1"><xsl:apply-templates select="s:informace/s:nazev"/></td>
                    
                    <td class="t1">
                        <img>
                        <xsl:attribute name="src">
                            <xsl:value-of select="s:informace/s:obrazek/@image"/>
                        </xsl:attribute>
                        </img>
                    </td>
                    
                    <td class="t1"><a href="tymy/{@umisteni}.html">Podrobnosti</a></td>
                </tr>
                
                <xsl:result-document href="tymy/{@umisteni}.html" format="html5">
                    <html lang="cs">
                        <head>
                            
                            <link rel="stylesheet" href="../LEC_2022_style.css"/>

                        </head>
                        <body>
                            <xsl:apply-templates select="s:informace"/>
                            <xsl:apply-templates select="s:hraci/s:hrac[@role= 'horní']"/>
                            <xsl:apply-templates select="s:hraci/s:hrac[@role= 'džungle']"/>
                            <xsl:apply-templates select="s:hraci/s:hrac[@role= 'středová']"/>
                            <xsl:apply-templates select="s:hraci/s:hrac[@role= 'spodní']"/>
                            <xsl:apply-templates select="s:hraci/s:hrac[@role= 'podpora']"/>
                        </body>
                    </html>
                </xsl:result-document>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="s:informace">
        <header>
            <title>LEC 2022</title>
            <link rel="stylesheet" href="LEC_2022_style.css"/>
        </header>
        <main>
            
            <div class="text_center">
                <img src="../logo2.jpg"/>               
            </div>               
            
            <div class="text_left margin stredni">
                <a href="../index.html">Zpět</a>
            </div>
            <div class="text_center margin velke">
                <h1><xsl:apply-templates select="s:nazev"/></h1>
            </div>
            <h2 class="text_center margin stredni">Základní informace</h2>
            <table class="table2">
                <thead>
                    <tr>
                        <th class="t2">Sídlo</th>
                        <th class="t2">Vlastník</th>
                        <th class="t2">Založení</th>
                        <th class="t2">Partneři</th>
                        <th class="t2">Web</th>
                    </tr>
                </thead>
                <tbody>                 
                    <tr>
                        <td class="t2"><xsl:apply-templates select="s:sidlo"/></td>
                        <td class="t2"><xsl:apply-templates select="s:vlastnik"/></td>
                        <td class="t2"><xsl:apply-templates select="s:zalozeni"/></td>
                        <td class="t2"><xsl:apply-templates select="s:partneri"/></td>
                        <td class="t2"><xsl:apply-templates select="s:web"/></td>
                    </tr>
                </tbody>
            </table>
            <h2 class="text_center margin stredni">Hráči</h2>
        </main>
    </xsl:template>
    
    <xsl:template match="s:hraci/s:hrac[@role= 'horní']">
        <header>
            <title>LEC 2022</title>
            <link rel="stylesheet" href="LEC_2022_style.css"/>
        </header>
        <main>
            <h2 class="text_center margin">Horní</h2>
            <table class="table2">
                <thead>
                    <tr>
                        <th class="t2">Role</th>
                        <th class="t2">Přezdívka</th>
                        <th class="t2">Jméno</th>                        
                        <th class="t2">Národnost</th>
                        <th class="t2">Věk</th> 
                        <th class="t2">Pocet her</th>
                    </tr>
                    
                    <xsl:variable name="Vek" select="s:informace/s:narozen"/>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="@role"/></td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:prezdivka"/></td>                       
                        <td class="t2">
                            <xsl:apply-templates select="s:informace/s:jmeno"/>
                            <xsl:text> </xsl:text>
                            <xsl:apply-templates select="s:informace/s:prijmeni"/>
                        </td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:narodnost"/></td>
                        <xsl:choose>
                            <xsl:when
                                test="month-from-date(current-date()) > month-from-date($Vek) or month-from-date(current-date()) = month-from-date($Vek) and day-from-date(current-date()) >= day-from-date($Vek)">
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek)"
                                    />
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek) - 1"
                                    />
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>                
                        <td class="t2"><xsl:apply-templates select="s:statistiky/@pocetHer"/></td>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>                        
                        <th class="t2">Zabití</th>
                        <th class="t2">Smrti</th>
                        <th class="t2">Asistence</th>
                        <th class="t2">Farma/minuta</th>
                        <th class="t2">Zlato/minuta</th>
                        <th class="t2">Šampioni</th>
                    </tr>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zabiti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:smrti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:asistence"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:farmaZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zlatoZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:sampioni"/></td>                       
                    </tr>
                </tbody>
            </table>
        </main>
    </xsl:template>
    
    <xsl:template match="s:hraci/s:hrac[@role= 'džungle']">
        <header>
            <title>LEC 2022</title>
            <link rel="stylesheet" href="LEC_2022_style.css"/>
        </header>
        <main>
            <h2 class="text_center margin">Džungle</h2>
            <table class="table2">
                <thead>
                    <tr>
                        <th class="t2">Role</th>
                        <th class="t2">Přezdívka</th>
                        <th class="t2">Jméno</th>                        
                        <th class="t2">Národnost</th>
                        <th class="t2">Věk</th> 
                        <th class="t2">Pocet her</th>
                    </tr>
                    
                    <xsl:variable name="Vek" select="s:informace/s:narozen"/>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="@role"/></td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:prezdivka"/></td>                       
                        <td class="t2">
                            <xsl:apply-templates select="s:informace/s:jmeno"/>
                            <xsl:text> </xsl:text>
                            <xsl:apply-templates select="s:informace/s:prijmeni"/>
                        </td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:narodnost"/></td>
                        <xsl:choose>
                            <xsl:when
                                test="month-from-date(current-date()) > month-from-date($Vek) or month-from-date(current-date()) = month-from-date($Vek) and day-from-date(current-date()) >= day-from-date($Vek)">
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek)"
                                    />
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek) - 1"
                                    />
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>                
                        <td class="t2"><xsl:apply-templates select="s:statistiky/@pocetHer"/></td>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>                        
                        <th class="t2">Zabití</th>
                        <th class="t2">Smrti</th>
                        <th class="t2">Asistence</th>
                        <th class="t2">Farma/minuta</th>
                        <th class="t2">Zlato/minuta</th>
                        <th class="t2">Šampioni</th>
                    </tr>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zabiti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:smrti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:asistence"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:farmaZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zlatoZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:sampioni"/></td>                       
                    </tr>
                </tbody>
            </table>
        </main>
    </xsl:template>
    
    <xsl:template match="s:hraci/s:hrac[@role= 'středová']">
        <header>
            <title>LEC 2022</title>
            <link rel="stylesheet" href="LEC_2022_style.css"/>
        </header>
        <main>
            <h2 class="text_center margin">Středová</h2>
            <table class="table2">
                <thead>
                    <tr>
                        <th class="t2">Role</th>
                        <th class="t2">Přezdívka</th>
                        <th class="t2">Jméno</th>                        
                        <th class="t2">Národnost</th>
                        <th class="t2">Věk</th> 
                        <th class="t2">Pocet her</th>
                    </tr>
                    
                    <xsl:variable name="Vek" select="s:informace/s:narozen"/>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="@role"/></td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:prezdivka"/></td>                       
                        <td class="t2">
                            <xsl:apply-templates select="s:informace/s:jmeno"/>
                            <xsl:text> </xsl:text>
                            <xsl:apply-templates select="s:informace/s:prijmeni"/>
                        </td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:narodnost"/></td>
                        <xsl:choose>
                            <xsl:when
                                test="month-from-date(current-date()) > month-from-date($Vek) or month-from-date(current-date()) = month-from-date($Vek) and day-from-date(current-date()) >= day-from-date($Vek)">
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek)"
                                    />
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek) - 1"
                                    />
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>  
                        <td class="t2"><xsl:apply-templates select="s:statistiky/@pocetHer"/></td>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>                        
                        <th class="t2">Zabití</th>
                        <th class="t2">Smrti</th>
                        <th class="t2">Asistence</th>
                        <th class="t2">Farma/minuta</th>
                        <th class="t2">Zlato/minuta</th>
                        <th class="t2">Šampioni</th>
                    </tr>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zabiti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:smrti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:asistence"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:farmaZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zlatoZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:sampioni"/></td>                       
                    </tr>
                </tbody>
            </table>
        </main>
    </xsl:template>
    
    <xsl:template match="s:hraci/s:hrac[@role= 'spodní']">
        <header>
            <title>LEC 2022</title>
            <link rel="stylesheet" href="LEC_2022_style.css"/>
        </header>
        <main>
            <h2 class="text_center margin">Spodní</h2>
            <table class="table2">
                <thead>
                    <tr>
                        <th class="t2">Role</th>
                        <th class="t2">Přezdívka</th>
                        <th class="t2">Jméno</th>                        
                        <th class="t2">Národnost</th>
                        <th class="t2">Věk</th> 
                        <th class="t2">Pocet her</th>
                    </tr>
                    
                    <xsl:variable name="Vek" select="s:informace/s:narozen"/>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="@role"/></td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:prezdivka"/></td>                       
                        <td class="t2">
                            <xsl:apply-templates select="s:informace/s:jmeno"/>
                            <xsl:text> </xsl:text>
                            <xsl:apply-templates select="s:informace/s:prijmeni"/>
                        </td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:narodnost"/></td>
                        <xsl:choose>
                            <xsl:when
                                test="month-from-date(current-date()) > month-from-date($Vek) or month-from-date(current-date()) = month-from-date($Vek) and day-from-date(current-date()) >= day-from-date($Vek)">
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek)"
                                    />
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek) - 1"
                                    />
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>  
                        <td class="t2"><xsl:apply-templates select="s:statistiky/@pocetHer"/></td>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>                        
                        <th class="t2">Zabití</th>
                        <th class="t2">Smrti</th>
                        <th class="t2">Asistence</th>
                        <th class="t2">Farma/minuta</th>
                        <th class="t2">Zlato/minuta</th>
                        <th class="t2">Šampioni</th>
                    </tr>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zabiti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:smrti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:asistence"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:farmaZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zlatoZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:sampioni"/></td>                       
                    </tr>
                </tbody>
            </table>
        </main>
    </xsl:template>
    
    <xsl:template match="s:hraci/s:hrac[@role= 'podpora']">
        <header>
            <title>LEC 2022</title>
            <link rel="stylesheet" href="LEC_2022_style.css"/>
        </header>
        <main>
            <h2 class="text_center margin">Podpora</h2>
            <table class="table2">
                <thead>
                    <tr>
                        <th class="t2">Role</th>
                        <th class="t2">Přezdívka</th>
                        <th class="t2">Jméno</th>                        
                        <th class="t2">Národnost</th>
                        <th class="t2">Věk</th> 
                        <th class="t2">Pocet her</th>
                    </tr>
                    
                    <xsl:variable name="Vek" select="s:informace/s:narozen"/>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="@role"/></td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:prezdivka"/></td>                       
                        <td class="t2">
                            <xsl:apply-templates select="s:informace/s:jmeno"/>
                            <xsl:text> </xsl:text>
                            <xsl:apply-templates select="s:informace/s:prijmeni"/>
                        </td>
                        <td class="t2"><xsl:apply-templates select="s:informace/s:narodnost"/></td>
                        <xsl:choose>
                            <xsl:when
                                test="month-from-date(current-date()) > month-from-date($Vek) or month-from-date(current-date()) = month-from-date($Vek) and day-from-date(current-date()) >= day-from-date($Vek)">
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek)"
                                    />
                                </td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td>
                                    <xsl:value-of
                                        select="year-from-date(current-date()) - year-from-date($Vek) - 1"
                                    />
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>  
                        <td class="t2"><xsl:apply-templates select="s:statistiky/@pocetHer"/></td>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>                        
                        <th class="t2">Zabití</th>
                        <th class="t2">Smrti</th>
                        <th class="t2">Asistence</th>
                        <th class="t2">Farma/minuta</th>
                        <th class="t2">Zlato/minuta</th>
                        <th class="t2">Šampioni</th>
                    </tr>
                    
                    <tr>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zabiti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:smrti"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:asistence"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:farmaZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:zlatoZaMinutu"/></td>
                        <td class="t2"><xsl:apply-templates select="s:statistiky/s:sampioni"/></td>                       
                    </tr>
                </tbody>
            </table>
        </main>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>