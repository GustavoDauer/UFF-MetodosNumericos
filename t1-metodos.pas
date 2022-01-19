//fpc "t1-metodos.pas" (no diretório: /home/gustavo/Documentos/UFF/3 - Periodo/Métodos Numéricos)
//Free Pascal Compiler version 2.6.2-5 [2013/07/25] for x86_64
//Copyright (c) 1993-2012 by Florian Klaempfl and others
//Target OS: Linux for x86-64
//Compiling t1-metodos.pas
//Linking t1-metodos
//164 lines compiled, 0.7 sec
//Compilação terminada com sucesso.

Program t1metodos;
uses crt;
const MAXL = 20;
const MAXC = MAXINT;
var
	sair:char;
	n, nb, i, ib, j, k, p, q, r: byte;
	aux, m: real;
    A, AOriginal, L, U: array [1..MAXL,1..MAXL] of real;
    Bs: array [1..MAXL,1..MAXC] of real; // Bs = matriz que armazena os vetores B, cada coluna representa um vetor B
	X, Y: array[1..MAXL] of real;
	B: array[1..MAXL] of real; // Vetor B significa o vetor B usado em questão (para cálculos)		

procedure pivoteamentoParcial(k:byte);
var 
	ln:byte;
begin			
	ln:=k;
	for i:=k to n do 
		if(abs(A[i,k]) > abs(A[ln,k])) then 
			ln:=i;
	if not(ln=k) then 
		for j:=k to n do
		begin
			aux:=A[k,j];
			A[k,j]:=A[ln,j];
			A[ln,j]:=aux;									
		end;												
		aux:=B[k];
		B[k]:=B[ln];
		B[ln]:=aux;					
		//writeln('Trocando ', B[k], ' com ', B[ln]);		
end;

procedure fatoraLU(); // Solucao atraves de fatoracao LU
var s: real;
var i, j: byte;
begin
    U:=A;
	Y[1]:=B[1];
	//Y[1]:=Bs[1][ib];
	for i:=2 to n do
	begin
		s:=0;
		for j:=1 to i-1 do s := s + (L[i,j]*Y[j]);
		Y[i]:=(B[i]-s);
		//Y[i]:=(Bs[i][ib]-s);
	end;
	X[n]:=Y[n]/U[n,n];
	for i:=n-1 downto 1 do
	begin
		s:=0;
		for j:=i+1 to n do s:=s+(U[i,j]*X[j]);
		X[i]:=(Y[i]-s)/U[i,i];
	end;
end;	

Begin
    writeln('-------------------------------------------------');
    writeln('Trabalho de Metodos Numericos - Fatoracao LU com varios Bs');
    writeln('Aluno: Gustavo Henrique Mello Dauer');
    writeln('-------------------------------------------------');
    writeln('ATENCAO: Por comodidade:');
    writeln(' - A insercao da matriz A eh feita por LINHA!');
    writeln(' - A insercao da matriz B eh feita por COLUNA!');
    writeln('-------------------------------------------------');
    writeln('');
    sair:=' ';
    while(sair<>'s') do // Para so sair do programa apos o usuario digitar s
    begin
		writeln('Entre com N, o tamanho da matriz A NxN e B NxM (MAXIMO N = 20)):'); readln(n);
		writeln('Entre com M, a quantidade de Bs (colunas da matriz B NxM) (MAXIMO M = MAXINT):'); readln(nb);
		for i:=1 to n do	
		begin	
			for j:=1 to n do
			begin
				if(i=j) then 
					L[i,j]:=1
				else 
					L[i,j]:=0;			
			end;
		end;
		k:=1;
		for i:=1 to n do
		begin
			for j:=1 to n do
			begin
				writeln('Entre com o elemento a',i,',',j,': '); readln(A[i,j]); // Dados da matriz A
				AOriginal[i,j]:=A[i,j];
			end;
		end;
		for i:=1 to nb do
		begin
			for j:=1 to n do
			begin				
				writeln('Entre com o elemento b',j,',',i,' de B,', i, ': '); readln(Bs[j][i]); // Dados dos vetores B
				//B[j]:=Bs[j][i]; // BUGOU!
			end;
		end;
		{iB:=1; // BUGOU!
		for k:=1 to n-1 do
	    	begin	 	
		 	pivoteamentoParcial();
			for i:=k+1 to n do
			begin
				m := (A[i,k]/A[k,k]);
	     		A[i,k] := 0;
			    for j:=k+1 to n do A[i,j] := A[i,j] - m*A[k,j];
		     	L[i,k]:=m;
		    	end;
	    	end;}
	    for ib:=1 to nb do
	    begin
			for p:=1 to n do
			begin
				B[p]:=Bs[p][ib];
			end;
			for q:=1 to n do
			begin
				for r:=1 to n do
				begin
					A[q,r]:=AOriginal[q,r];
				end;
			end;
			for k:=1 to n-1 do
			begin	 	
				pivoteamentoParcial(k);
				for i:=k+1 to n do
				begin
					m := (A[i,k]/A[k,k]);
					A[i,k] := 0;
					for j:=k+1 to n do A[i,j] := A[i,j] - m*A[k,j];
						L[i,k]:=m;
				end;
			end;
			fatoraLU();
			writeln('');
			writeln('------------------------------------');
			writeln('A solucao do sistema para B',ib,' e: ');			
			for q:=1 to n do
			begin
				writeln(round(X[q]), ' = ARREDONDAMENTO DE ', X[q]);
			end;
			writeln('');
			{writeln('------------------------------------'); //
			writeln('A solucao arredondada do sistema para B',ib,' e: ');			
			for q:=1 to n do
			begin
				writeln(round(X[q]));
			end;}			
		end;
		writeln('Digite (s) para sair do programa, ou qualquer tecla para continuar: ');
		readln(sair);
	end;
end.
