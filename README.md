# php-auto-namespacer.vim
Simple Vim plugin that namespaces (PSR-4) your PHP files using their paths.

## Installation
Nothing fancy here, just use your preferred package manager. For example, [vim-plug](https://github.com/junegunn/vim-plug):

```vim
call plug#begin(...)
...
Plug 'd3jn/php-auto-namespacer.vim'
...
call plug#end()
```

## Usage
Whenever you open empty PHP file this plugin will automatically use it's path to generate appropriate PSR-4 namespace and paste it into the buffer to give you a nice start. Open newly created `Foo/Bar/Baz.php` file and buffer will already contain:

```php
<?php

namespace Foo\Bar;

class Baz
{
}
```

Note that those changes are made to the buffer only and are not written down.

## Configuration
### `php_auto_namespacer_map`
This map is mimicking Composer's autoload map for PSR-4. You can specify base paths (relative to your CWD) and global namespaces to use for all PHP files inside those paths. Plugin will replace matched base paths when determining the namespace for a file. By default it's defined like this:

```vim
let g:php_auto_namespacer_map = {
\   'app/': 'App',
\   'src': ''
\}
```

This means that files inside `app` directory will be scoped with `App` namespace (this mimics Laravel's default autoload configuration for it's projects), while `src` directory will be omitted from resulting namespace completely. Override this option based on common `composer.json` PSR-4 `autoload` settings used inside your projects.

## Authors/contributors
* Serhii Yaniuk - [d3jn](https://twitter.com/whoisdein)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
