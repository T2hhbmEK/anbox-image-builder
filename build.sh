#/bin/sh
set -e

DOCKER="docker"

if [ "$1" == "--sudo" ]; then
  DOCKER="sudo docker"
fi

if [ "$1" == "--podman" ]; then
  DOCKER="podman"
fi

if [ "$1" == "--help" ]; then
  echo "$0 [--sudo] [--podman]"
  echo
  echo "Anbox image builder."
  echo "Use --sudo to run Docker with sudo (use if you get \"permission denied\" error)."
  echo "Use --podman to use Podman instead of Docker."
  exit 0
fi

$DOCKER build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t anbox-build-trusty .
mkdir -p anbox-work
$DOCKER run -it --rm -v "$(realpath anbox-work)":/src anbox-build-trusty /data/anbox-build.sh
