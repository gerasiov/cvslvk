{
  inLongArg = 0;
  for ( i=1; i<=NF; i++ )  {
    res[i] = $i;
    if ( substr($i,1,1)!="-" )  continue;
    p = i-1;  n = i+1;
    if ( inLongArg )  { res[p]=$p"\""; inLongArg=0; }
    if ( split($i,a,"=")==2 && i<NF && substr($n,1,1)!="-" )  { res[i]=a[1]"=\""a[2]; inLongArg=1; }
    }
  for ( i=1; i<=NF; i++ )  {
    printf(res[i]);
    if ( i<NF )  printf(" ");
    }
  if ( inLongArg )  printf("\"");
  printf("\n");
}
