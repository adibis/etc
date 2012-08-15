# backup with move
cbkp() {
  for file; do
    cp -v $file{,.bak}
  done
}
