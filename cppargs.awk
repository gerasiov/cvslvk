{
  inLongArg = 0;
  for ( i=1; i<=NF; i++ )  {
    if ( split($i,x,"(")>1 )  $i="\""$i"\"";
    if ( substr($i,1,1)!="-" )  continue;
    p = i-1;  n = i+1;
    if ( inLongArg )  { $p=$p"\""; inLongArg=0; }
    if ( split($i,a,"=")==2 && i<NF && substr($n,1,1)!="-" )  { $i=a[1]"=\""a[2]; inLongArg=1; }
    }
  for ( i=1; i<=NF; i++ )  {
    printf($i);
    if ( i<NF )  printf(" ");
    }
  if ( inLongArg )  printf("\"");
  printf("\n");
}
