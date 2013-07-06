
_user =
  id_str: null
  name: null
  screen_name: null
  location: null
  description: null
  url: null
  protected: null
  time_zone: null
  lang: null
  profile_image_url: null

exports.getUserInfoFromTwitter = (params = {}) ->
  for k of _user
    _user[k] = params[k] if params[k]?
  return _user
