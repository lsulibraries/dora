#!/bin/bash

## compare many git repos in a given subdirectory

dir=$1

# https://stackoverflow.com/questions/9612090/how-to-loop-through-file-names-returned-by-find
for i in $(find $dir -name \*.git); do # Not recommended, will break on whitespace
    # https://stackoverflow.com/questions/11981716/how-to-quickly-find-all-git-repos-under-a-directory
    cd $i/.. > /dev/null
    head=$(git rev-parse HEAD)
    # https://unix.stackexchange.com/questions/35832/how-do-i-get-the-md5-sum-of-a-directorys-contents-as-one-sum
    sha=$(find $i -type f -exec md5sum {} \; | sha1sum)

    echo "HEAD: $head   ---   MD5: $sha  --- Path: $i"
done
