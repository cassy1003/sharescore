
_conf =
  port: 5555
  domain: 'http://onebusiness.cassy.jp.net'
  title: 'Title'
  twitter:
    consumerKey: 'KYD5cUM6rSm4msC9lVOw'
    consumerSecret: '7CNMLOAh8CzoTKe7Hxyx9pRUPvgwPSsRgSKEfr0Rc'

exports.getConf = () ->
  return _conf

exports.setConf = (params = {}) ->
  for k, v of params
    _conf[k] = v


