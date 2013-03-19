
namespace 'rtc.face', (exports) ->
  image = new Image()
  _image = ''
  _drawInterval = ''
  _comp = []
  _isDraw = false
  _socket = false
  _errorC = 0

  exports.drawStart = () ->
    return if _isDraw
    _isDraw = true
    _drawInterval = setInterval () ->
      draw()
    , 100

  exports.drawEnd = () ->
    return unless _isDraw
    _isDraw = false
    clearInterval(_drawInterval)

  draw = () ->
    localVideo = $('#localVideo')
    localCanvas = $('#localCanvas')
    canvas = document.createElement('canvas')

    width = localVideo.width()
    height = localVideo.height()
    canvas.width = width
    canvas.height = height

    context = canvas.getContext('2d')
    context.drawImage(localVideo.get(0), 0, 0, width, height)
    comp = ccv.detect_objects({
      "canvas" :ccv.grayscale(canvas)
      "cascade" : cascade
      "interval" : 5
      "min_neighbors" : 1
    })
    if comp.length > 0
      _comp = comp
      _errorC = 0
    else
      _errorC += 1
      if _errorC >= 20
        _comp = []

    context2 = localCanvas[0].getContext('2d')
    context2.drawImage(localVideo.get(0), 0, 0, width, height)
    context2.strokeStyle="#FF0000"
    context2.lineWidth = 10

    if _comp.length > 0
      unless _image
        return
      for i in [0..(_comp.length - 1)]
        if _image is '/images/square.gif'
          context2.strokeRect(_comp[i].x - 30, _comp[i].y - 30, _comp[i].width + 60, _comp[i].height + 60)

        else
          context2.drawImage(image, _comp[i].x - 30, _comp[i].y - 30, _comp[i].width + 60, _comp[i].height + 60)
    else
      console.log 'none face'

  exports.changeImg = (img) ->
    unless img
      _image = ''
      return

    _image = "/images/#{img}.gif"
    if img isnt 'square'
      image.src = _image

