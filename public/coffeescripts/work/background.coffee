namespace 'background', (exports) ->

  exports.load = () ->
    bg_wrapper = $('#bg_wrapper')
    $('#bg_canv').attr
      height: bg_wrapper.height()
      width: bg_wrapper.width()
    exports.drawFiveColorDots()

  exports.drawFiveColorDots = () ->
    exports.draw('#FF7575', 5)  # red
    exports.draw('#35E6FF', 10)  # blue
    exports.draw('#35FFBD', 10)  # green
    exports.draw('#F2D7FF', 10)  # purple
    exports.draw('#FF9900', 10) # orange

  exports.draw = (color, num) ->

    canvas = document.getElementById('bg_canv')
    ctx = canvas.getContext('2d')

    for i in [1..num]
      ctx.beginPath()

      r_c = hexToR(color)
      g_c = hexToG(color)
      b_c = hexToB(color)
      ctx.fillStyle = "rgba(#{r_c}, #{g_c}, #{b_c}, 0.5)"

      x = Math.random() * canvas.width
      y = Math.random() * canvas.height
      r = Math.random() * (80 - i * 3)
      ctx.arc(x, y, r, 0, Math.PI * 2, false)

      ctx.fill()

  hexToR = (h) -> parseInt((cutHex(h)).substring(0,2), 16)

  hexToG = (h) -> parseInt((cutHex(h)).substring(2,4), 16)

  hexToB = (h) -> parseInt((cutHex(h)).substring(4,6), 16)

  cutHex = (h) -> if (h.charAt(0)=="#") then h.substring(1,7) else h

