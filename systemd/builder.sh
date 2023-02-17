# This should only be run on the build machine, NOT the dev machine, it will break the local changes!
git fetch --all
git reset --hard origin/master
git submodule init
git submodule update
releases=($(ls releases/ArchLinuxARM-*)) || true
if [[ "${#releases[@]}" -gt 8 ]]; then # Only keep 8
  rm -f ${releases[@]::((${#releases[@]}-8))}
fi
. build.sh