#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'currentPlayer', 'Player'
    @set 'playerScore', 0
    @set 'dealerScore', 0
    @set 'winner', null

    @get('playerHand').on 'add', =>
      @set 'playerScore', @get('playerHand').scores()[0]
      if @isBust(@get('playerScore'))
        @set 'winner', 'Dealer'
        @get('dealerHand').first().flip()
        @trigger('bust', @)

    @get('dealerHand').on 'add', =>
      @set 'dealerScore', @get('dealerHand').scores()[0]
      if @isBust(@get('dealerScore'))
        @set 'winner', 'Player'
        @trigger('bust', @)
      else @get('dealerHand').autoPlay()

    @get('playerHand').on 'stand', =>
      @set 'playerScore', @get('playerHand').finalScore()
      @set 'currentPlayer', 'Dealer'
      @get('dealerHand').first().flip()
      @get('dealerHand').autoPlay()

    @get('dealerHand').on 'stand', =>
      @set 'dealerScore', @get('dealerHand').finalScore()
      @pickWinner()
      @trigger('endResult', @)

  isBust: (score) ->
    score > 21

  pickWinner: ->

    if @get('dealerScore') > @get('playerScore')
      @set 'winner', 'Dealer'
    else if @get('dealerScore') < @get('playerScore')
      @set 'winner', 'Player'
    else
      @set 'winner', 'Push'

