# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  initDatepicker()
  initSelect2()
  initTooltips()

$(document).on 'page:load', ->
  initDatepicker()
  initSelect2()
  initTooltips()

$(document).on 'cocoon:after-insert', ->
  initDatepicker()

initDatepicker = ->
  $('.calendar').datetimepicker(
    lang: 'ru'
    defaultDate: new Date()
    format: 'd-m-Y H:i'
    dayOfWeekStart: 1
  )

initSelect2 = ->
  $('.select2').select2()

initTooltips = ->
  $('[data-toggle="tooltip"]').tooltip()
