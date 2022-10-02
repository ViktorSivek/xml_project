<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    >
    
    <sch:ns prefix="s" uri="urn:vse.cz:LEC2022:sivv01"/>
    <sch:ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
    
    <sch:pattern>
        <sch:title>Validace data narození</sch:title>
        <sch:rule context="s:LEC/s:tym/s:hraci/s:hrac/s:informace">
            <sch:assert test="s:narozen &lt; current-date()">Hráč se musel narodit dříve, než dnes!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>Validace počtu her</sch:title>
        <sch:rule context="s:LEC/s:tym/s:hraci/s:hrac/s:statitiky">
            <sch:assert test="@pocetHer &lt; s:LEC/s:tym[1]/s:hraci/s:hrac/s:statistiky/@pocetHer +1">Nikdo nemohl odehrát více zápasů než první tým!</sch:assert>
            <sch:assert test="@pocetHer &gt; s:LEC/s:tym[4]/s:hraci/s:hrac/s:statistiky/@pocetHer -1">Nikdo nemohl odehrát méně zápasů než poslední tým!</sch:assert>
        </sch:rule>
    </sch:pattern>
    

    
</sch:schema>