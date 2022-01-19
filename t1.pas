Program t1metodos;
uses crt;
var 
	i, j, n: integer;
	A: array[1..20] of array[1..20] of integer;
	
procedure mostraMatriz();
begin
	writeln('-------------------------------');
	for i:= 1 to n do
		for j:= 1 to n do
			write(A[i][j], ' ');
			if(j=n) then
				writeln();
end;

procedure LU_PP(n:integer);
var
	L: array[1..20] of array[1..20] of integer;
	U: array[1..20] of array[1..20] of integer;
	i, j, e: integer;
begin
	e:=1;
	for i:=1 to n-1 do
		for j:=0 to n-1 do
		begin
			if (i=j) then
				L[i][j]:=1;
			else if(i>j) then
		end;
end;

begin
clrscr;
writeln('Trabalho 1 de Metodos Numericos');
writeln('-------------------------------');
writeln('');
writeln('Entre com o tamanho da matriz: '); read(n);	

for i:= 1 to n do
begin
	for j:= 1 to n do
	begin
		write('a',i,j,': ');read(A[i][j]);
	end;
end;

clrscr;

writeln('MATRIZ');
mostraMatriz();

writeln('');
writeln('Chamando funcao de resolucao pelo metodo LU com pivoteamento parcial');
writeln('---------------------------------------------------------------------');
LU_PP(n);

end.
