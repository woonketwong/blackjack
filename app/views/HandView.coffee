class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: (e)->
    @$el.children().detach()
    @$el.html @template @collection
    that = @$el
    @collection.map (card) ->
      if !card.get('rendered')
        card.set({'rendered': true},{silent:true})
        that.append new CardView(model: card).$el.fadeIn(1000)
      else
        that.append new CardView(model: card).$el

    @$('.score').text @collection.displayScore()
