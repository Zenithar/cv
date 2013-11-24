CVCard = ->

(->
  clickNav = (e) ->
    oThis = $(this)
    $(oNav.find(".current a").attr("href")).fadeOut "fast"
    oContent.stop().animate height: $(oThis.attr("href")).height(), ->
      oThis.parent("li").addClass "current"
      $(oThis.attr("href")).fadeIn()
      oThis.parent("li").siblings().removeClass("current").find("a").each ->
        $($(this).attr("href")).hide()
		
  sTabContainersSelector = "div#content > section"
  sNavSelector = "#navigation ul"
  sContentSelector = "#content"
  oTabContainers = null
  oContent = null
  oNav = null
  
  @init = ->
    oTabContainers = $(sTabContainersSelector)
    oNav = $(sNavSelector)
    oContent = $(sContentSelector)
    @initNav()
      
  @initNav = ->
    oNav.find("a").click clickNav
    oNav.find("a").each ->
      $($(this).attr("href")).hide()
    
    sHashSelector = "a[href=" + document.location.hash + "]"
    if document.location.hash and oNav.find(sHashSelector).length > 0
      oNav.find(sHashSelector).trigger "click"
    else
      oNav.find("li.selected a").trigger "click"
    $("#menus .file li").hover (->
      $(this).animate top: 0
    ), ->
      $(this).animate top: 5
).apply CVCard

$(document).ready ->
  CVCard.init()