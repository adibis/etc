# Defrag SQLite databases of Mozilla Firefox and Thunderbird
function mozdefrag() {
  pgrep 'firefox|thunderbird' &> /dev/null
  
  if [ $? -eq 0 ]
  then
    echo Close Thunderbird and Firefox first
    return 1
  fi
  
  for f in $(find $HOME/{.mozilla,.thunderbird} -name '*.sqlite')
  do
    sqlite3 $f 'VACUUM; REINDEX;'
  done
}
