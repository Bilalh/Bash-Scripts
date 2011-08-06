function remember() {
  if [ "$1" = "-s" ]
    then 
    if [ ! -e $HOME/.remember ]
      then touch $HOME/.remember
      chmod 600 $HOME/.remember
    fi
    echo "storing history: "
    date >> $HOME/.remember
    fc -nl remember -1 | tee -a $HOME/.remember
    echo >> $HOME/.remember
  else
    echo "remember -s when finished to save commands"
  fi
  true
}
