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
  delete a1; split($0,a1,"_")
  delete a2; split(a1[3],a2,"-"); delete a2[1]; delete a2[2]
  delete cand_p; for (i in a2) {cand_p[a2[i]]=1}
  for (i in req_p)  { if ( (req_p[i]==1) && (cand_p[i]!=1) )  {next} }
  if ( (dir_p["gcc"]==1) && (cand_p["suncc"]==1) && (req_p["suncc"]!=1) )  {next}
  if ( (dir_p["suncc"]==1) && (cand_p["gcc"]==1) && (req_p["gcc"]!=1) )  {next}
  score=1
  if ( (cand_p["shared"]==1) && (dir_p["static"]!=1) && (req_p["static"]!=1) ) {k+=3}
  for (i in dir_p)  { if ( (dir_p[i]==1) && (cand_p[i]==1) ) score++ }

  if ( score > kscore )  {k=$0; kscore=score}
}

END {print(k)}
