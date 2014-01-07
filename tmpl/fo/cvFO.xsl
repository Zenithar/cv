<?xml version="1.0" encoding="UTF-8"?>
<!--
/**
 * @author Thibault NORMAND (thibault.normand (a) gmail com)
 * @created 2011-07-10
 * @version 0.1
 */
-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:zorg="http://about.zenithar.org"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:output
	    omit-xml-declaration="no"
	    method="xml"
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
		
	<!-- Personal Data -->
	<xsl:template match="zorg:cv/zorg:personalData">
	
	  <fo:block border-after-style="double" border-after-width="medium" font-size="200%" letter-spacing=".15em" font-variant="small-caps">
            <xsl:value-of select="concat(zorg:firstName, ' ', zorg:lastName)" />
      </fo:block>
            
      <fo:table space-before="4pt">
        <fo:table-column column-width="50%"/>
        <fo:table-column column-width="50%"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell text-align="left">
              <fo:block><xsl:value-of select="zorg:address/zorg:city" /> - <xsl:value-of select="zorg:address/zorg:country" /> &#8226; <xsl:value-of select="zorg:phone" /></fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right">
              <fo:block><fo:basic-link color="blue" text-decoration="underline" external-destination="url('mailto:{zorg:email}')"><xsl:value-of select="zorg:email" /></fo:basic-link></fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
      
	</xsl:template>
	
	<!-- Professional Summary -->
	<xsl:template match="zorg:cv/zorg:professionalSummary">
		<xsl:for-each select="zorg:company">
		
		<fo:block space-before="4pt" space-after="8pt">
        <fo:table keep-together.within-column="always">
          <fo:table-column column-number="1" column-width="66%"/>
          <fo:table-column column-number="2" column-width="34%"/>  
          <fo:table-body>
            <fo:table-row font-weight="bold">
              <fo:table-cell text-align="left">
                <fo:block><fo:basic-link external-destination="url('{zorg:url}')" text-decoration="underline"><xsl:value-of select="zorg:name" /></fo:basic-link></fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block><xsl:value-of select="zorg:location/zorg:city" /> - <xsl:value-of select="zorg:location/zorg:country" /></fo:block>
              </fo:table-cell>
            </fo:table-row>
            <xsl:for-each select="zorg:positions/zorg:position">
            <fo:table-row>
              <fo:table-cell text-align="left">
                <fo:block font-style="italic"><xsl:apply-templates select="zorg:title/zorg:i18n" /></fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block font-style="italic"><xsl:call-template name="formatDate"><xsl:with-param name="format" select="'other'" /><xsl:with-param name="date" select="zorg:dateIn" /></xsl:call-template> - <xsl:call-template name="formatDate"><xsl:with-param name="date" select="zorg:dateOut" /></xsl:call-template></fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell number-columns-spanned="2">
                 <fo:list-block margin-left="12pt">
                  <xsl:for-each select="zorg:activities/zorg:item">
                    <fo:list-item>
                      <fo:list-item-label end-indent="label-end()">
                      <fo:block>&#8250;</fo:block>
                     </fo:list-item-label>
                      <fo:list-item-body start-indent="body-start()">
                        <fo:block font-size="80%"><xsl:apply-templates select="zorg:i18n" /></fo:block>
                      </fo:list-item-body>
                    </fo:list-item>
                  </xsl:for-each>
                 </fo:list-block>
              </fo:table-cell>
            </fo:table-row>
          </xsl:for-each>
          </fo:table-body>
        </fo:table>
      </fo:block>
      
		</xsl:for-each>
	</xsl:template>
	
	<!-- School Summary -->
	<xsl:template match="zorg:cv/zorg:schoolSummary">
		<xsl:for-each select="zorg:school">
		
		  <fo:block space-before="4pt" space-after="8pt">
        <fo:table keep-together.within-column="always">
          <fo:table-column column-number="1" column-width="66%"/>
          <fo:table-column column-number="2" column-width="34%"/>
          <fo:table-body>
            <fo:table-row font-weight="bold">
              <fo:table-cell text-align="left">
                <fo:block><xsl:value-of select="zorg:name" /></fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block><xsl:value-of select="zorg:location/zorg:city" /> - <xsl:value-of select="zorg:location/zorg:country" /></fo:block>
              </fo:table-cell>
            </fo:table-row>
            <xsl:for-each select="zorg:diplomas/zorg:diploma">
            <fo:table-row>
              <fo:table-cell text-align="left">
                <fo:block font-style="italic"><xsl:value-of select="zorg:title" /></fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block><xsl:call-template name="formatDate"><xsl:with-param name="format" select="'school'" /><xsl:with-param name="date" select="zorg:dateIn" /></xsl:call-template> - <xsl:call-template name="formatDate"><xsl:with-param name="format" select="'school'" /><xsl:with-param name="date" select="zorg:dateOut" /></xsl:call-template></fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row space-before="4pt">
              <fo:table-cell number-columns-spanned="2">
                 <fo:list-block margin-left="12pt">
                  <fo:list-item>
                    <fo:list-item-label end-indent="label-end()">
                      <fo:block>&#8250;</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                      <fo:block font-size="80%"><xsl:value-of select="zorg:course" /></fo:block>
                    </fo:list-item-body>
                  </fo:list-item>
                 </fo:list-block>
              </fo:table-cell>
            </fo:table-row>
          </xsl:for-each>
          </fo:table-body>
        </fo:table>
      </fo:block>
		</xsl:for-each>
	</xsl:template>
	
	<!-- Languages -->
	<xsl:template match="zorg:cv/zorg:languages">
    <fo:list-block margin-left="12pt" font-size="80%">
		<xsl:for-each select="zorg:language">
      <fo:list-item>
        <fo:list-item-label end-indent="label-end()">
          <fo:block>&#8250;</fo:block>
        </fo:list-item-label>
        <fo:list-item-body start-indent="body-start()">
          <fo:block><xsl:value-of select="concat(zorg:name, ': ', zorg:level)" /></fo:block>
        </fo:list-item-body>
      </fo:list-item>
     </xsl:for-each>
     </fo:list-block>
	</xsl:template>
	
	<!-- Qualifications -->
	<xsl:template match="zorg:cv/zorg:qualifications">
		<xsl:for-each select="zorg:qualification">
      <fo:block space-before="4pt" font-weight="bold"><xsl:value-of select="@name" /></fo:block>
      <fo:block font-size="80%">
        	<xsl:for-each select="zorg:item">
						<xsl:value-of select="." />;
					</xsl:for-each>
			</fo:block>
    </xsl:for-each>
	</xsl:template>
	
	<!-- Certifications -->
	<xsl:template match="zorg:cv/zorg:certifications">
		<fo:list-block margin-left="12pt" font-size="80%">
		<xsl:for-each select="zorg:certification">
      <fo:list-item>
        <fo:list-item-label end-indent="label-end()">
          <fo:block>&#8250;</fo:block>
        </fo:list-item-label>
        <fo:list-item-body start-indent="body-start()">
          <fo:block><xsl:value-of select="." /></fo:block>
        </fo:list-item-body>
      </fo:list-item>
    </xsl:for-each>
    </fo:list-block>
	</xsl:template>
	
	<!-- References -->
	<xsl:template match="zorg:cv/zorg:references">
		<fo:list-block margin-left="12pt">
		<xsl:for-each select="zorg:reference">
      <fo:list-item>
        <fo:list-item-label end-indent="label-end()">
          <fo:block>&#8250;</fo:block>
        </fo:list-item-label>
        <fo:list-item-body start-indent="body-start()">
          <fo:block><xsl:value-of select="zorg:lastName" />, <xsl:value-of select="zorg:firstName" /> - <fo:inline font-style="italic">[<xsl:value-of select="zorg:society" />]</fo:inline></fo:block>
        </fo:list-item-body>
      </fo:list-item>
    </xsl:for-each>
    </fo:list-block>
	</xsl:template>
	
	<!-- Misc -->
	<xsl:template match="zorg:cv/zorg:misc">
		<fo:list-block margin-left="12pt">
		<xsl:for-each select="zorg:item">
      <fo:list-item>
        <fo:list-item-label end-indent="label-end()">
          <fo:block>&#8250;</fo:block>
        </fo:list-item-label>
        <fo:list-item-body start-indent="body-start()">
          <fo:block><xsl:value-of select="." /></fo:block>
        </fo:list-item-body>
      </fo:list-item>
    </xsl:for-each>
    </fo:list-block>
	</xsl:template>
	
	<!-- ************************************************************************************************* -->
	<!-- Cv -->
	
	<xsl:template match="/">
    <fo:root writing-mode="lr-tb" xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <fo:layout-master-set>
      <fo:simple-page-master master-name="A4" page-width="210mm" page-height="297mm" margin-top="1cm" margin-bottom="1cm"
    margin-left="1cm" margin-right="1cm">
          <fo:region-body margin-bottom="20mm"/>
          <fo:region-after region-name="page-footer" extent="30mm" display-align="after"/>
      </fo:simple-page-master>
    </fo:layout-master-set>

    <fo:page-sequence master-reference="A4">
      <fo:static-content flow-name="page-footer">
        <fo:block font-size="6pt" text-align="center" space-after.conditionality="retain" space-after="0.25in">
          <fo:block space-before="0.67em" border="1px solid" space-before.minimum="0.5em" space-before.optimum="0.67em" space-before.maximum="0.92em" space-after.minimum="0.5em" space-after.optimum="0.67em" space-after.maximum="0.92em" />
          
          <fo:table>
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="50%"/>
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell text-align="left">
                  <fo:block>
                    <fo:basic-link external-destination="url('http://zenithar.org/')">http://zenithar.org/</fo:basic-link>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell text-align="right">
                  <fo:block><fo:page-number /> / <fo:page-number-citation ref-id="last-page-marker" /></fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:block>
      </fo:static-content>

		  <fo:flow flow-name="xsl-region-body" font-size="80%">
  
        <!-- Header -->
        <fo:block-container>
             <xsl:apply-templates select="zorg:cv/zorg:personalData" />
        </fo:block-container>
        <!-- /Header -->
				
        <!-- Title -->
        <fo:block-container space-before="12pt" id="title">
          <fo:block text-align="center" font-weight="bold" space-before="4pt" space-after="0pt" font-size="150%">
            <xsl:apply-templates select="zorg:cv/zorg:title/zorg:i18n" />
          </fo:block>
        </fo:block-container>
        <!-- /Title -->

        <!-- Résumé -->
        <fo:block-container space-before="4pt" id="resume">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Résumé</fo:block>
          <fo:block text-align="justify" font-style="italic" space-before="4pt" space-after="8pt">
            <xsl:apply-templates select="zorg:cv/zorg:resume/zorg:i18n" />
          </fo:block>
        </fo:block-container>
        <!-- /Résumé -->
			
			  <!-- Experiences -->
        <fo:block-container space-before="12pt" id="experiences">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Expérience Professionnelle</fo:block>
          <xsl:apply-templates select="zorg:cv/zorg:professionalSummary" />
        </fo:block-container>
    		<!-- /Experiences -->
    		
    		<!-- Formations -->
        <fo:block-container space-before="12pt" id="education">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Formation</fo:block>
          <xsl:apply-templates select="zorg:cv/zorg:schoolSummary" />
        </fo:block-container>
        <!-- /Formations -->
		      
				<!-- Certification -->
				<fo:block-container space-before="12pt" id="certifications">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Certifications</fo:block>
          <fo:block space-before="4pt" space-after="8pt">
            <xsl:apply-templates select="zorg:cv/zorg:certifications" />
          </fo:block>
        </fo:block-container>
				<!-- /Certification -->
				
				<!-- languages -->
				<fo:block-container space-before="12pt" id="languages">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Langues</fo:block>
          <fo:block space-before="4pt" space-after="8pt">
            <xsl:apply-templates select="zorg:cv/zorg:languages" />
          </fo:block>
        </fo:block-container>
				<!-- /languages -->
				
				<!-- competences / skills -->
        <fo:block-container space-before="12pt" id="skills">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Compétences</fo:block>
          <fo:block space-before="4pt" space-after="8pt">
            <xsl:apply-templates select="zorg:cv/zorg:qualifications" />
          </fo:block>
        </fo:block-container>
				<!-- competences / skills -->
				
				<!-- References -->
	    <fo:block-container space-before="12pt" id="references" keep-together="always">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Références</fo:block>
          <fo:block space-before="4pt" space-after="8pt" font-size="80%">
            <xsl:apply-templates select="zorg:cv/zorg:references" />
          </fo:block>
        </fo:block-container>
        <!-- /Reference -->

				<!-- Misc -->
	    <fo:block-container space-before="12pt" id="misc" keep-together="always">
          <fo:block border-after-style="solid" border-after-width="thin" font-size="150%">Autres Activités hors Curriculum</fo:block>
          <fo:block space-before="4pt" space-after="8pt" font-size="80%">
            <xsl:apply-templates select="zorg:cv/zorg:misc" />
          </fo:block>
        </fo:block-container>
        <!-- /Misc -->
				
        <fo:block id="last-page-marker" />
      </fo:flow>
  	
    </fo:page-sequence>
  </fo:root>
  
	</xsl:template>
	
	
</xsl:stylesheet>