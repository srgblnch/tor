export INTERACTIVE='-i'
export PERSISTENCY="--rm --restart unless-stopped "
export NETWORKING=""  # "--net host"
export VOLUMES="-v $(pwd)/hiddenweb/web:/web"