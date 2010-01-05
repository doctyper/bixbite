# Bixbite Project Initializer

Bixbite is a [Ruby gem](http://gemcutter.org/gems/bixbite/) that creates a project structure optimal for client-side development.

* Downloads the latest versions of [Google Ajax API Libraries](http://code.google.com/apis/ajaxlibs/)
* Uses [LABjs](http://labjs.com/) for parallelized script management
* Allows full use of server-side includes for shared module management
* Bundles a customized [PHP Minify](http://code.google.com/p/minify/) package using [Google's Closure Compiler](http://code.google.com/closure/compiler/) for on-the-fly compression tests
* Dynamic to static publishing eliminates server-side dependencies on delivery

Additionally, Bixbite includes rake tasks to automatically:

* Create new page templates & associated JS/CSS files
* Prepare files for deployment
* Generate NaturalDocs-compliant documentation
* Compress PNG files using [PNGout](http://advsys.net/ken/utils.htm)
* Gracefully degrade 24-bit PNG files for Internet Explorer 6
* Deliver compressed versions of CSS & JavaScript files using  [Google's Closure Compiler](http://code.google.com/closure/compiler/) & [YUI Compressor](http://developer.yahoo.com/yui/compressor/)
* Add new files, remove outdated files from Subversion
* Generate diff reports for each delivery

Bixbite can be [fully customized](http://wiki.github.com/doctyper/bixbite) to fit your personal development tastes.

## Links

 * [Wiki](http://wiki.github.com/doctyper/bixbite)
 * [Bugs](http://github.com/doctyper/bixbite/issues)

## Installing

# Install the gem:
    gem install bixbite

## Usage

# Generating a Bixbite template

Run the Bixbite gem to generate a new template:

    bixbite "The Foo Project" FOO

This command will generate a template with a project name of "The Foo Project" and support files (JS/PHP) using the FOO namespace.

You may also specify arguments when invoked. Via `bixbite --help`:

 * --js-lib [ARG]: use specified JavaScript library (options: jQuery, YUI, MooTools)
 * --source-directory [ARG]: override bundled template with user-defined template

## Quick Examples

See [Rake tasks](http://wiki.github.com/doctyper/bixbite/rake-tasks) for more information.

### Creation

#### Create "Example Project" with EXAMPLE namespace
`bixbite "Example Project" EXAMPLE`

#### Create "Example Project" with EXAMPLE namespace using MooTools
`bixbite "Example Project" EXAMPLE --js-lib MooTools`

#### Create "Example Project" with EXAMPLE namespace using a custom template
`bixbite "Example Project" EXAMPLE /path/to/custom-template`

#### Use a custom template by default
`bixbite --source-directory /path/to/custom-template`

### Bundled Rake Tasks

#### Publish deployable files, generate documentation, perform Subversion tasks
`rake prep`

#### Create new page template
`rake bixbite:page`

#### Publish compressed files to deploy folder
`rake files:compress`

#### Compress PNGs
`rake png:compress`

## Wiki

See the [Bixbite wiki](http://wiki.github.com/doctyper/bixbite) for details on how to utilize the generated template. It also contains details on how to use a customized template if you so wish.
