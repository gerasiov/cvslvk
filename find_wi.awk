BEGIN {
  FS="-"
  RS="[ \n]"
  getline
  for ( i=1; i<=NF; i++ )  {req_p[$i]=1}
  getline
  for ( i=1; i<=NF; i++ )  {dir_p[$i]=1}
  k="NONE"
  kscore=0
}

{
  split($0,a1,"_")
  split(a1[3],a2,"-"); delete a2[1]; delete a2[2]
  delete cand_p; for (i in a2) {cand_p[a2[i]]=1}
  for (i in req_p)  { if ( !(i in cand_p) )  {next} }
  if ( ("gcc" in dir_p) && ("suncc" in cand_p) && !("suncc" in req_p) )  {next}
  if ( ("suncc" in dir_p) && ("gcc" in cand_p) && !("gcc" in req_p) )  {next}
  score=1
  if ( ("shared" in cand_p) && !("static" in dir_p) && !("static" in req_p) ) {k+=3}
  for (i in dir_p)  { if (i in cand_p) score++ }

  if ( score > kscore )  {k=$0; kscore=score}
}

END {print(k)}
