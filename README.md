# RVM Patchsets for MRI-Ruby

## About

Over time, I have developed a number of patches to MRI ruby which I use in all my
projects. I maintain them using stgit. This repository provides them as patchsets for RVM.

They are also frequently merged into the main rvm repository, so usually you can use
them directly after installing/updating rvm.

## Usage

### Step 1

To use the a recent version of the patchsets, just update rvm:

    rvm get head # OR
    rvm get stable

If rvm isn't update to date yet, or you can easily install them from this repository:

* clone the repository to some convenient place
* cd into the top level directory
* run `install.sh`

This will automatically remove old versions of the patchsets.

Note: if you are using zsh you might experience problems. It seems that
switching to bash fixes these (see https://github.com/skaes/rvm-patchsets/issues/20).

### Step 2

Reinstall the rubies you want to patch with railsexpress:

    rvm reinstall 1.8.7 --patch railsexpress
    rvm reinstall 1.9.2 --patch railsexpress
    rvm reinstall 1.9.3 --patch railsexpress
    rvm reinstall 2.0.0 --patch railsexpress

Alternatively, you can pass the ruby version to reinstall to the install script:

    ./install.sh 1.9.3 2.0.0

If you don't want to mess up your vanilla rubies, pass a -n flag to rvm when installing
the patches:

    rvm install 1.8.7 --patch railsexpress -n railsexpress
    rvm install 1.9.2 --patch railsexpress -n railsexpress
    rvm install 1.9.3 --patch railsexpress -n railsexpress
    rvm install 2.0.0 --patch railsexpress -n railsexpress

This will then require you to specify the ruby version for rvm like so:

    rvm use 2.0.0-railsexpress

Reinstall the rubies you want to patch with float_warnings accordingly:

    rvm install 1.9.3 --patch float_warnings -n float_warnings
    rvm install 2.0.0 --patch float_warnings -n float_warnings

## Notes

The patches are for specific versions of ruby. They might work with later versions, but
there's no guarantee. The following versions are currently supported:

    1.8.7-p334  # not recommended, use p371 or head
    1.8.7-p352  # not recommended, use p371 or head
    1.8.7-p357  # not recommended, use p371 or head
    1.8.7-p358  # not recommended, use p371 or head
    1.8.7-p370  # not recommended, use p371 or head
    1.8.7-p371  # current rvm default for MRI-ruby 1.8.7
    1.9.2-p180  # not recommended, use 1.9.3 or 2.0.0
    1.9.2-p290  # not recommended, use 1.9.3 or 2.0.0
    1.9.2-p318  # not recommended, use 1.9.3 or 2.0.0
    1.9.2-p320  # not recommended, use 1.9.3 or 2.0.0
    1.9.3-p125  # not recommended, use p484 or head
    1.9.3-p194  # not recommended, use p484 or head
    1.9.3-p286  # not recommended, use p484 or head
    1.9.3-p327  # not recommended, use p484 or head
    1.9.3-p362  # not recommended, use p484 or head
    1.9.3-p374  # not recommended, use p484 or head
    1.9.3-p385  # not recommended, use p484 or head
    1.9.3-p429  # not recommended, use p484 or head
    1.9.3-p448  # not recommended, use p484 or head
    1.9.3-p484  # current rvm default for MRI-ruby 1.9.3

    2.0.0-p353  # current rvm default for MRI-ruby 2.0.0

In order to make some patch level N the default for rvm, add the line(s)

    ruby_1.8.7_patch_level=N
    ruby_1.9.3_patch_level=N
    ruby_2.0.0_patch_level=N

to $rvm_path/user/db.

To enable heap dump support, pass the --enable-gcdebug option to the rvm install command.

    rvm install 1.9.3 --patch railsexpress -n gcdebug -C --enable-gcdebug
    rvm install 2.0.0 --patch railsexpress -n gcdebug -C --enable-gcdebug

If rvm cannot configure your ruby, update your rvm install.

If you're like me and prefer to manage the libraries needed for
installing ruby yourself, for example using MacPorts or HomeBrew, then
you might need to tell the ruby compilation process where these
libraries are:

    rvm reinstall 1.9.3 --patch railsexpress -C --with-opt-dir=/opt/local

For up to date rvm installs, use the rvm autolib(s) feature.

### Installing on Mountain Lion

If you want to install versions earlier than 1.9.3, you must install gcc-4.2.

With MacPorts, this is as easy as

    sudo port install apple-gcc42
    sudo ln -s /opt/local/bin/gcc-apple-4.2 /usr/bin/gcc-4.2

Additionally, when compiling ruby, you might need to set

    CPPFLAGS=-I/opt/X11/include

Script `install.sh` will set `CPPFLAGS` automatically for you.


### Using patches for ruby-branches

You can install more recent ruby versions from the ruby source
repositories using rvm's branch install feature. Example:

    rvm install 1.9.3-head --patch railsexpress -n railsexpress

You can then use it with the command

    rvm use 1.9.3-head-railsexpress

On 2.0.0, you can install head similarly:

    rvm install 2.0.0-head --patch railsexpress -n railsexpress

### Patch Improvements

If you find problems with the patches, please do not send pull requests which patch
patches. I will ignore these.

Instead, add new patches on top of the existing ones. Then they will have a chance.

## Caveats

All patches are provided without any warranty. Use at your own risk!

## Credits

* Some of the patches are based on the work of others
* Some of the the patches are included in ruby enterprise edition
* A modified version of my GC patches have been included in stock ruby

* sigvtalrm patch: http://timetobleed.com/ruby-threading-bugfix-small-fix-goes-a-long-way
* malloc size tracking: http://blog.pluron.com/2008/02/memory-profilin.html
* object allocation tracking: http://rubyforge.org/tracker/index.php?func=detail&aid=11497&group_id=426&atid=1700
* caller for all threads: http://ph7spot.com/musings/caller-for-all-threads
* load performance patch: https://github.com/ruby/ruby/commit/9ce69e7cef1272c86a93eeb9a1888fe6d2a94704#load.c
* optimized hashes: https://gist.github.com/4136373
* array as queue: https://gist.github.com/4136373
