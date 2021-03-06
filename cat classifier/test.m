function test	
	path_to_dataset  = 'dataset/';
	path_to_testset  = 'testset/';
	no_of_tests = 2;

	% ---------TEST 1 - RGB----------------
	printf('SETUP - using RGB\n');
	hist_type = 'RGB';
	count_bins = 20;

	tic; % start timer
	[X t] = preprocess(path_to_dataset, hist_type, count_bins);
	w = learn(X, t);
	p = evaluate(path_to_testset, w, hist_type,  count_bins);
    time = toc;

    printf('Elapsed time is %f seconds.\n', time);
    printf('Accuracy: %f\n', p);	
	printf('\n');


	% ---------TEST 2 - HSV ---------------
	printf('SETUP - using HSV\n');
	hist_type = 'HSV';
	count_bins = 20;

	tic; % start timer
	[X t] = preprocess(path_to_dataset, hist_type, count_bins);
	w = learn(X, t);
	p = evaluate(path_to_testset, w, hist_type,  count_bins);
    time = toc;

    printf('Elapsed time is %f seconds.\n', time);
    printf('Accuracy: %f\n', p);	
	printf('\n');
end
