function [Q, R] = gram_schmidt(A)
%{
	algoritmul Gram Schmidt descompune matricea data ca parametru
	intr-o matrice ortogonala(coloanele sale formeaza o baza 
	ortonormata) Q si o matrice superior triunghiulara R
%}
	[nr_rows nr_cols] = size(A);
% initializam cele doua matrice Q si R cu 0
	Q = zeros(nr_rows,nr_cols);
	R = zeros(nr_cols);
	
	for j = 1 : nr_cols
		
		R(1:j-1,j) = Q(:,1:j-1)' * A(:,j);
			
		s = zeros(nr_rows,1);
		s = Q(:, 1:j-1) * R(1:j-1, j);
		
		aux = A(:,j) - s;		
		 
%{
	calculam norma cu una din formulele prezentate in laborator si nu 
	cu functia norm pentru o acuratete mai mare
%}
		norm = sqrt(sum(aux.*aux));
		R(j,j) = norm;
		Q(:,j) = aux/R(j,j);
	endfor
endfunction
