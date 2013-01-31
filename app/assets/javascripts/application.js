//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
//= require jquery-fileupload/basic
//= require jquery.textarea.caret
//= require jquery.grid-a-licious.min
//= require_self

$(function() {
  var body = $('body');
  var datepickerDefaults = {
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    weekStart: '1'
  };

  body.on('click', '.datepicker-trigger', function() {
    var el = $(this).closest('.date').find('.date_picker');
    var datepicker = el.data('date_picker');
    if (datepicker === null || datepicker === undefined) {
      el.datepicker(datepickerDefaults).on('changeDate', function() {
        el.datepicker('hide');
      });
    }

    el.datepicker('show');
  });

  $('.fileupload').each(function(){
    $(this).fileupload({
      dataType: 'json',
      dropZone: $(this).closest('.uploadable-input'), // #206 http://git.io/DuKo8A
      add: function(e, data) {
        var el = $(this).parent();
        el.hide();
        el.next(".uploading").show();
        data.submit();
      },
      done: function (e, data) {
        $.each(data.result.files, function (index, file) {
          targetTextarea = $(e.target).closest('.control-group').find('textarea');
          markdownImage = "![" + file.name + "](" + file.url + ")";
          if (targetTextarea.val() != '') {
            markdownImage = "\n" + markdownImage + "\n";
          }
          targetTextarea.insertAtCursor(markdownImage);
        });
        var el = $(this).parent();
        el.show();
        el.next(".uploading").hide();
      }
    });
  });

  $('textarea.uploadable').
    on('focus', function() {
      $(this).next('p').addClass('focused');
    }).
    on('blur', function() {
      $(this).next('p').removeClass('focused');
    });

  $('#dishes').gridalicious({
    width: 225,
    selector: '.dish',
    animate: true,
    animationOptions: {
      queue: true,
      speed: 200,
      duration: 300,
      effect: 'fadeInOnAppear'
    }
  });

});
