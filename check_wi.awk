BEGIN  {
  res=0
  getline; split($0,p)
  for ( d=1; p[d]!="--"; d++ );
  for ( i=1; i<d; i++ )  {
    if ( p[i+d]=="NONE" )
      {printf("No working installation available for \"%s\"\n",p[i]); res=1}
    }
  exit(res)
}
