BEGIN  {
  res=0
  getline; split($0,p)
  for ( d=1; p[d]!="--"; d++ );
  if ( NF>1 )  printf("\n")
  for ( i=1; i<d; i++ )  {
    printf("Reference \"%s\": ",p[i]);
    if ( p[i+d]=="NONE" )
      {printf("no working installation available\n"); res=1}
    else
      {printf("resolved into \"%s\"\n",p[i+d])}
    }
  if ( NF>1 )  printf("\n")
  exit(res)
}
