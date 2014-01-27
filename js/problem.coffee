do(w=window) ->
  problem =
    init: (input, table)->
      _input = $(input)
      _input.on "change", ->
        $("h1.title").text $(this).val()

      _table = $(table).editTable
        headerCols: ["Problem","Answer","Explain"]
        maxRows: 9999

      this.input = _input;
      this.table = _table;

    setLearningData: (data)->
      this.input.val(data.title).change()
      this.table.loadData this.contentsToArray data.contents

    configureLoadButton: (load)->
      self = this;

      _load = $(load);
      _file = $("<input>").attr
        type:"file"
        style:"display:none;"

      _load.after _file
      _load.click ->
        _file.click()

      _file.change ->
        if w.File
          input = this.files[0]
          reader = new FileReader()
          reader.onload = ->
            try
              data = JSON.parse reader.result
            catch err
              alert "ファイルの形式が正しくありません"
              return
            self.setLearningData data

          reader.readAsText input, 'UTF-8'
        else
          alert "お使いのブラウザでは File API が使用できません"

    configureSaveButton: (save)->
      self = this;
      $(save).click ->
        data =
          title: self.getTitle()
          contents: self.getContents()

        blob = new Blob [JSON.stringify(data)], {type: "application/json;charset=utf-8"}
        saveAs blob, data.title+".json"

    getTitle: ->
      return this.input.val()

    getContents: ->
      return this.arrayToContents this.table.getData()

    contentsToArray: (contents)->
      arr = []
      for c in contents
        arr.push [
          c.problem
          c.answer
          c.explain
        ]
      return arr

    arrayToContents: (arr)->
      contents = []
      for a in arr
        contents.push
          problem:  a[0]
          answer:   a[1]
          explain:  a[2]
      return contents

  w.problem = problem