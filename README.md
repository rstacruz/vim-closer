# vim-closer

**Closes brackets.** Perfect companion to [vim-endwise]. Basically, a more conservative version of [auto-pairs] that only works when you press Enter.

----

![](https://raw.githubusercontent.com/rstacruz/vim-closer/gh-pages/closer.gif)

----

[![Status](http://img.shields.io/travis/rstacruz/vim-closer/master.svg)](https://travis-ci.org/rstacruz/vim-closer/ "See test builds")

[auto-pairs]: https://github.com/jiangmiao/auto-pairs
[vim-endwise]: https://github.com/tpope/vim-endwise

<br>

## What

Closings are automatically inserted after pressing <kbd>Enter ⏎</kbd>. It supports languages that have `(`, `[`, and `{` brackets.

```css
.section {⏎
```

```css
.section {
  |
}
```

It tries to automatically figure out whatever braces were opened in the line. This is useful for, say, JavaScript where `});` is commonly seen.

```js
describe('test', function () {⏎
```

```js
describe('test', function () {
  |
})
```

Semicolons are automatically added if it makes sense, and only if another line in the buffer ends in `;`.

```js
var x = 1;
setImmediate(function () {⏎
```

```js
var x = 1;
setImmediate(function () {
  |
});
```

<br>

## Install

When using [vim-plug], add this to your `~/.vimrc`:

[vim-plug]: https://github.com/junegunn/vim-plug

```vim
Plug 'rstacruz/vim-closer'
```

<br>

## By the way

Do you edit CSS often? Of course you do. Let me help you make that [a better experience.](http://ricostacruz.com/vim-hyperstyle/)

<br>

## Thanks

**vim-closer** © 2015+, Rico Sta. Cruz. Released under the [MIT] License.<br>
Authored and maintained by Rico Sta. Cruz with help from contributors ([list][contributors]).

> [ricostacruz.com](http://ricostacruz.com) &nbsp;&middot;&nbsp;
> GitHub [@rstacruz](https://github.com/rstacruz) &nbsp;&middot;&nbsp;
> Twitter [@rstacruz](https://twitter.com/rstacruz)

[MIT]: http://mit-license.org/
[contributors]: http://github.com/rstacruz/vim-closer/contributors
