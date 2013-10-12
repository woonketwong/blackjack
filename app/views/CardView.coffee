class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    if @model.get 'revealed'
      @$el.css
        'background': 'url("lib/img/cards/'+@model.get('backgroundImg')+'.png")'
        'background-size': '100px 140px'
    else
      @$el.addClass 'covered'

