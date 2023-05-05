relative_source deploy/create_disk.sh
relative_source deploy/setup_loop.sh
relative_source deploy/create_fs.sh
relative_source deploy/create_mountpoint.sh
relative_source deploy/mount_tree.sh
relative_source deploy/pacstrap_from_repo.sh
relative_source deploy/pacstrap_built.sh
relative_source deploy/genfstab_root.sh
relative_source deploy/populate_blob.sh
relative_source deploy/populate_boot.sh
relative_source deploy/get_versions.sh

deploy() {
  echo "=> Deploying..."
  create_disk
  setup_loop
  create_fs
  create_mountpoint
  mount_tree
  pacstrap_from_repo
  pacstrap_built
  genfstab_root
  populate_blob
  populate_boot
  get_versions
  echo "=> Deploy end"
}