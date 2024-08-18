azrepo() {
  az repos show --repository $(basename $(git rev-parse --show-toplevel)) --open
}

azpipe() {
  az pipelines show --name $(basename $(git rev-parse --show-toplevel)) --open
}

azrun() {
  az pipelines run --name $(basename $(git rev-parse --show-toplevel)) --open
}

azpr() {
  az repos pr create --repository $(basename $(git rev-parse --show-toplevel)) --open
}