BEGIN {
  getline
  for ( i=1; i<=NF; i++ )  {req_p[$i]=1}
  getline
  for ( i=1; i<=NF; i++ )  {dir_p[$i]=1}
  k="NONE"
  kscore=0
}

{
  split($0,a1,"_")
  split(a1[2],a2,"-")
  delete cand_p; for (i in a2) {cand_p[a2[i]]=1}
  for (i in req_p)  { if ( (req_p[i]==1) && (cand_p[i]!=1) )  {next} }
  if ( (dir_p["gcc"]==1) && (cand_p["suncc"]==1) && (req_p["suncc"]!=1) )  {next}
  if ( (dir_p["suncc"]==1) && (cand_p["gcc"]==1) && (req_p["gcc"]!=1) )  {next}
  score=1
  if (cand_p["shared"]==1)     {score+=3}
  if (cand_p["optimized"]==1)  {score+=3}
  for (i in dir_p)  { if ( (dir_p[i]==1) && (cand_p[i]==1) ) score++ }

  if ( score > kscore )  {k=$0; kscore=score}
}

END {print(k)}
