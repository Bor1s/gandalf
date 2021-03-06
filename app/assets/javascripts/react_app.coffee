initReactApp = ->
  SearchField = React.createClass({
    changeHandler: (event)->
      self = this
      $.ajax
        url: self.props.url
        data:
          q: event.target.value
        dataType: 'script'
        cache: false
        success: (data)->
          ''
        error: (xhr, status, err)->
          console.error status, err.toString()
        complete: ->
          App.init()

    render: ()->
      return (
        <input type='text' className="form-control input-sm" placeholder="#{I18n.t('application.search')}" onChange={this.changeHandler} />
      );
  });

  ReactDOM.render(
    <SearchField url="/search" />,
    document.getElementById('JS_react')
  );

$ ->
  initReactApp()

$(document).on 'page:load', ->
  initReactApp()
