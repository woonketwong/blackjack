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

    @get('playerHand').on 'all', (e) => @playerEvents(e)
    @get('dealerHand').on 'all', (e) => @dealerEvents(e)

  playerEvents: (event) ->
    if event is 'hit'
      @set 'playerScore', @get('playerHand').finalScore()
    else if event is 'stand'
      @set 'currentPlayer', 'Dealer'
      @get('dealerHand').autoPlay()
    else if event is 'bust'
      @set 'currentPlayer', 'Dealer'
      @get('dealerHand').first().flip()
      @set 'winner', 'Dealer'


  dealerEvents: (event) ->
    if event is 'hit'
      @set 'dealerScore', @get('dealerHand').finalScore()
      @get('dealerHand').autoPlay()
    else if event is 'stand'
      @pickWinner()
    else if event is 'bust'
      @set 'winner', 'Player'

    # @get('playerHand').on 'hit', =>
    #   @set 'playerScore', @get('playerHand').scores()[0]
    #   if @isBust(@get('playerScore'))
    #     @set 'winner', 'Dealer'
    #     @get('dealerHand').first().flip()
    #     @trigger('bust', @)

    # @get('dealerHand').on 'hit', =>
    #   @set 'dealerScore', @get('dealerHand').scores()[0]
    #   if @isBust(@get('dealerScore'))
    #     @set 'winner', 'Player'
    #     @trigger('bust', @)
    #   else @get('dealerHand').autoPlay()

    # @get('playerHand').on 'stand', =>
    #   @set 'playerScore', @get('playerHand').finalScore()
    #   @set 'currentPlayer', 'Dealer'
    #   @get('dealerHand').autoPlay()

    # @get('dealerHand').on 'stand', =>
    #   @set 'dealerScore', @get('dealerHand').finalScore()
    #   @pickWinner()
    #   @trigger('endResult', @)

  pickWinner: ->

    if @get('dealerScore') > @get('playerScore')
      @set 'winner', 'Dealer'
    else if @get('dealerScore') < @get('playerScore')
      @set 'winner', 'Player'
    else
      @set 'winner', 'Push'

