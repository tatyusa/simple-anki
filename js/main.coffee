$ ->
  tabs.init()
  problem.init "#title", "#contents"
  problem.configureLoadButton "#load"
  problem.configureSaveButton "#save"

  tabs.setTabFunction "#tab1", ->
    $(".information").hide()
    setNewProblem()

  $.getJSON "default.json", (data)->
    problem.setLearningData data

  $(".information").hide()
  $("input.answer").on "keypress", (e)->
    if e.keyCode == 13
      if $('.information').is ":visible"
        $(".information").hide()
        setNewProblem()
      else
        setScore()
        $(".information").show "fast"

  $("button.next").on "click", (e)->
    if $('.information').is ":visible"
      $(".information").hide()
      setNewProblem()

  $("button.answer").on "click", (e)->
    if $('.information').not ":visible"
      setScore()
      $(".information").show "fast"



  setNewProblem = ->
    contents = problem.getContents()
    index = Math.random()*contents.length|0
    $("input.answer").val ""
    $(".problem").html contents[index].problem
    $("span.answer").text contents[index].answer
    $(".explain").html contents[index].explain

  setScore = ->
    if $("input.answer").val() == $("span.answer").text()
      $("div.score").html("<span style=\"font-size:large;color:red;\">正解!!</span>");
    else
      $("div.score").html("<span style=\"font-size:large;color:blue;\">不正解!!</span>");