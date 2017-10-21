function g = gaussian_lp_filter(f, std_dev)
    % Create the filter
    filter = fspecial('gaussian', size(f, 1), std_dev);
    filter = filter./max(max(filter));
    g = f.*filter;