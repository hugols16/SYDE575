function f = lee_filter(g, flat_region)

    noise_var = mean(var(flat_region));
    
    localmean = colfilt(g, [5,5], 'sliding', @mean);
    localvar = colfilt(g, [5,5], 'sliding', @var);

    K = (localvar - noise_var) ./ localvar;

    f = K .* g + (1 - K) .* localmean;
end

