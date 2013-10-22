# puppet-jayshah

## Overview

This is the module I use in order to manage my personal web server. It depends
on:

- [`example42/sudo`](https://forge.puppetlabs.com/example42/sudo)
- [`thias/bind`](https://forge.puppetlabs.com/thias/bind)
- [`thias/nginx`](https://forge.puppetlabs.com/thias/nginx)
- [`thias/php`](https://forge.puppetlabs.com/thias/php)

## Usage

Just `include jayshah` in your `site.pp`, e.g.:

	node /\.srv\.jay\.sh$/ {
	  include jayshah
	}

## Credits

Many thanks to `thias` for accepting my fixes, which made deploying the
configuration I wanted substantially easier.
