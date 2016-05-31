###
@preserve jQuery.PrettyTextDiff 1.0.4
See https://github.com/arnab/jQuery.PrettyTextDiff/
###

$ = jQuery

diff_charsToLines = (a, b) ->
  d = []
  e = {}

  c = (a) ->
    `var b`
    `var c`
    `var c`
    b = ''
    c = 0
    f = -1
    g = d.length
    while f < a.length - 1
      f = a.indexOf(' ', c)
      -1 == f and (f = a.length - 1)
      r = a.substring(c, f + 1)
      c = f + 1
      if (if e.hasOwnProperty then e.hasOwnProperty(r) else undefined != e[r]) then (b += String.fromCharCode(e[r])) else b += String.fromCharCode(g)
      e[r] = g
      d[g++] = r
    b

  d[0] = ''
  f = c(a)
  g = c(b)
  {
    chars1: f
    chars2: g
    lineArray: d
  }

$.fn.extend
  prettyTextDiff: (options) ->
      # Defaults
      settings =
            mode: 'DEFAULT'
            originalContainer: '.original'
            changedContainer: '.changed'
            diffContainer: '.diff'
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
        
        if settings.mode == 'WORD' or settings.mode == 'LINE'
          a = if settings.mode == 'WORD' then diff_charsToLines(original, changed) else dmp.diff_linesToChars_(original, changed)
          lineText1 = a['chars1']
          lineText2 = a['chars2']
          lineArray = a['lineArray']
          diffs = dmp.diff_main(lineText1, lineText2, false)
          dmp.diff_charsToLines_ diffs, lineArray
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
