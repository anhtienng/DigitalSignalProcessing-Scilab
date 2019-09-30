clc
clf
// --------- PLOT SIGNAL --------
function plot_signal(x, n, pos, name) 
    subplot(2,4, pos)
    indice = linspace(0, length(x) - 1, length(x))
    indice = indice - n + 1;
    plot2d3(indice, x)
    
    config = gca()
    config.x_location = "origin";
    config.data_bounds = [ -10 -10; 10 10];
    config.title.text = name;
    config.x_label.text = "time"
    config.y_label.text = "Signal"
    scatter(indice, x, "fill");
    xstring(indice, x, string(x));
endfunction


// --------- DELAY SIGNAL --------
function delay(x, n, k)
    n = n - k
    
    if x == x1 then
        signal = "x1"
    else
        signal = "x2"
    end
    plot_signal(x, n, 3, signal + " delay by " + string(k) + " units")
endfunction


// --------- ADVANCE SIGNAL --------
function advance(x, n, k)
    n = n + k
    
    if x == x1 then
        signal = "x1"
    else
        signal = "x2"
    end
    plot_signal(x, n, 4, signal + " advance by " + string(k) + " units")
endfunction


// --------- FOLDING SIGNAL --------
function fold(x, n)
    temp = flipdim(x, 2) // inverse array x
    distance = n - 1    
    n = length(x) - distance
    
    if x == x1 then
        signal = "x1"
    else
        signal = "x2"
    end
    plot_signal(temp, n, 5, "Folded " + signal)
endfunction


// --------- ADDING SIGNAL --------
function add(x1, n1, x2, n2)
    indice1 = linspace(0, length(x1) - 1, length(x1))
    indice1 = indice1 - n1 + 1;
    indice2 = linspace(0, length(x2) - 1, length(x2))
    indice2 = indice2 - n2 + 1;
    
    min1 = min(indice1)
    max1 = max(indice1)
    min2 = min(indice2)
    max2 = max(indice2)
    
    if min1 > min2 then
        x1 = [zeros(1, min1 - min2) x1]
        n = n1 + min1 - min2
    else
        x2 = [zeros(1, min2 - min1) x2]
        n = n2 + min2 - min1
    end
    
    if max1 < max2 then
        x1 = [x1 zeros(1, max2 - max1)]
    else
        x2 = [x2 zeros(1, max1 - max2)]
    end
    
    x = x1 + x2 
    
    plot_signal(x, n, 6, "Addition of x1 and x2")
endfunction

// --------- MULTIPLICATION SIGNAL --------
function multiply(x1, n1, x2, n2)
    indice1 = linspace(0, length(x1) - 1, length(x1))
    indice1 = indice1 - n1 + 1;
    indice2 = linspace(0, length(x2) - 1, length(x2))
    indice2 = indice2 - n2 + 1;
    
    min1 = min(indice1)
    max1 = max(indice1)
    min2 = min(indice2)
    max2 = max(indice2)
    
    if min1 > min2 then
        x1 = [zeros(1, min1 - min2) x1]
        n = n1 + min1 - min2
    else
        x2 = [zeros(1, min2 - min1) x2]
        n = n2 + min2 - min1
    end
    
    if max1 < max2 then
        x1 = [x1 zeros(1, max2 - max1)]
    else
        x2 = [x2 zeros(1, max1 - max2)]
    end
    
    x = x1 .* x2 
    
    plot_signal(x, n, 7, "Multiplication of x1 and x2")
endfunction

// --------- EXAMPLE --------
x1 = [1 4 -2 4 2 -2];
n1 = 3

x2 = [2 5 2 1];
n2 = 2

plot_signal(x1, n1, 1, "Original x1")
plot_signal(x2, n2, 2, "Original x2")
delay(x2, n2, 2)
advance(x2, n2, 4)
fold(x1, n1)
add(x1,n1,x2,n2)
multiply(x1,n1,x2,n2)
