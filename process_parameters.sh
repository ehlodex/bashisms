#!/usr/bin/env bash

# This is a very basic framework for processing a mixture of arguments and
# options. Additional error correction and/or validation should be implemented
# for options with $OPTARG equivalents and also for unknown options.

argslist=""
afs=":"  # Argument Field Separator, a la IFS

while [ $# -gt 0 ]; do
  case "$1" in
    -s|--switch)
      s=true
      ;;
    -o|--option)
      o=""
      # if $2 doesn't start with - then assume it's an $OPTARG
      if [ "${2#-*}" = "$2" ] && [ -n "$2" ]; then
        o="$2"
        shift
      fi
      ;;
    -*)
      :  # ignore unknown options; set to 'shift' to ignore "$OPTARG" too
      ;;
    *)
      if [ -n "$argslist" ]; then
        argslist+="$afs";
      fi;
      argslist+="$1"
      ;;
  esac
  shift
done

# Load $argslist back into $@ instead of a separate array...for POSIX reasons
IFS="$afs"
set -- $(echo "$argslist" | tr "$afs" "$afs")
unset IFS

# DEMO # -------------------------------------------------------------------- #

if [ ! -v s ]; then
  s="false"
fi

if [ -v o ] && [ -z "$o" ]; then
  o="true, but unset"
elif [ ! -v o ]; then
  o="false"
fi

echo "s: $s"
echo "o: $o"
echo -n "@: "
if [ -n "$argslist" ]; then
  echo "$#"
  for arg in "$@"; do
    echo " -> $arg"
  done
else
  echo "(none)"
fi
