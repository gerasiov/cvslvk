# Первая строка - разделенный пробелами список вида записей вида xxx<yyy
# (значит xxx должно стоять перед yyy) или xxx>yyy
# Вторая строка - разделенный пробелами список библиотек
# Выдает порядок или сообщение об ошибке

BEGIN  {
 # Загружаем строку с требованиями
  getline;
  allreq = $0;
  for ( i=1; i<=NF; i++ )  {
    if ( split($i,a,",")==2 )
      { orders[a[1]"@"a[2]] = 1 }
    else
      { print ( "Invalid library order requirement: " $i );  exit 1; }
    }
 # Загружаем строку с библиотеками
  getline;
 # Если библиотек нет, то делать нечего
  if ( NF==0 )  exit 0;
 # Если требований нет, то сохраним исходный порядок
  if ( allreq=="" )  { print; exit 0 }
 # Делаем все библиотеки индексами массива
  for ( i=1; i<=NF; i++ )  { libs[$i]=1 }
 # Всего надо разместить NF библиотек
  for ( i=1; i<=NF; i++ )  {
   # Находим библиотеку, перед которой ничего не должно быть.
    for (lib in libs)  {
      if ( libs[lib]!=1 )  continue;   # Будь он проклят, SUN awk !..
      cand=lib;
      for (order in orders)  {
        if ( orders[order]!=1 )  continue;   # Будь он проклят, SUN awk !..
        split ( order, a, "@" );
	if ( a[2]==lib )  {cand=""; break}
	}
      if ( cand!="" )  break;
      }
   # Если такой нет, значит требования противоречивы.
    if ( cand=="" )
      { print ( "Unresolvable library order requirements: " allreq );  exit 1; }
   # Добавляем выбранную библиотеку в список
    if ( res=="" )  {res=cand}  else {res=res" "cand}
   # Удаляем размещенную библиотеку из исходного списка
    libs[cand]=0;   # Будь он проклят, SUN awk !..
   # Удаляем все требования, где эта библиотека первая (они уже выполнены)
    for (order in orders)  {
      if ( orders[order]!=1 )  continue;   # Будь он проклят, SUN awk !..
      split ( order, a, "@" );
      if ( a[1]==cand )  {orders[order]=0}
      }
    }
 # Размещение удачно
  print ( res );
  exit 0;
}
