<?xml version="1.0" encoding="UTF-8"?>
<!--
/**
 * @author Thibault NORMAND (thibault.normand (a) gmail com)
 * @created 2011-07-10
 * @version 0.1
 */
-->
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;">
]>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:zorg="http://about.zenithar.org">

	<xsl:output
		 method="xml"
		 doctype-system="about:legacy-compat"
		 encoding="UTF-8"
		 indent="yes" />
	
	<xsl:param name="OutLang">fr</xsl:param>
	
	<!-- Functions -->
	<xsl:template name="formatDate">
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
   			<xsl:value-of select="."/>
  		</xsl:if>
 	</xsl:template>
	
	<!-- Professional Summary -->
	<xsl:template match="zorg:cv/zorg:professionalSummary">
		<xsl:for-each select="zorg:company">
		
		<article class="experience">
			<div class="article_title">
				<div class="title">
					<span class="job-org"><xsl:value-of select="zorg:name" /></span>
				</div>
				<div class="location">
					<span class="city"><xsl:value-of select="zorg:location/zorg:city" /></span> - <span class="country"><xsl:value-of select="zorg:location/zorg:country" /></span>
				</div>
			</div>
			<xsl:for-each select="zorg:positions/zorg:position">
			<div class="article_subtitle">
				<div style="float:left">
					<span class="job-name"><xsl:value-of select="zorg:title/zorg:i18n" /></span>
				</div>
				<div style="float: right;">
					<span class="from"><xsl:call-template name="formatDate"><xsl:with-param name="format" select="'other'" /><xsl:with-param name="date" select="zorg:dateIn" /></xsl:call-template></span> - 
					<span class="to"><xsl:call-template name="formatDate"><xsl:with-param name="date" select="zorg:dateOut" /></xsl:call-template></span>
				</div>
			</div>
			<div class="content">
				<ul>
				<xsl:for-each select="zorg:activities/zorg:item">
					<li><xsl:apply-templates select="zorg:i18n" /></li>
				</xsl:for-each>
				</ul>
			</div>
			</xsl:for-each>
		</article>
		
		</xsl:for-each>
	</xsl:template>
	
	<!-- School Summary -->
	<xsl:template match="zorg:cv/zorg:schoolSummary">
		<xsl:for-each select="zorg:school">
		
		<article class="formation">
			<div class="article_title">
				<div class="title">
					<span class="school-name"><xsl:value-of select="zorg:name" /></span>
				</div>
				<div class="location">
					<span class="city"><xsl:value-of select="zorg:location/zorg:city" /></span> - <span class="country"><xsl:value-of select="zorg:location/zorg:country" /></span>
				</div>
			</div>
			<xsl:for-each select="zorg:diplomas/zorg:diploma">
			<div class="article_subtitle">
				<div style="float:left">
					<span class="job-name"><xsl:value-of select="zorg:title" /></span>
				</div>
				<div style="float: right;">
					<span class="from"><xsl:call-template name="formatDate"><xsl:with-param name="format" select="'other'" /><xsl:with-param name="date" select="zorg:dateIn" /></xsl:call-template></span> - 
					<span class="to"><xsl:call-template name="formatDate"><xsl:with-param name="date" select="zorg:dateOut" /></xsl:call-template></span>
				</div>
			</div>
			<div class="content">
				<ul>
					<li><xsl:value-of select="zorg:course" /></li>
				</ul>
			</div>
			</xsl:for-each>
		</article>

		</xsl:for-each>
	</xsl:template>
		
	<!-- Qualifications -->
	<xsl:template match="zorg:cv/zorg:qualifications">
		<xsl:for-each select="zorg:qualification">
		<article class="formation">
			<div class="article_title">
				<div class="title">
					<span class="skill-category"><xsl:value-of select="@name" /></span>
				</div>
			</div>
			<div class="article_subtitle">&nbsp;</div>
			<div class="content">
				<ul>
        	<xsl:for-each select="zorg:item">
					<li><xsl:value-of select="." /></li>
			</xsl:for-each>
				</ul>
			</div>
		</article>
		</xsl:for-each>
	</xsl:template>
			
	<!-- ************************************************************************************************* -->
	<!-- Cv -->
	
	<xsl:template match="/">
