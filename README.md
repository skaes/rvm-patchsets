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

Reinstall the rubies you want to patch:

    rvm reinstall 1.9.3 --patch railsexpress
    rvm reinstall 2.0.0 --patch railsexpress
    rvm reinstall 2.1.6 --patch railsexpress
    rvm reinstall 2.2.3 --patch railsexpress

Alternatively, you can pass the ruby version to reinstall to the install script:

    ./install.sh 2.1.5

IF you don't want to mess up your vanilla rubies, pass a -n flag to rvm when installing
the patches:

    rvm install 1.9.3 --patch railsexpress -n railsexpress
    rvm install 2.0.0 --patch railsexpress -n railsexpress
    rvm install 2.1.6 --patch railsexpress -n railsexpress
    rvm install 2.2.3 --patch railsexpress -n railsexpress

This will then require you to specify the ruby version for rvm like so:

    rvm use 2.2.3-railsexpress

## Notes

The patches are for specific versions of ruby. They might work with later versions, but
there's no guarantee. The following versions are currently supported:

    1.9.3-p392  # outdated, please use 1.9.3-p547
    1.9.3-p484  # outdated, please use 1.9.3-p547
    1.9.3-p545  # outdated, please use 1.9.3-p547
    1.9.3-p547  # current rvm default for MRI-ruby 1.9.3
    2.0.0-p353  # outdated, please use 2.0.0-p645
    2.0.0-p451  # outdated, please use 2.0.0-p645
    2.0.0-p481  # outdated, please use 2.0.0-p645
    2.0.0-p645  # current rvm default for MRI-ruby 2.0.0
    2.1.0       # starting with 2.1.0, patchlevels are no longer used upstream
    2.1.1       # outdated, please use 2.1.6
    2.1.2       # outdated, please use 2.1.6
    2.1.3       # outdated, please use 2.1.6
    2.1.4       # outdated, please use 2.1.6
    2.1.5       # outdated, please use 2.1.6
    2.1.6       # current rvm default for 2.1 branch
    2.2.0       # outdated, please use 2.2.3
    2.2.1       # outdated, please use 2.2.3
    2.2.2       # outdated, please use 2.2.3
    2.2.3       # current rvm default for 2.2 branch

In order to make some patch level N the default for rvm, add the line(s)

    ruby_1.9.3_patch_level=N
    ruby_2.0.0_patch_level=N
    # invalid after version 2.1.0

to $rvm_path/user/db.

To enable heap dump support, pass the --enable-gcdebug option to the rvm install command.

    rvm install 1.9.3 --patch railsexpress -n gcdebug -C --enable-gcdebug
    rvm install 2.0.0 --patch railsexpress -n gcdebug -C --enable-gcdebug
    # not yet available for 2.1.x, 2.2.x

If rvm cannot configure your ruby, update your rvm install.

If you're like me and prefer to manage the libraries needed for
installing ruby yourself, for example using MacPorts or HomeBrew, then
you might need to tell the ruby compilation process where these
libraries are:

    rvm reinstall 1.9.3 --patch railsexpress -C --with-opt-dir=/opt/local

For up to date rvm installs, use the rvm autolib(s) feature instead.

### Installing on OS X

If you want to install versions earlier than 2.0.0, you must install gcc-4.2.

With MacPorts, this is as easy as

    sudo port install apple-gcc42
    sudo ln -s /opt/local/bin/gcc-apple-4.2 /usr/bin/gcc-4.2

For 2.x, clang works fine.

Additionally, when compiling ruby, you might need to set

    CPPFLAGS=-I/opt/X11/include

Script `install.sh` will set `CPPFLAGS` automatically for you.


### Using patches for ruby-branches

You can install more recent ruby versions from the ruby source
repositories using rvm's branch install feature. Example:

    rvm install 2.0.0-head --patch railsexpress -n railsexpress

You can then use it with the command

    rvm use 2.0.0-head-railsexpress

On 2.1 and 2.2, you can install head similarly:

    rvm install 2.2-head --patch railsexpress -n railsexpress

### Patch Improvements

If you find problems with the patches, please do not send pull requests which patch
patches. I will ignore these.

Instead, add new patches on top of the existing ones. Then they will have a chance.

## Caveats

All patches are provided without any warranty. Use at your own risk!

## Credits

* Some of the patches are based on the work of others
* Some of the the patches are included in ruby enterprise edition
* The set of integrated patces depend on the ruby version
* A modified version of my GC patches have been included in stock ruby

* sigvtalrm patch: http://timetobleed.com/ruby-threading-bugfix-small-fix-goes-a-long-way
* malloc size tracking: http://blog.pluron.com/2008/02/memory-profilin.html
* object allocation tracking: http://rubyforge.org/tracker/index.php?func=detail&aid=11497&group_id=426&atid=1700
* caller for all threads: http://ph7spot.com/musings/caller-for-all-threads
* load performance patch: https://github.com/ruby/ruby/commit/9ce69e7cef1272c86a93eeb9a1888fe6d2a94704#load.c
* optimized hashes: https://gist.github.com/4136373
* array as queue: https://gist.github.com/4136373
