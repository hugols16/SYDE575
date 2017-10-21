function g = custom_filter(f, min_amp, radius)
    g = f;
    indices = zeros(0,0);
    index = 1;

    for i=1:size(f,1)
        for j=1:size(f,2)
            if abs(f(i,j)) >= min_amp
                indices(index, 1) = i;
                indices(index, 2) = j;
                index = index + 1;
            end
        end
    end
                
    for k=1:size(indices,1)
        x = indices(k,1);
        y = indices(k,2);
        x_center = indices(k,1) - size(f,1)/2;
        y_center = indices(k,2) - size(f,2)/2;
        r = x_center*x_center + y_center*y_center;
        if r > radius;
            g(x,y) = mean([f(x-1,y), f(x+1,y), f(x,y-1), f(x,y+1)]);
        end
    end
    