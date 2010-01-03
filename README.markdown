# Bixbite Project Initializer

Bixbite creates a project structure optimal for client-side development.

* Downloads the latest versions of [Google Ajax API Libraries](http://code.google.com/apis/ajaxlibs/)
* Uses [LABjs](http://labjs.com/) for parallelized script management
* Allows full use of PHP includes for shared module management
* Bundles a customized [PHP Minify](http://code.google.com/p/minify/) package for on-the-fly compression tests
* Dynamic to static publishing eliminates server-side dependencies on delivery

Additionally, Bixbite includes rake tasks to automatically:

* Prepare files for deployment
* Generate NaturalDocs-compliant documentation
* Compress PNG files using OptiPNG
* Gracefully degrade 24-bit PNG files for Internet Explorer 6
* Deliver compressed versions of CSS & JavaScript files
* Add new files, remove outdated files from Subversion
* Generate diff reports for each delivery

## Links

 * [Wiki](http://wiki.github.com/doctyper/bixbite)
 * [Bugs](http://github.com/doctyper/bixbite/issues)

## Installing

# Install the gem:
    gem install bixbite

# Usage

# Generating a Bixbite template

Run the Bixbite gem to generate a new template:

    bixbite "The Foo Project" FOO

This command will generate a template with a project name of "The Foo Project" and support files (JS/PHP) using the FOO namespace.

You may also specify arguments when invoked. Via `bixbite --help`:

 * --js-lib [ARG]: use specified JavaScript library (options: jQuery, YUI, MooTools)
 * --source-directory [ARG]: override bundled template with user-defined template

# Wiki

See the [Bixbite wiki](http://wiki.github.com/doctyper/bixbite) for details on how to utilize the generated template. It also contains details on how to use a customized template if you so wish.