<html>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Zenithar.org</title>
    <meta name="description" content="Thibault NORMAND (Blog, CV, et le reste)" />
	
	<meta itemprop="name" content="Zenithar.org" />
	<meta itemprop="description" content="Thibault NORMAND (Blog, CV, et le reste)" />

	<meta property="og:type" content="website" />
    <meta property="og:title" content="Zenithar.org" />
    <meta property="og:description" content="Thibault NORMAND (Blog, CV, et le reste)" />
    <meta property="og:url" content="http://zenithar.org" />
    <meta property="og:locale" content="fr" />

    <meta property="twitter:card" content="summary" />
    <meta property="twitter:title" content="Zenithar.org" />
    <meta property="twitter:description" content="Thibault NORMAND (Blog, CV, et le reste)" />
    <meta property="twitter:creator" content="@zenithar" />
    <meta property="twitter:site" content="@zenithar" />

    <meta property="profile:first_name" content="Thibault" />
    <meta property="profile:last_name" content="Normand" />
    <meta property="profile:gender" content="male" />
    <meta property="profile:username" content="zenithar" />

    <link rel="canonical" href="http://zenithar.org" />

	<script src="js/modernizr-1.7.min.js">//</script>   
    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/css3.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/general.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    
	<link rel="stylesheet" type="text/css" href="css/style.css" media="screen" />
	
    <script src="js/jquery.js" type="text/javascript" charset="utf-8">//</script>
	<script src="js/cvcard.js" type="text/javascript" charset="utf-8">//</script>
</head>

<body class="fontface">
	<header>
		<nav>
			<div id="menus" class="row">
				<div id="navigation" class="col_13 col">
					<ul class="">
						<li class="selected"><a href="#about">A propos</a></li>
						<li><a href="#professional">Expérience</a></li>
						<li><a href="#education">Formation</a></li>
						<li class="last"><a href="#skills">Compétences</a></li>
					</ul>
				</div>
				<div class="file col">
					<ul>
						<li class="last pdf"><a href="cv-fr.pdf">&nbsp;</a></li>
					</ul>
				</div>
			</div>
		</nav>
				
	</header>
	
	<div class="row">
		<img src="img/head.png" class="logo" alt="Thibault NORMAND" />
	</div>
	
	<div id="content" class="row">
		<!-- About -->
		<section id="about">
			<div class="resume col_8 col">
				<xsl:apply-templates select="zorg:cv/zorg:resume/zorg:i18n" />
			</div>
			<div class="col_4 col">
				<ul class="social">
					<li class="facebook"><a href="http://www.facebook.com/zenithar" rel="me">Facebook</a></li>
					<li class="twitter"><a href="http://twitter.com/zenithar" rel="me">Twitter</a></li>
					<li class="googleplus"><a href="https://plus.google.com/+ThibaultNormand/" rel="author">Google+</a></li>
				</ul>
			</div>
			<div class="col_4 col">
				<ul class="social">
					<li class="email"><a href="http://www.google.com/recaptcha/mailhide/d?k=01IIc-s5LNYiS-CG_gthn4PA==&amp;c=r5Ctx8RMDz422qmYESfk1g==">Email</a></li>
					<li class="blog"><a href="http://blog.zenithar.org" rel="me">Blog</a></li>
					<li class="rss"><a href="http://feeds.feedburner.com/ZenitharOrg" rel="me">Rss</a></li>
				</ul>
			</div>
		</section>

        <!-- Professional -->
		<section id="professional">
        <xsl:apply-templates select="zorg:cv/zorg:professionalSummary" />
		</section>
        <!-- /Professional -->
		
    		
    	<!-- Formations -->
		<section id="education">
		<xsl:apply-templates select="zorg:cv/zorg:schoolSummary" />
		</section>
        <!-- /Formations -->
		      				
		<!-- competences / skills -->
		<section id="skills" class="hidden">
        <xsl:apply-templates select="zorg:cv/zorg:qualifications" />
		</section>
		<!-- competences / skills -->
	</div>
	
	<footer class="row">
		<p><a rel="me" href="http://zenithar.org">http://zenithar.org</a></p>
	</footer>
</body>

</html>

	</xsl:template>
	
</xsl:stylesheet>