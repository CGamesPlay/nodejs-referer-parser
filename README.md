# referer-parser node.js (JavaScript) library

This is the node.js (JavaScript) implementation of [snowplow-referer-parser][https://github.com/snowplow-referer-parser], the library for extracting search marketing data from referer _(sic)_ URLs.

The implementation uses the shared 'database' of known referers, which is stored in the [referer-parser repository](https://github.com/snowplow-referer-parser/referer-parser).

## Installation

    $ npm install @cgamesplay/referer-parser

## Usage

Create a new instance of a Referer object by passing in the url you want to parse:

```js
var Referer = require('@cgamesplay/referer-parser')

referer_url = 'http://www.google.com/search?q=gateway+oracle+cards+denise+linn&hl=en&client=safari'

var r = new Referer(referer_url)
```

The `r` variable now holds a Referer instance.  The important attributes are:

```js
console.log(r.known)              // true
console.log(r.referer)            // 'Google'
console.log(r.medium)             // 'search'
console.log(r.search_parameter)   // 'q'
console.log(r.search_term)        // 'gateway oracle cards denise linn'
console.log(r.uri)                // result of require('url').parse(...)
```

Optionally, pass in the current URL as well, to handle internal referers

```js
var Referer = require('@cgamesplay/referer-parser')

var referer_url = 'http://www.snowplowanalytics.com/about/team'
var current_url = 'http://www.snowplowanalytics.com/account/profile'

var r = Referer(referer_url, current_url)
```

The attributes would be

```js
console.log(r.known)              // true
console.log(r.referer)            // null
console.log(r.medium)             // 'internal'
console.log(r.search_parameter)   // null
console.log(r.search_term)        // null
console.log(r.uri)                // result of require('url').parse(...)
```

## Development

There is a script to update the database from the [latest database](https://github.com/snowplow-referer-parser/referer-parser).

```bash
./script/update_db.sh
```

## Copyright and license

The referer-parser node.js (JavaScript) library is copyright 2013 Martin Katrenik.

Licensed under the [Apache License, Version 2.0][license] (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[license]: http://www.apache.org/licenses/LICENSE-2.0
