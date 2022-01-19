PROGRAM FATORACAOLU;

VAR
    MatrizL, MatrizU, MatrizAUX: array [1..20,1..20] of real; {Matrizes usadas no processo}
	vetorB, vetorX, vetorY: array[1..20] of real; {vetores usados no processo}
	tamanhoMatriz, i, j, k, fluxo: integer; {variaveis de controle: i = linha da matriz, j = coluna da matriz, k = estagio do processo}

procedure swapLines(linha:integer);{Realiza a troca entre duas linhas da matriz}
var vetorAux:real;
begin
	for j:= k to tamanhoMatriz do
	begin
		vetorAux := MatrizAUX[k,j];
		MatrizAUX[k,j] := MatrizAUX[linha,j];
		MatrizAUX[linha,j] := vetorAux;
	end;
    vetorAux := vetorB[k];
	vetorB[k] := vetorB[linha];
	vetorB[linha] := vetorAux;
end;

procedure pivoteamento;{Realiza o processo de pivoteamento}
var linha:integer;
begin
	linha := k;
	for i:= k to tamanhoMatriz do if(abs(MatrizAUX[i,k]) > abs(MatrizAUX[linha,k])) then linha := i;
	if NOT(linha = k) then swapLines(linha);
end;

procedure solve;{Método que realiza todo o processo de solução do sistema}
var soma: real;
begin
     MatrizU := MatrizAUX;
	vetorY[1] := vetorB[1];
	for i := 2 to tamanhoMatriz do
	begin
		soma := 0;
		for j:=1 to i-1 do soma := soma + (MatrizL[i,j]*vetorY[j]);
		vetorY[i] := (vetorB[i]-soma);
	end;
	vetorX[tamanhoMatriz] := vetorY[tamanhoMatriz]/MatrizU[tamanhoMatriz,tamanhoMatriz];
	for i := tamanhoMatriz-1 downto 1 do
	begin
		soma := 0;
		for j:= i+1 to tamanhoMatriz do soma := soma + (MatrizU[i,j]*vetorX[j]);
		vetorX[i] := (vetorY[i]-soma)/MatrizU[i,i];
	end;
end;	

procedure stageControl;{Responsável pela definição dos multiplicadores e do pivô, assim como a chamada ao processo de pivoteamento}
var multiplicador:real;
begin
    for k:=1 to tamanhoMatriz-1 do
    begin
 	pivoteamento;
	for i:=k+1 to tamanhoMatriz do
	    begin
		    multiplicador := (MatrizAUX[i,k]/MatrizAUX[k,k]);
     		MatrizAUX[i,k] := 0;
            for j:= k+1 to tamanhoMatriz do MatrizAUX[i,j] := MatrizAUX[i,j] - multiplicador*MatrizAUX[k,j];
	     	MatrizL[i,k] := multiplicador;
	    end;
    end;
end;

procedure criaMatriz;{Define a matriz L}
begin
	for i:= 1 to tamanhoMatriz do
	begin;
		for j := 1 to tamanhoMatriz do
		begin
			if(i=j) then MatrizL[i,j] := 1
			else MatrizL[i,j] := 0;
		end;
	end;
	k :=1;
end;

begin {Método Principal, lógica do programa}
        repeat
        writeln('Insira o tamanho desejado na matriz AUX'); readln(tamanhoMatriz);
	    criaMatriz;
	    for i := 1 to tamanhoMatriz do
	    begin
		    for j := 1 to tamanhoMatriz do
		    begin
			    writeln('Informe o elemento A[',i,',',j,']: '); readln(MatrizAUX[i,j]);
		    end;
	    end;
	    for i:= 1 to tamanhoMatriz do
	    begin
		    writeln('Informe o elemento B[',i,']: '); readln(vetorB[i]);
	    end;
		stageControl;
		solve;
        writeln('O vetor resposta:');
	    for i := 1 to tamanhoMatriz do writeln(round(vetorX[i]));
        writeln('');
        writeln('Para sair digite 0, para continuar digite 1'); readln(fluxo);
     until (fluxo = 0);
end.
