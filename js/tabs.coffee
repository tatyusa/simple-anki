do(w=window)->
  tabs = 
    init: ->
      self = this;
      self.tabFunctions = {}
      self.setContentsHide()
      $("nav.nav-tabs li a").each ->
        $(this).click (e)->
          e.preventDefault()
          $("nav.nav-tabs li a").each ->
            $(this).removeClass "active"
          $(this).addClass "active"
          self.setContentsHide()
    setContentsHide: ->
      self = this
      $("nav.nav-tabs li a").each ->
        if $(this).hasClass "active"
          tab_id = $(this).attr("href")
          $(tab_id).show()
          if(tab_id of self.tabFunctions)
            self.tabFunctions[tab_id]()
        else
          $($(this).attr("href")).hide()
    setTabFunction: (name, func)->
      this.tabFunctions[name] = func

  w.tabs = tabs