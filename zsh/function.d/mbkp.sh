# backup with move
mbkp() {
  for file; do
    mv -v $file{,.bak}
  done
}
