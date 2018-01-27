function [X t] = preprocess(path,histogram_type,count_bins)
%{
	adaug la numele caii date ca parametru directorul din care preiau pozele
	pentru a putea folosi functia getImgNames si memorez numele acestor cai
	intr-o matrice
%}
	newpath_cats = strcat(path,"cats/");
	Images_cats = getImgNames(newpath_cats);
	[nr_rows1 nr_cols1] = size(Images_cats);
	
	newpath_not_cats = strcat(path,"not_cats/");
	Images_not_cats = getImgNames(newpath_not_cats);
	[nr_rows2 nr_cols2] = size(Images_not_cats);
	
	nr_rows = nr_rows1 + nr_rows2;
%{
	concatenez matricele ce contin calea catre directorul cats si catre
	not_cats
%}
	Images = [Images_cats ; Images_not_cats];
%{
	determin vectorul de caracteristici pentru fiecare poza creand calea
	catre poza respectiva si utilizand functiile implementate la taskurile
	1 si 2 pentru a intoarce histogramele
%}
	for i = 1:nr_rows		
%{
	deoarece am concatenat vectorul de imagini care au pisici cu cele care 
	nu au pisici pentru a calcula corect histograma si vectorul de etichete
	punem o conditie suplimentara in if aceea ca daca avem indicele mai mic
	sau egal cu nr_rows1 prelucram poze cu pisici, iar daca indicele e mai mare ca 
	nr_rows1 prelucram poze fara pisici
%}
		if( strcmp(histogram_type,"RGB") == 1 && i <= nr_rows1 )
			path_histogram = strcat(newpath_cats,Images(i,:));
			X(i,:) = rgbHistogram(path_histogram,count_bins);
			t(i) = 1;
		endif
		if( strcmp(histogram_type,"HSV") == 1 && i <= nr_rows1)
			path_histogram = strcat(newpath_cats,Images(i,:));
			X(i,:) = hsvHistogram(path_histogram,count_bins);
			t(i) = 1;
		endif
		if( strcmp(histogram_type,"RGB") == 1 && i > nr_rows1 )
			path_histogram = strcat(newpath_not_cats,Images(i,:));
			X(i,:) = rgbHistogram(path_histogram,count_bins);
			t(i) = -1;
		endif
		if( strcmp(histogram_type,"HSV") == 1 && i > nr_rows1)
			path_histogram = strcat(newpath_not_cats,Images(i,:));
			X(i,:) = hsvHistogram(path_histogram,count_bins);
			t(i) = -1;
		endif
	endfor
	t = t';

endfunction
