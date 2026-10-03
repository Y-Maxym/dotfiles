for k in ${(k)parameters[(R)scalar*export*]}; do
  [[ $k == (PATH|PWD|OLDPWD|SHLVL|_) ]] && continue
  print -r -- "[ -z \"\${$k+x}\" ] && export $k=${(q)${(P)k}}"
done
print -r -- "export PATH=${(q)PATH}"
