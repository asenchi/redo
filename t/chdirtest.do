rm -f chdir1
redo chdir2
redo chdir3

. ./flush-cache.sh
redo-ifchange chdir3

rm -f chdir1
. ./flush-cache.sh
redo-ifchange chdir3
[ -e chdir1 ] || exit 77

rm -f chdir1
. ./flush-cache.sh
redo-ifchange chdir3
[ -e chdir1 ] || exit 78
