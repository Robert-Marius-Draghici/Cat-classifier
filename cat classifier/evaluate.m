function percentage = evaluate(path,w,histogram_type,count_bins)
%{
	implementarea este asemanatoare cu cea din functia preprocess, modificarile constand
	in instructiunile din if care calculeaza y ce ne ajuta sa prezicem daca o poza
	este cu pisici sau nu
%}
	newpath_cats = strcat(path,"cats/");
	Images_cats = getImgNames(newpath_cats);
	[nr_rows1 nr_cols1] = size(Images_cats);
	
	newpath_not_cats = strcat(path,"not_cats/");
	Images_not_cats = getImgNames(newpath_not_cats);
	[nr_rows2 nr_cols2] = size(Images_not_cats);
	
	nr_rows = nr_rows1 + nr_rows2;
	Images = [Images_cats ; Images_not_cats];
	pictures_identified_cats = 0;
	pictures_identified_not_cats = 0;
	for i = 1:nr_rows
		if( strcmp(histogram_type,"RGB") == 1 && i <= nr_rows1 )
			path_histogram = strcat(newpath_cats,Images(i,:));
			X = rgbHistogram(path_histogram,count_bins);
			X(:,3*count_bins + 1) = 1;
			y = w' * X';
			if(y >= 0) 
				pictures_identified_cats = double(pictures_identified_cats) + 1;
			endif
		elseif( strcmp(histogram_type,"HSV") == 1 && i <= nr_rows1 )
			path_histogram = strcat(newpath_cats,Images(i,:));
			X = hsvHistogram(path_histogram,count_bins);
			X(:,3*count_bins + 1) = 1;
			y = w' * X';
			if(y >= 0)
				pictures_identified_cats = double(pictures_identified_cats) + 1;
			endif
		endif		
		if( strcmp(histogram_type,"RGB") == 1 && i > nr_rows1 )
			path_histogram = strcat(newpath_not_cats,Images(i,:));
			X = rgbHistogram(path_histogram,count_bins);
			X(:,3*count_bins + 1) = 1;
			y = w' * X';
			if(y < 0) 
				pictures_identified_not_cats = double(pictures_identified_not_cats) + 1;
			endif
		elseif( strcmp(histogram_type,"HSV") == 1 && i > nr_rows1 )
			path_histogram = strcat(newpath_not_cats,Images(i,:));
			X = hsvHistogram(path_histogram,count_bins);
			X(:,3*count_bins + 1) = 1;
			y = w' * X';
			if(y < 0)
				pictures_identified_not_cats = double(pictures_identified_not_cats) + 1;
			endif
		endif						
	endfor
	
	pictures_identified = pictures_identified_cats + pictures_identified_not_cats;
	percentage = double(pictures_identified)/nr_rows * 100;
endfunction
