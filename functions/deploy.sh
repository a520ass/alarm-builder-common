. common/functions/deploy/create_disk.sh
. common/functions/deploy/setup_loop.sh
. common/functions/deploy/create_fs.sh
. common/functions/deploy/create_mountpoint.sh
. common/functions/deploy/mount_tree.sh
. common/functions/deploy/pacstrap_from_repo.sh
. common/functions/deploy/pacstrap_aur.sh
. common/functions/deploy/genfstab_root.sh
. common/functions/deploy/get_versions.sh

deploy() {
  echo "=> Deploying..."
  create_disk
  setup_loop
  create_fs
  create_mountpoint
  mount_tree
  pacstrap_from_repo
  pacstrap_aur
  genfstab_root
  populate_blob
  get_versions
  echo "=> Deploy end"
}