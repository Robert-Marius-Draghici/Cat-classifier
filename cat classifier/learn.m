function w = learn(X,t)
	[nr_rows nr_cols] = size(X);
	X(:,nr_cols + 1) = 1;
%{
	implementez algoritmul Gram Schmidt pentru a descompune matricea X
	in Q si R si rezolvam sistemul pentru a afla vectorul de parametri w
	ce modeleaza sistemul de invatare, utilizand si o functie ce rezolva
	un sistem superior triunghiular
%}
	[Q R] = gram_schmidt(X);
	b = Q' * t;
	w = SST(R,b);		
endfunction
