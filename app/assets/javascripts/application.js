//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
//= require jquery-fileupload/basic
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
});
