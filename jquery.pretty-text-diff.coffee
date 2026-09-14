###
@preserve jQuery.PrettyTextDiff 1.0.5
See https://github.com/arnab/jQuery.PrettyTextDiff/
###

$ = jQuery

diff_wordsToChars = (text1, text2) ->
  wordsToChars = (text) ->
    chars = ""
    wordStart = 0

    while wordStart < text.length
      wordEnd = text.indexOf(" ", wordStart)
      wordEnd = text.length - 1 if wordEnd == -1

      word = text.substring(wordStart, wordEnd + 1)
      wordStart = wordEnd + 1

      if wordHash.hasOwnProperty(word)
        chars += String.fromCharCode(wordHash[word])
      else
        wordHash[word] = lineArray.length
        lineArray.push(word)
        chars += String.fromCharCode(lineArray.length - 1)

    chars

  lineArray = [""]
  wordHash = {}

  [
    wordsToChars(text1)
    wordsToChars(text2)
    lineArray
  ]

$.fn.extend
  prettyTextDiff: (options) ->
      # Defaults
      settings =
        mode: 'DEFAULT',
        originalContainer: ".original",
        changedContainer:  ".changed",
        diffContainer: ".diff",
        cleanup: true
        debug: false
      settings = $.extend settings, options
      $.fn.prettyTextDiff.debug "Options: ", settings, settings

      dmp = new diff_match_patch();
      @each ->
        if settings.originalContent and settings.changedContent
          original = $('<div />').html(settings.originalContent).text()
          changed = $('<div />').html(settings.changedContent).text()
        else
          original = $(settings.originalContainer, this).text()
          changed = $(settings.changedContainer, this).text()

        $.fn.prettyTextDiff.debug "Original text found: ", original, settings
        $.fn.prettyTextDiff.debug "Changed  text found: ", changed, settings

        mode = $(this).attr('mode') or settings.mode
        if ["WORD", "LINE"].includes(mode)
          fragments = if mode == "WORD"
            diff_wordsToChars(original, changed)
          else
            Object.values(dmp.diff_linesToChars_(original, changed))
          diffs = dmp.diff_main fragments[0], fragments[1], false
          dmp.diff_charsToLines_(diffs, fragments[2])
        else
          diffs = dmp.diff_main(original, changed)
          dmp.diff_cleanupSemantic(diffs) if settings.cleanup

        $.fn.prettyTextDiff.debug "Diffs: ", diffs, settings

        diff_as_html = $.map(diffs, (diff) ->
          $.fn.prettyTextDiff.createHTML(diff))
        $(settings.diffContainer, this).html(diff_as_html.join(''));

        @

$.fn.prettyTextDiff.debug = (message, object, settings) ->
  console.log(message, object) if settings.debug

$.fn.prettyTextDiff.createHTML = (diff) ->
    html = [];
    pattern_amp = /&/g
    pattern_lt = /</g
    pattern_gt = />/g
    pattern_para = /\n/g

    [operation, data] = diff
    text = data.replace(pattern_amp, '&amp;') \
               .replace(pattern_lt, '&lt;') \
               .replace(pattern_gt, '&gt;') \
               .replace(pattern_para, '<br>')
    switch operation
      when DIFF_INSERT then '<ins>' + text + '</ins>'
      when DIFF_DELETE then '<del>' + text + '</del>'
      when DIFF_EQUAL  then '<span>' + text + '</span>'
