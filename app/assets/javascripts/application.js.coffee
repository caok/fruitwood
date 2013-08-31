#= require jquery
#= require jquery_ujs
#= require bootstrap-custom
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
#= require jquery-fileupload/basic
#= require jquery.textarea.caret
#= require jquery.grid-a-licious.min
#= require_self

$ ->
  body = $('body')
  datepickerDefaults =
    language: 'zh-CN'
    format: 'yyyy-mm-dd'
    weekStart: '1'

  body.on "click", ".datepicker-trigger", ->
    el = $(this).closest(".date").find(".date_picker")
    datepicker = el.data("date_picker")
    unless datepicker?
      el.datepicker(datepickerDefaults).on "changeDate", ->
        el.datepicker "hide"

    el.datepicker "show"

  $(".fileupload").each ->
    $(this).fileupload
      dataType: "json"
      dropZone: $(this).closest(".uploadable-input") # #206 http://git.io/DuKo8A
      add: (e, data) ->
        el = $(this).parent()
        el.hide()
        el.next(".uploading").show()
        data.submit()

      done: (e, data) ->
        $.each data.result.files, (index, file) ->
          targetTextarea = $(e.target).closest(".control-group").find("textarea")
          markdownImage = "![" + file.name + "](" + file.url + ")"
          markdownImage = "\n" + markdownImage + "\n"  unless targetTextarea.val() is ""
          targetTextarea.insertAtCursor markdownImage

        el = $(this).parent()
        el.show()
        el.next(".uploading").hide()

  $("textarea.uploadable").on("focus", ->
    $(this).next("p").addClass "focused"
  ).on "blur", ->
    $(this).next("p").removeClass "focused"

  $(".uploadable-input").each ->
    $this = $(this)

    #get textarea's id
    id = $this.find('textarea').attr('id')

    #set write-tab's link
    writeTab = $this.find('.write-tab:first a')
    writeTab.attr('href', '#'+id)

    #set preview-tab's link
    previewTabId = id + '_preview_bucket'
    previewTab = $this.find('.preview-tab')
    previewTab.find('a').attr('href', '#'+previewTabId)

    #set write-section's id
    writeSec = $this.find('.tab-content>.active')
    writeSec.attr('id',id)
    #set preview-section's id
    previewSec = writeSec.siblings()
    previewSec.attr('id',previewTabId)

    #preview content in the write section
    previewTab.click ->
      writeBits = writeSec.find('textarea').val()
      previewSec.find('.previews').empty()
      if writeBits is ''
        previewSec.find('.preview-nothing').show()
      else
        $.ajax({
          url: "/content/preview"
          type: "POST"
          data: "content="+writeBits
          beforeSend: ->
              previewSec.find('.preview-nothing').hide()
              previewSec.find('.preview-loading').show()
          success: (data) ->
              previewSec.find('.preview-loading').hide()
              previewSec.find('.previews').append(data.result)
        })

  $("#dishes").gridalicious
    width: 225
    selector: ".dish"
    animate: true
    animationOptions:
      queue: true
      speed: 200
      duration: 100
      effect: "fadeInOnAppear"

  # Go Top
  $("a.go_top").click () ->
    $('html, body').animate({ scrollTop: 0 },300)
    return false

  $(window).bind 'scroll resize', ->
    scroll_from_top = $(window).scrollTop()
    if scroll_from_top >= 1
      $("a.go_top").show()
    else
      $("a.go_top").hide()
