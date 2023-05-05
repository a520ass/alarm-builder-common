relative_source setup/setup_outside.sh
relative_source setup/setup_inside.sh

setup() {
  setup_outside
  setup_inside
}