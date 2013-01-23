$ = jQuery

$.fn.extend
  prettyTextDiff: (options) ->
      # Defaults
      settings =
        originalContainer: ".original",
        changedContainer:  ".requested",
        diffContainer: ".diff",
        cleanup: true
        debug: false
      settings = $.extend settings, options
      $.fn.prettyTextDiff.debug "Options: ", settings, settings

      dmp = new diff_match_patch();
      @each ->
        original = $(settings.originalContainer, this).text()
        $.fn.prettyTextDiff.debug "Original text found: ", original, settings
        changed = $(settings.changedContainer, this).text()
        $.fn.prettyTextDiff.debug "Changed  text found: ", changed, settings

        diffs = dmp.diff_main(original, changed)

        dmp.diff_cleanupSemantic(diffs) if settings.cleanup
        $.fn.prettyTextDiff.debug "Diffs: ", diffs, settings

        $(settings.diffContainer, this).html("arnab");

        @

$.fn.prettyTextDiff.debug = (message, object, settings) ->
  console.log(message, object) if settings.debug
