function x = SST(R,b)
	[nr_rows nr_cols] = size(b);
	for i = nr_rows :-1: 1
		s = 0;
		for j = i + 1 : nr_rows
			s = s + R(i,j) * x(j);
		endfor
		x(i) = (b(i) - s)/R(i,i);
	endfor
	x = x';
endfunction
