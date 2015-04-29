jQuery.PrettyTextDiff
=====================

A wrapper around Google's
[`diff_match_patch`](http://code.google.com/p/google-diff-match-patch/)
library. Google's library is awesome and can be fine-tuned in
multiple ways, but their API is a bit awkward, probably cause they
support the same API in 8 different languages.

Also, the library does not provide any beautification of the diff-ed
output. They provide a reference implementation (look for
`diff_prettyHtml` in the
[API docs](http://code.google.com/p/google-diff-match-patch/wiki/API)
) but recommend developers to write their own - and the given method is
[not customizable](http://stackoverflow.com/questions/13894514/google-diff-match-avoid-showing-new-lines)
.

This library is an alternative to embedding
 [30+ lines of cryptic JS](http://stackoverflow.com/a/13894720/117750)
 in your code. In short, it tries to bridge the gap between the
 awesome `diff_match_patch` library and a simple user-experience.

This [blog post](http://arnab-deka.com/posts/2013/02/hello-jquery-prettytextdiff/)
explains things in a bit more detail.

## Demo
[jsfiddle demo](http://jsfiddle.net/q7hyfev8/5/)

## Download
From [npm.js](https://www.npmjs.com/package/jquery-prettytextdiff/).

## Usage
#### First, include the libraries
+ include `jquery.js`, `diff_match_patch.js` and
`jquery.pretty-text-diff.js` in your page, something like:

```html
<script src="/path/to/jquery.min.js" type="text/javascript"></script>
<script src="/path/to/diff_match_patch.js" type="text/javascript"></script>
<script src="/path/to/deal_override_requests.min.js" type="text/javascript"></script>
```

#### Next sprinkle a bit of JS
+ something like:

```js
  $(selector).prettyTextDiff({
    // options
  });
```
Check out the [customizable options](#customizable-options) below.

#### Optionally, style the diff
+ Style `<ins>` and `<del>` as much as you want. A simple example is
in the [jsfiddle demo](#demo).

#### Customizable options
+ Either mark up your HTML to use the default selectors, or use these options:

<table>
  <tr>
    <th>option</th>
    <th>default</th>
    <th>explanation</th>
  </tr>

  <tr>
    <td>originalContainer</td>
    <td>.original</td>
    <td>CSS-selector for the element that holds the original text. $(elem).text() will be used to extract the text.</td>
  </tr>

  <tr>
    <td>changedContainer</td>
    <td>.changed</td>
    <td>CSS-selector for the element that holds the changed text. $(elem).text() will be used to extract the text.</td>
  </tr>

  <tr>
    <td>diffContainer</td>
    <td>.diff</td>
    <td>CSS-selector for the element where the diff will be put.</td>
  </tr>

  <tr>
    <td>cleanup</td>
    <td>true</td>
    <td>Whether diff_match_patch's diff_cleanupSemantic() will be used or not. true will produce a human-redable diff, whereas false will be more to the liking of machines. See the demo for the effect.</td>
  </tr>

  <tr>
    <td>debug</td>
    <td>false</td>
    <td>see some debug output in your browser's console</td>
  </tr>

  <tr>
    <td>originalContent<sup>v1.0.4+</sup></td>
    <td>None</td>
    <td>Pass the original content as a parameter in your JS file, instead of creating an element in your HTML code to extract this content.</td>
  </tr>

  <tr>
    <td>changedContent<sup>v1.0.4+</sup></td>
    <td>None</td>
    <td>Pass the changed content as a parameter in your JS file, instead of creating an element in your HTML code to extract this content.</td>
  </tr>
</table>

## Development
+ Install [`node`](http://nodejs.org/) and `npm` (comes with node now)
+ Install [`coffeescript`](http://coffeescript.org/#installation) and
    [`uglify`](https://github.com/mishoo/UglifyJS2):
    `npm install -g coffee-script uglify-js`
+ `cake build` to produce the output JS (minified)
+ Increment the version in the
coffeescript (and compiled/minified) javascript source and the
`package.json` file.
+ `git tag x.y.z`
+ Push: `git push && git push --tags && npm publish`

## Contributing
+ Fork this repo
+ create a feature/bugfix branch: `git checkout -b branch_name`
+ [Develop](#development)
  + Just change the coffeescript source. When your PR is merged, I will generate the JS flavors and update the versioning.
+ Push to your repo: `git push origin branch_name`
+ [Submit a PR](https://github.com/arnab/jQuery.PrettyTextDiff/pulls/)

## License
Copyright (c) 2013 Arnab Deka. Licensed under
[MIT LICENSE](https://github.com/arnab/jQuery.PrettyTextDiff/blob/master/LICENSE)
for details.
