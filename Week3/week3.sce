clc
clf

// --------- PLOT SIGNAL --------
function plot_signal(x, n, pos, name, dotColor) 
    subplot(3,2, pos)
    indice = linspace(0, length(x) - 1, length(x))
    indice = indice - n + 1;
    plot2d3(indice, x)
    
    config = gca()
    config.x_location = "origin";
    config.data_bounds = [ -5 -5; 5 10];
    config.title.text = name;
    config.x_label.text = "time"
    config.y_label.text = "Signal"
    config.y_label.font_size = 3
    config.x_label.font_size = 3
    config.title.font_size = 3
    scatter(indice, x, dotColor, "fill");
    xstring(indice, x, string(x));
endfunction

// ---------- EXTRACT EVEN COMPONENT -----------
function get_even_component (x, n)
    fold_x = flipdim(x, 2) // inverse array x   
    fold_n = length(x) - n + 1 
    
    indice1 = linspace(0, length(x) - 1, length(x))
    indice1 = indice1 - n + 1;
    indice2 = linspace(0, length(fold_x) - 1, length(fold_x))
    indice2 = indice2 - fold_n + 1;
    
    min1 = min(indice1)
    max1 = max(indice1)
    min2 = min(indice2)
    max2 = max(indice2)
    
    if min1 > min2 then
        x = [zeros(1, min1 - min2) x]
        n = n + min1 - min2
    else
        fold_x = [zeros(1, min2 - min1) fold_x]
        n = fold_n + min2 - min1
    end
    
    if max1 < max2 then
        x = [x zeros(1, max2 - max1)]
    else
        fold_x = [fold_x zeros(1, max1 - max2)]
    end
    
    result = x + fold_x
    result = result .* 1/2
    
    plot_signal(result, n, 2, "Even component of x(n)", "red")
endfunction



// ---------- EXTRACT ODD COMPONENT -----------
function get_odd_component (x, n)
    fold_x = flipdim(x, 2) // inverse array x   
    fold_n = length(x) - n + 1 
    
    indice1 = linspace(0, length(x) - 1, length(x))
    indice1 = indice1 - n + 1;
    indice2 = linspace(0, length(fold_x) - 1, length(fold_x))
    indice2 = indice2 - fold_n + 1;
    
    min1 = min(indice1)
    max1 = max(indice1)
    min2 = min(indice2)
    max2 = max(indice2)
    
    if min1 > min2 then
        x = [zeros(1, min1 - min2) x]
        n = n + min1 - min2
    else
        fold_x = [zeros(1, min2 - min1) fold_x]
        n = fold_n + min2 - min1
    end
    
    if max1 < max2 then
        x = [x zeros(1, max2 - max1)]
    else
        fold_x = [fold_x zeros(1, max1 - max2)]
    end
    
    result = x - fold_x
    result = result .* 1/2
    
    plot_signal(result, n, 3, "Odd component of h(n)", "orange")
endfunction


// ------------ CONVOLUTION ------------
function convolution(x, n1, h, n2)
    y = convol(h, x)
    n = n1 + n2 - 1
    plot_signal(x, n1, 6, "Convolution", "blue") 
    plot_signal(h, n2, 5, "h(n)", "green") 
    plot_signal(h, n2, 6, "Convolution", "green") 
    plot_signal(y, n, 6, "Convolution of x(n) and y(n)", "red") 
endfunction

x = [1 2 1 -1]
n1 = 2
h = [1 2 3 1]
n2 = 1

plot_signal(x, 2, 1, "x(n)", "blue")
get_even_component(x, n1)
get_odd_component(x, n1)
convolution(x, n1, h, n2)


















