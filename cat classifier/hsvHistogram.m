function [histogram_hsv] = hsvHistogram(path,count_bins)
	Image = imread(path);
	red_channel = Image(:,:,1);
	green_channel = Image(:,:,2);
	blue_channel = Image(:,:,3);

	red_channel_temp = double(red_channel)/255;
	green_channel_temp = double(green_channel)/255;
	blue_channel_temp = double(blue_channel)/255;

	[nr_rows nr_cols] = size(red_channel_temp);

%{
	am nevoie de acesti indici, deoarece vreau sa transform matricele de pixeli
	in vectori
%}	
	if(nr_rows == 80)
		i = 1:80;
		j = 1:120;
		k = 1:9600;
	elseif(nr_rows == 120)
		i = 1:120;
		j = 1:80;
		k = 1:9600;
	endif
	
	red_channel_vector(k) = red_channel_temp(i,j);
	green_channel_vector(k) = green_channel_temp(i,j);
	blue_channel_vector(k) = blue_channel_temp(i,j);

	aux(k) = max(red_channel_vector,green_channel_vector);
	Cmax(k) = max(aux,blue_channel_vector);
	
	aux(k) = min(red_channel_vector,green_channel_vector);
	Cmin(k) = min(aux,blue_channel_vector);

	delta = Cmax - Cmin;
	
%{
	caut indecsii pentru fiecare matrice de culori ce respecta conditia din if din algoritmul prezentat
	in enunt; de asemenea verific faptul ca delta este diferit de 0 pentru a nu imparti la 0 atunci cand
	calculez valoarea respectiva din matricea H; avand in vedere ca exista valori comune pentru R,G,B am 
	calculat mai intai pentru valorile unice si apoi pentru valorile comune pentru a nu repeta anumite
	rezultate
%}
	H(find(delta == 0)) = 0;
	index_red = find(Cmax == red_channel_vector & Cmax != green_channel_vector & Cmax != blue_channel_vector & delta != 0);
	index_green = find(Cmax == green_channel_vector & Cmax != red_channel_vector & Cmax != blue_channel_vector & delta != 0);
	index_blue = find(Cmax == blue_channel_vector & Cmax != green_channel_vector & Cmax != red_channel_vector & delta != 0);
	index_red_green = find(Cmax == red_channel_vector & Cmax == green_channel_vector & delta != 0);
	index_red_blue = find(Cmax == red_channel_vector & Cmax == blue_channel_vector & delta != 0);
	index_blue_green = find(Cmax == blue_channel_vector & Cmax == green_channel_vector & delta != 0);
	
	H(index_red) = 60*mod((green_channel_vector(index_red).-blue_channel_vector(index_red))./delta(index_red),6);
	H(index_green) = 60*((blue_channel_vector(index_green).-red_channel_vector(index_green))./delta(index_green)+2);
	H(index_blue) = 60*((red_channel_vector(index_blue).-green_channel_vector(index_blue))./delta(index_blue)+4);
	H(index_red_blue) = 60*((red_channel_vector(index_red_blue).-green_channel_vector(index_red_blue))./delta(index_red_blue)+4);
	H(index_blue_green) = 60*((red_channel_vector(index_blue_green).-green_channel_vector(index_blue_green))./delta(index_blue_green)+4);
	H(index_red_green) = 60*((red_channel_vector(index_red_green).-green_channel_vector(index_red_green))./delta(index_red_green)+4);

	S(find(Cmax==0)) = 0;
	S(find(Cmax!=0)) = delta(find(Cmax!=0))./Cmax(find(Cmax!=0));
	
	V = Cmax;

%{
	folosirea operatorului Haddamard pentru normarea matricei H reduce timpul de executie al programului
	cu 2 secunde fata de cazul in care am norma matricea in interiorul celor 2 for-uri imbricate (optimizarea
	fusese realizata pentru implementarea initiala ce folosea 2 for-uri imbricate pentru parcurgerea 
	matricei de pixeli
%}
	H = double(H)./360;
%{
	inmultirea matricelor cu 100 se realizeaza pentru a reduce erorile de aproximare atunci cand calculez
	intervalele pentru calcularea histogramelor
%}
	H = H*100;
	S = S*100;	
	V = V*100;
	
%{
	aplic algoritmul utilizat in functia rgbHistogram modificand doar limitele intervalelor
%}
	for i = 1:count_bins
		index_H = ( H(:,:) >= (i-1)*101/count_bins & H(:,:) < (i-1)*101/count_bins + 101/count_bins );
		index_H_true = index_H(index_H(:,:) == 1);
		histogram_H(i) = sum(index_H_true);
	endfor
	
	for i = 1:count_bins
		index_S = ( S(:,:) >= (i-1)*101/count_bins & S(:,:) < (i-1)*101/count_bins + 101/count_bins );
		index_S_true = index_S(index_S(:,:) == 1);
		histogram_S(i) = sum(index_S_true);
	endfor
	
	for i = 1:count_bins
		index_V = ( V(:,:) >= (i-1)*101/count_bins & V(:,:) < (i-1)*101/count_bins + 101/count_bins );
		index_V_true = index_V(index_V(:,:) == 1);
		histogram_V(i) = sum(index_V_true);
	endfor
	histogram_hsv = [ histogram_H histogram_S histogram_V ];
endfunction
