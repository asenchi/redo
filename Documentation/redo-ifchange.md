% redo-ifchange(1) Redo 0.00
% Avery Pennarun <apenwarr@gmail.com>
% 2010-12-12

# NAME

redo-ifchange - rebuild target files when source files have changed

# SYNOPSIS

redo-ifchange [targets...]


# DESCRIPTION

Normally redo-ifchange is run from a .do file that has been
executed by `redo`(1).  See `redo`(1) for more details.

redo-ifchange doesn't take any command line options other
than a list of *targets*.  To provide command line options,
you need to run `redo` instead.

redo-ifchange performs the following steps:

- it creates a dependency on the given *targets*.  If any
  of those targets change in the future, the current target
  (the one calling redo-ifchange) will marked as needing to
  be rebuilt.
  
- for any *target* that is out of date, it calls the
  equivalent of `redo target`.

- for any *target* that is locked (because some other
  instance of `redo` or `redo-ifchange` is already building
  it), it waits until the lock is released.
  
redo-ifchange returns only after all the given
*targets* are known to be up to date.


# TIP

You don't have to run redo-ifchange *before* generating
your target; you can generate your target first, then
declare its dependencies.  For example, as part of
compiling a .c file, gcc learns the list
of .h files it depends on. You can pass this information
along to redo-ifchange, so if any of those headers are
changed or deleted, your .c file will be rebuilt:

        redo-ifchange $1$2
        gcc -o $3 -c $1$2 \
            -MMD -MF $1.deps -MT DELETE_ME
        redo-ifchange $(sed -e 's,^DELETE_ME:,,' \
                            -e 's,\\,,' $1.deps)

This is much less confusing than the equivalent
autodependency mechanism in `make`(1), because make
requires that you declare all your dependencies before
running the target build commands.


# REDO

Part of the `redo`(1) suite.
    
# CREDITS

The original concept for `redo` was created by D. J.
Bernstein and documented on his web site
(http://cr.yp.to/redo.html).  This independent implementation
was created by Avery Pennarun and you can find its source
code at http://github.com/apenwarr/redo.


# SEE ALSO

`redo`(1), `redo-ifcreate`(1), `redo-always`(1), `redo-stamp`(1)
