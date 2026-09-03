[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)
# simp-build-helpers

> ## DEPRECATED
>
> This project has been absorbed into
> [`simp-rake-helpers`](https://github.com/simp/rubygem-simp-rake-helpers) as of
> its 6.1.0 release, and is no longer maintained separately.
>
> `Simp::Build::ReleaseMapper` now lives at `lib/simp/build/release_mapper.rb`
> in that project, under the same namespace, so no code changes are needed by
> consumers beyond removing the `simp-build-helpers` gem dependency.
>
> The last release published to RubyGems was 0.1.1 (2016-09-28). It calls
> `File.exists?`, which no longer exists in current Rubies, so that release is
> broken on any modern Ruby. Use `simp-rake-helpers` >= 6.1.0 instead.

SIMP build helpers

#### Table of Contents
1. [Overview](#overview)
2. [Setup](#setup)
* [Beginning with simp-build-helpers](#beginning-with-simp-build-helpers)
3. [Methods](#methods)
4. [Environment variables](#environment-variables)
5. [Examples](#examples)
6. [License](#license)

## Overview

Provides helper methods for building SIMP

## Setup

### Beginning with simp-build-helpers

Don't. This project is deprecated (see above). Add this to your project's
`Gemfile` instead:

```ruby
gem 'simp-rake-helpers', '>= 6.1.0'
```

## Methods



## Environment variables


## Examples


## License
See [LICENSE](LICENSE)
