#!/usr/bin/env zsh

NEWLINE="
"
BASEDIR=$(dirname "$0");
USERHOME=$(cd ~; pwd);
BASEHOME=$(cd "$BASEDIR/home"; pwd);
CACHEDDIR=$(pwd)

cd "${USERHOME}";
for file in $(ls -1 "$BASEHOME"); do
  LINKPATH=".${file}"
  FILEPATH="${BASEHOME}/${file}"
  if [ -e "${LINKPATH}" ] || [ -L "${LINKPATH}" ]; then
    read -q "confirm?${NEWLINE}${LINKPATH} already exists. Do you want to delete?" || continue;
    rm "${LINKPATH}";
  fi

  ln -s $FILEPATH $LINKPATH
done;
cd "${CACHEDDIR}";
