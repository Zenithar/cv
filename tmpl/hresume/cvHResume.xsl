<?xml version="1.0" encoding="UTF-8"?>
<!--
/**
 * @author Thibault NORMAND (thibault.normand (a) gmail com)
 * @created 2009-09-19
 * @version 0.1
 */
-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:zorg="http://about.zenithar.org"
	xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output
	    omit-xml-declaration="no"
	    method="xml"
	    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	    encoding="UTF-8"
	    indent="yes" />
	
	<xsl:param name="OutLang">fr</xsl:param>
	
	<!-- Functions -->
	<xsl:template name="formatDate" match="/">
		    <xsl:param name="date" />
		    <xsl:param name="format" />

		    <xsl:if test="$date">
		        <xsl:variable name="year"  select="substring($date, 1, 4)" />
		        <xsl:variable name="month" select="substring($date, 6, 2)" />
		        <xsl:variable name="day"   select="substring($date, 9, 2)" />
		        <xsl:choose>
		            <xsl:when test="$format = 'birthday'">
		                <xsl:value-of select="concat($day, '.', $month, '.', $year)" />
		            </xsl:when>
		            <xsl:when test="$format = 'school'">
		                <xsl:value-of select="$year" />
		            </xsl:when>
		            <xsl:otherwise>
		                <xsl:choose>
		                    <xsl:when test="$month = 1">
		                        <xsl:text>Janvier</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 2">
		                        <xsl:text>Février</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 3">
		                        <xsl:text>Mars</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 4">
		                        <xsl:text>Avril</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 5">
		                        <xsl:text>Mai</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 6">
		                        <xsl:text>Juin</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 7">
		                        <xsl:text>Juillet</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 8">
		                        <xsl:text>Aout</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 9">
		                        <xsl:text>Septembre</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 10">
		                        <xsl:text>Octobre</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 11">
		                        <xsl:text>Novembre</xsl:text>
		                    </xsl:when>
		                    <xsl:when test="$month = 12">
		                        <xsl:text>Décembre</xsl:text>
		                    </xsl:when>
		                </xsl:choose>
		                <xsl:text> </xsl:text>
		                <xsl:value-of select="$year" />
		            </xsl:otherwise>
		        </xsl:choose>
		    </xsl:if>
	</xsl:template>
	
	<xsl:template match="zorg:i18n">
  		<xsl:if test="lang($OutLang)">
   			<span xml:lang="$OutLang"><xsl:value-of select="."/></span>
  		</xsl:if>
 	</xsl:template>
		
	<!-- Personal Data -->
	<xsl:template match="zorg:cv/zorg:personalData">
		<h1 class="fn n" id="{zorg:firstName}-{zorg:lastName}-hcard">
			<a class="url" title="{zorg:url/@title}" rel="me" href="{zorg:url}">
				<span class="given-name"><xsl:value-of select="zorg:firstName" /></span> <span class="family-name"><xsl:value-of select="zorg:lastName" /></span>
			</a>
		</h1>
		
		<address class="adr">
			<span class="street-address"><xsl:value-of select="zorg:address/zorg:street" /></span> <span class="postal-code"><xsl:value-of select="zorg:address/zorg:postal" /></span>
			<span class="locality"><xsl:value-of select="zorg:address/zorg:city" /></span> - <span class="country-name"><xsl:value-of select="zorg:address/zorg:country" /></span>
	    </address>
	
	    <span class="tel">
			<abbr class="type" title="cell">Mobile :</abbr><abbr class="value" title="{zorg:phone}"><xsl:value-of select="zorg:phone" /></abbr>
		</span>
		
		<div class="email">
			<a class="email" href="mailto:{email}"><span class="value"><xsl:value-of select="zorg:email" /></span></a>
		</div>
	</xsl:template>
	
	<!-- Professional Summary -->
	<xsl:template match="zorg:cv/zorg:professionalSummary">
		<xsl:for-each select="zorg:company">
			<div class="experience vevent vcard">
        		<!-- include design pattern : hcard -->
        		<a class="include nonVisual" href="#{//zorg:cv/zorg:personalData/zorg:firstName}-{//zorg:cv/zorg:personalData/zorg:lastName}-hcard"><xsl:value-of select="concat(//zorg:cv/zorg:personalData/zorg:firstName, ' ', //zorg:cv/zorg:personalData/zorg:lastName)" /></a>
        		<!-- /include design pattern : hcard -->
        		<span class="date_duration">
        			<span class="dtstart"><span class="value-title" title="{zorg:dateIn}"><xsl:call-template name="formatDate"><xsl:with-param name="date" select="zorg:dateIn" /></xsl:call-template></span></span>
					- <span class="dtend"><span class="value-title" title="{zorg:dateOut}"><xsl:call-template name="formatDate"><xsl:with-param name="date" select="zorg:dateOut" /></xsl:call-template></span></span>
				</span>

				<span class="title summary"><xsl:apply-templates select="zorg:position/zorg:i18n" /></span> 
				<a class="fn org url" rel="me" title="zorg:name" href="{zorg:url}"><xsl:value-of select="zorg:name" /></a> 
				<span class="location"><xsl:value-of select="zorg:location" /></span>
				
				<div class="description">
					<em><xsl:apply-templates select="zorg:description/zorg:i18n" /></em>
					<ul>
                    <xsl:for-each select="zorg:activities/zorg:item">
                        <li><xsl:apply-templates select="zorg:i18n" /></li>
                    </xsl:for-each>
                    </ul>
				</div>
			</div>
		</xsl:for-each>
	</xsl:template>
	
	<!-- School Summary -->
	<xsl:template match="zorg:cv/zorg:schoolSummary">
		<xsl:for-each select="zorg:school">
			<div class="education vevent">
          		<span class="date_duration">
          			<span class="dtstart"><span class="value-title" title="{zorg:dateIn}"><xsl:call-template name="formatDate"><xsl:with-param name="format" select="'school'" /><xsl:with-param name="date" select="zorg:dateIn" /></xsl:call-template></span></span>
					- <span class="dtend"><span class="value-title" title="{zorg:dateOut}"><xsl:call-template name="formatDate"><xsl:with-param name="format" select="'school'" /><xsl:with-param name="date" select="zorg:dateOut" /></xsl:call-template></span></span>
          		</span>
          		<span class="summary">
          			<span class="vcard">
            			<a class="fn org url" title="{zorg:name/@desc}" href="{zorg:url}"><xsl:value-of select="zorg:name" /></a> 
            			<span class="location adr">
              				<span class="locality"><xsl:value-of select="zorg:location/zorg:city" /></span> - <span class="country-name"><xsl:value-of select="zorg:location/zorg:country" /></span>
          				</span>
          			</span>
          		</span>
				<div class="description">
					<em><xsl:value-of select="zorg:diploma" /></em>
					<ul>
						<li><xsl:value-of select="zorg:course" /></li>
					</ul>
				</div>
        	</div>
		</xsl:for-each>
	</xsl:template>
	
	<!-- Languages -->
	<xsl:template match="zorg:cv/zorg:languages">
		<xsl:for-each select="zorg:language">
            <li><xsl:value-of select="concat(zorg:name, ': ', zorg:level)" /></li>
        </xsl:for-each>
	</xsl:template>
	
	<!-- Qualifications -->
	<xsl:template match="zorg:cv/zorg:qualifications">
		<xsl:for-each select="zorg:qualification">
            <li class="skillarea">
				<xsl:value-of select="@name" /><br />
				<ul class="skillset">
					<xsl:for-each select="zorg:item">
						<li><xsl:value-of select="." /></li>
					</xsl:for-each>
				</ul>
			</li>
        </xsl:for-each>
	</xsl:template>
	
	<!-- Certifications -->
	<xsl:template match="zorg:cv/zorg:certifications">
		<xsl:for-each select="zorg:certification">
            <li>
				<xsl:value-of select="." />
			</li>
        </xsl:for-each>
	</xsl:template>
	
	<!-- References -->
	<xsl:template match="zorg:cv/zorg:references">
		<xsl:for-each select="zorg:reference">
            <li>
				<xsl:value-of select="zorg:lastName" />, <xsl:value-of select="zorg:firstName" /> - <em>[<xsl:value-of select="zorg:society" />]</em>
			</li>
        </xsl:for-each>
	</xsl:template>
	
	<!-- Misc -->
	<xsl:template match="zorg:cv/zorg:misc">
		<xsl:for-each select="zorg:item">
            <li>
				<xsl:value-of select="." />
			</li>
        </xsl:for-each>
	</xsl:template>
	
	<!-- ************************************************************************************************* -->
	<!-- Cv -->
	
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
		    <head profile="http://gmpg.org/xfn/11 http://microformats.org/wiki/hresume-profile/ http://dublincore.org/documents/dcq-html/ http://purl.org/uF/2008/03/">
		        <meta http-equiv='pragma' content='no-cache'/>
		        <meta http-equiv='content-type' content='text/html; charset=UTF-8'/>
		        <meta name='description' content='Thibault Normand'/>
		        <meta name='keywords' content='Thibault Normand, zenithar, Curriculum Vitae, cv'/>
		        <meta name='robots' content='ALL'/>
		        <meta name='language' content='fr-FR'/>
		
				<link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" />
				<link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" />
				
				<meta NAME="DC.Creator" content="Thibault Normand" />
				<meta NAME="DC.Title" content="Thibault NORMAND Curriculum Vitae" />
				<meta NAME="DC.Date" content="2011-01-22" />
				<meta NAME="DC.Format" content="text/html" />
				<meta NAME="DC.Language" content="fr" />
					
		        <link rel='author' href='Thibault Normand'/>
		        <link rel='home' href='http://cv.zenithar.org'/>

			  	<link href="hresume1.css" rel="stylesheet" title="hResume" type="text/css" />
			  	<link href="printhresume1.css" rel="stylesheet" title="hResume" type="text/css" media="print" />
			
				<style type="text/css">
				/*<![CDATA[*/

				  div.val-icons {position:relative}  a.val-icons {margin-left: 35%; margin-right: 3em}
				  body.hresume {font-size: 80%; }
				 .nonVisual {display:none;}

				/*]]>*/
				</style>
				
		        <title>Thibault Normand Curriculum Vitae</title>
		    </head>
		
			<body class="hresume">
				<!-- VCard -->
				<div class="vcard contact">
					<xsl:apply-templates select="zorg:cv/zorg:personalData" />
				</div>
				<!-- /VCard -->
				
				<!--Résumé -->
			  	<h2>Résumé</h2>
			  	<div class="summary">
					<em><xsl:apply-templates select="zorg:cv/zorg:resume/zorg:i18n" /></em>
			  	</div>
			
			  	<!-- expérience professionnelle -->
			  	<div class="experience">
			    	<h2>Expérience Professionnelle</h2>
					<div class="vcalendar">
						<xsl:apply-templates select="zorg:cv/zorg:professionalSummary" />
					</div>
				</div>
				
				<!-- Formation education -->
			    <div id="formation-xtof">
			    	<h2>Formation</h2>

			      	<div class="vcalendar">
						<xsl:apply-templates select="zorg:cv/zorg:schoolSummary" />
					</div>
					
				</div>
				<!-- /Formation education -->
		      
				<!-- Certification -->
			    <div>
			    	<h2>Certifications</h2>
		      		<ul>
						<xsl:apply-templates select="zorg:cv/zorg:certifications" />
					</ul>
				</div>
				<!-- /Certification -->
				
				<!-- languages -->
				<div>
		      		<h2>Langues</h2>
		      		<ul>
						<xsl:apply-templates select="zorg:cv/zorg:languages" />
					</ul>
				</div>
				<!-- /languages -->
				
				<!-- competences / skills -->
				<div>
		      		<h2>Compétences</h2>
		      		<ul class="skills">
						<xsl:apply-templates select="zorg:cv/zorg:qualifications" />
					</ul>
				</div>
				<!-- competences / skills -->
				
				<div>
					<h2>Références</h2>
					<em>Pour les coordonnées, me contacter.</em>
					<ul class="references">
						<xsl:apply-templates select="zorg:cv/zorg:references" />
					</ul>
				</div>
				
				<div class="misc">
					<h2>Autres Activités hors Curriculum</h2>
					<ul>
						<xsl:apply-templates select="zorg:cv/zorg:misc" />
					</ul>
				</div>
				
			</body>
		</html>
	</xsl:template>
	
	
</xsl:stylesheet>