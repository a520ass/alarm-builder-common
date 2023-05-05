relative_source sanity_check/no_root.sh
relative_source sanity_check/no_makepkg_conf.sh

sanity_check() {
  echo "=> Sanity checking..."
  no_root
  no_makepkg_conf
  echo "=> Sanity check end"
}