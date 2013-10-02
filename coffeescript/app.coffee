'''
StopWatch
Contains all the typical methods and behaviours of a stopwatch
'''
class StopWatch
  constructor: ->
    @startTime = 0
    @running = false
    @elapsed = 0
    @firstRun = true

  start: ->
    console.log 'StopWatch started'
    if @firstRun
      @elapsed = @startTime = new Date().getTime() # start from 0
      @firstRun = false
    else
      @startTime = new Date().getTime() - @elapsed # start from where it left off
    @running = true

  stop: ->
    console.log 'StopWatch stopped'
    @elapsed = new Date().getTime() - @startTime # After it stops save the current time
    @running = false

  getElapsedTime: ->
    @elapsed = new Date().getTime() - @startTime
    return @formatTime(@elapsed)

  isRunning: ->
    return @running

  reset: ->
    console.log 'StopWatch reset'
    @elapsedTime = 0
    @firstRun = true

  pad:(num, size) ->
    s = "0000" + num
    return s.substr(s.length - size)

  formatTime: ->
    h = Math.floor( @elapsed / (60 * 60 * 1000) )
    time = @elapsed % (60 * 60 * 1000)
    m = Math.floor( time / (60 * 1000) )
    time = @elapsed % (60 * 1000)
    s = Math.floor( time / 1000 )
    if s>60
     newTime = @pad(h, 2) + ':' + @pad(m, 2) + ':' + @pad(s, 2)
    else
      newTime = @pad(h, 2) + ':' + @pad(m, 2) + ':' + @pad(s, 2)
    return newTime

'''
App
The MainEntry point of the application initializes the stopWatch and handles 
all the button events adn rendering and updating
'''
class App
  constructor: ->
    ###@canvas = $('canvas')
    @ctx = @canvas[0].getContext '2d'
    @height = @canvas.height()
    @canvas[0].height = @height
    $(window).resize @resize
    @calculateWidth()###
    @timeText = $('#timer')     #The Display text of the timer
    @timeText.html('00:00:00')
    @stopWatch = new StopWatch
    @startButton = $('#startButton')
    @startButton.on 'click', (event) => #startButton
      if(@stopWatch.isRunning())
        @stopWatch.stop()
        @startButton.html('Start')
      else
        @stopWatch.start()
        @startButton.html('Stop')
    @resetButton = $('#resetButton') #resetButton
    @resetButton.on 'click', (event) =>
      @stopWatch.reset()
      @timeText.html('00:00:00')
    #@animate()

  update: ->
    if @stopWatch.isRunning()
      @timeText.html(@stopWatch.getElapsedTime())
 
  animate: ->
    @ctx.fillStyle = 'black'
    @ctx.fillRect 0, 0, @width, @height
    @ctx.font = '60px digital'
    @ctx.fillStyle = 'green'
    @ctx.fillText("00:00:00", @width/2 - 105, @height/2 + 20)
    #if @stopWatch.isRunning()
    #  console.log @stopWatch.getElapsedTime()
    requestAnimationFrame @animate
 
  resize:->
    @calculateWidth()
  
  calculateWidth: ->
    @width = @canvas.width() - 1
    @canvas[0].width = @width

$ ->
  console.log "App Started"
  window.app = new App
  clocktimer = setInterval("window.app.update()", 1)