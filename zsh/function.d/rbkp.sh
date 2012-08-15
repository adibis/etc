# restore from backup with move
rbkp() {
  for file; do
    name=${file%\.*}
    if [ -f $file ] ; then
        if [ -f $name ] ; then
            rm -v $name
        fi ;
    fi ;
    mv -v $file $name
  done
}
