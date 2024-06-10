#!/bin/bash

set -euo pipefail

if [ $# -eq 0 ]; then
  BASE_URL="https://web.evanchen.cc"
elif [ "$1" = "-local" ]; then
  BASE_URL="file:///home/evan/Sync/www/"
else
  echo "huh?"
  exit 1
fi

python3 poole/poole.py -b --base-url="$BASE_URL" \
  --md-ext=extra \
  --md-ext=smarty \
  --md-ext=sane_lists \
  --md-ext=mdx_truly_sane_lists >/dev/null

# reformat output with tidy
tidy -config ./tidyrc -qm ./output/*.html

# reformat it with prettier afterwards
prettier -w ./output/*.html

# Lint everything
./lint.sh
