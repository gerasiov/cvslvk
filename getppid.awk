BEGIN {
  getline
  ID=$1
  getline
  for ( i=1; i<=NF; i++ )  {
    if ( $i == "PID" )  {PID=i}
    if ( $i == "PPID" )  {PPID=i}
    }
}

{
  if ( $PID == ID )  {print($PPID)}
}
