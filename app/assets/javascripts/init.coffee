window.App ||= {}

App.init = ->
  this._initTooltips()
  this._initDatepicker()
  this._initSelect2()

App._initTooltips = ->
  $('[data-toggle="tooltip"]').tooltip()

App._initDatepicker = ->
  $('.calendar').datetimepicker(
    lang: 'ru'
    defaultDate: new Date()
    format: 'd-m-Y H:i'
    dayOfWeekStart: 1
    lazyInit: true
  )

App._initSelect2 = ->
  $('.select2').select2()

# JS Application init for turbolincks
$(document).on 'page:load', ->
  App.init()

# Regular JS Application init
$ ->
  App.init()
