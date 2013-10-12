class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  stand: ->
    @trigger('stand', @)

  finalScore: ->
    currentScores = @scores()
    if currentScores.length is 2
      if currentScores[1] <= 21
        return currentScores[1]
    currentScores[0]

  autoPlay: ->
    currentScores = @scores()

    if currentScores.length is 2 and
      currentScores[1] <= 21
        index = 1
    else index = 0
    if currentScores[index] >= 17 and
      currentScores[index] <= 21
        @stand()
    else if currentScores[index] < 17 then @hit()

  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  displayScore: ->
    currentScores = @scores()
    if currentScores.length is 2 and currentScores[1] <= 21
      currentScores[0]+ ' or ' +currentScores[1]
    else
      currentScores[0]
