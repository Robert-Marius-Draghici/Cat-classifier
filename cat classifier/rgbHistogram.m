function [histogram_rgb] = rgbHistogram(path,count_bins)
	Image = imread(path);
	red_channel = Image(:,:,1);
	green_channel = Image(:,:,2);
	blue_channel = Image(:,:,3);

	for i = 1:count_bins
		%{
			determinam pozitiile pe care se afla pixelii inclusi in intervalul
			[(i-1)*256/count_bins,(i-1)*256/count_bins + 256/count_bins)
		%}
		index_red = ( red_channel(:,:) >= (i-1)*256/count_bins & red_channel(:,:) < (i-1)*256/count_bins + 256/count_bins );
		%{
			creez un vector coloana in care pun toate valorile nenule din matricea 
		 	index_red pentru a putea calcula numarul de pixeli
		%}
		index_red_true = index_red(index_red(:,:) == 1);
		%	suma reprezinta numarul de pixeli din intervalul considerat
		histogram_red(i) = sum(index_red_true);
	endfor
	
	%	aplic acelasi algoritm utilizat pentru R si pentru G si B
	for i = 1:count_bins
		index_green = ( green_channel(:,:) >= (i-1)*256/count_bins & green_channel(:,:) < (i-1)*256/count_bins + 256/count_bins );
		index_green_true = index_green(index_green(:,:) == 1);
		histogram_green(i) = sum(index_green_true);
	endfor
	
	for i = 1:count_bins
		index_blue = ( blue_channel(:,:) >= (i-1)*256/count_bins & blue_channel(:,:) < (i-1)*256/count_bins + 256/count_bins );
		index_blue_true = index_blue(index_blue(:,:) == 1);
		histogram_blue(i) = sum(index_blue_true);
	endfor
	
	%	concatenez cei 3 vectori
	histogram_rgb = [histogram_red histogram_green histogram_blue];

endfunction
