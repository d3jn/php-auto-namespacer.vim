# php-auto-namespacer.vim
Simple Vim plugin that defines PSR-4 namespaces for your new PHP files based on their relative path.

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

Proceed with coding and write the changes whenever you feel like it.

## Configuration
### `php_auto_namespacer_substitutes`
You can specify substitution map for directory names of your file's path. Plugin will replace matched names when determining the namespace. By default it's defined like this:

```vim
let g:php_auto_namespacer_substitutes = {
\   'app': 'App',
\   'src': ''
\}
```

Meaning that `app` directory name will be replaced with `App` namespace (this comes from Laravel projects - it autoloads project's `app/` contents into `App` namespace), while `src` directory will be omitted from resulting namespace completely. Override this dictionary based on your common `composer.json` PSR-4 autoload settings in your projects.

## Authors/contributors
Serhii Yaniuk - [d3jn](https://twitter.com/d3jn_)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
