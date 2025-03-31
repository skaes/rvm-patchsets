#!/bin/bash

if [ -z "$rvm_path" ]; then
    echo "rvm_path is not set"
    exit 1
fi

if [ "$@" == "" ]; then
    # reinstall all patches and patchsets
    find $rvm_path/patches $rvm_path/patchsets -name '*railsexpress*' | xargs rm -rf
    cp -rp patches patchsets $rvm_path
    exit 0
fi

for v in "$@"; do
    rm -rf $rvm_path/patches/ruby/$v/railsexpress
    rm -rf $rvm_path/patchsets/ruby/$v/railsexpress
    cp -rp patches/ruby/$v/ $rvm_path/patches/ruby/$v
    cp -rp patchsets/ruby/$v/ $rvm_path/patchsets/ruby/$v
done

for v in "$@"; do
    rvm reinstall $v --patch railsexpress
done
