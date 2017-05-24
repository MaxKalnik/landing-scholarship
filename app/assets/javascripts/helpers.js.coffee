$.extend
  getHostName: (url) ->
    return 'N/A' unless url?
    location = document.createElement 'a'
    location.href = url

    # IE doesn't populate all link properties when setting .href with a relative URL,
    #  however .href will return an absolute URL which then can be used on itself
    # to populate these additional fields.
    location.href = location.href if location.host == ""
    location.hostname

  userCameFromOutside: ->
    return false unless document.referrer

    referrerHost = $.getHostName(document.referrer)
    REFERRER_BLACK_LIST = ['rewardexpert.com',
                           'api.login.yahoo.com',
                           'accounts.google.com']

    for domain in REFERRER_BLACK_LIST
      return false if referrerHost.indexOf(domain) > -1

    return true

  storeReferrer: ->
    if store.enabled
      store.set 'referrer', document.referrer

  clearReferrer: ->
    if store.enabled
      store.remove 'referrer'

  storeEntrancePage: ->
    if store.enabled
      store.set 'entrancePage', window.location.href

  clearEntrancePage: ->
    if store.enabled
      store.remove 'entrancePage'
