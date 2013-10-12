#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', 0
    @set 'dealerScore', 0
    @set 'winner', null

    @get('playerHand').on 'add', =>
      @set 'playerScore', @get('playerHand').scores()[0]
      if @isBust(@get('playerScore'))
        @set 'winner', 'Dealer'
        console.log(@)
        @get('dealerHand').first().flip()
        @trigger('bust', @)
    @get('dealerHand').on 'add', =>
      @set 'dealerScore', @get('dealerHand').scores()[0]
      if @isBust(@get('dealerScore'))
        @set 'winner', 'Player'
        @trigger('bust', @)

  isBust: (score) ->
    score > 21
