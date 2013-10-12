class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()




  initialize: ->
    @model.on 'bust', => @endGame()
    @model.on 'endResult', => @endGame()
    @render()

  endGame: ->
    @render()
    winner = @model.get('winner')
    if winner is 'Player'
      console.log('Player Wins!')
    else
      console.log('Dealer Wins!')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
