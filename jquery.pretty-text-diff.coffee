$ = jQuery

$.fn.extend
  prettyTextDiff: (options) ->
      # Defaults
      settings =
        option1: true
        option2: false
        debug: false
      settings = $.extend settings, options

      # Simple logger.
      log = (msg) ->
          console?.log msg if settings.debug

        return @each ()->
            log "Option 1 value: #{settings.option1}"
