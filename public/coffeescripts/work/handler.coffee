namespace 'handler', (exports) ->

  exports.naviChange = (name) ->
    $('#header_navi .navi-tabs li').removeClass('active')
    $("#navi_tab_#{name}").addClass('active')
    $('.content').hide()
    $("#content_#{name}").show()
