clf;
clc;

// ------------- FUNCTION DECLARATION ----------
function y = f(x, numTerms)
    y = 0;
    for i = 1:numTerms
        if data(i,4) == 0 then
            y = y + data(i,1) * cos( data(i,2) * x + data(i,3) );
        else
            y = y + data(i,1) * sin( data(i,2) * x + data(i,3) );
            end,
    end
endfunction


// ------------- INPUT DATA ------------
numTerms = input("Number of terms: ");
data = zeros(numTerms, 4)

for i=1:numTerms
    data(i,1) = input("Amplitude = ")
    data(i,2) = input("Angular velocity = ")
    data(i,3) = input("Initial State = ")
    data(i,4) = input("Type (cos = 0, sin = 1) = ")
end

// --------- CALCULATE Fs AND FUNDAMENTAL PERIOD -----------
maxW = max(data(:,2));
Fs = maxW / %pi; // sampling frequency
periodTerms = data(:,2) ./ Fs;
periodTerms = 2*%pi ./ periodTerms;
[N,D] = rat(periodTerms);
periodTerms = periodTerms ./ D;
fundamentalT = lcm(periodTerms)

// -----  PLOT ANALOG SIGNAL ------------
t = linspace(0, (fundamentalT - 1) / Fs, 1000);
analogSignal = f(t,numTerms)
subplot(2,2,1);
plot(t, analogSignal);
xlabel('t');
ylabel('x(t)');
title("Analog signal");


// -------- PLOT SAMPLING SIGNAL ------------
n = 0:1:fundamentalT - 1;
sSignal = f(n / Fs, numTerms);
subplot(2,2,2);
plot2d3(n, sSignal);
xlabel('n');
ylabel('x(n)');
title("Sampling signal");
scatter(n, sSignal, "fill");
xstring(n, sSignal, string(sSignal));
a = gca()
a.x_location = "origin" 

// ----------- ROUNDING VALUE ----------
minValue = round(min(sSignal) * 10) / 10;
maxValue = round(max(sSignal) * 10) / 10;

// ----- PLOT QUATIZING SIGNAL ----
qSignal = round(sSignal * 10) / 10;
subplot(2,2,3);
plot2d3(n, qSignal);
xlabel('n');
ylabel('qSignal(n)');
title("Quantizing signal");
scatter(n, qSignal, "fill");
xstring(n, qSignal, string(qSignal));
a = gca()
a.x_location = "origin"


// ------- BINARY SEQUENCE ------
qError = 0.1; // quatizing error
L = (maxValue - minValue) / qError + 1;
numBits = ceil(log2(L));
level = (qSignal - minValue) ./ qError;
level = round(level);
binSq = dec2bin(level, numBits);


// ------ PLOT BINARY SEQUENCE ----- 
subplot(2,2,4);
plot2d2(n,qSignal);
title("Binary sequence");
xlabel('n');
ylabel('binSq');
xstring(n, qSignal, binSq);


// ----- PRINT RESULT --------
mprintf("-------- RESULT ---------\n\n");
mprintf("Maximum signal value:       %.2f\n\n", maxValue);
mprintf("Minimum signal value:       %.2f\n\n", minValue);
mprintf("Quantizing error:           %.2f\n\n", qError);
mprintf("Number of quatizing levels: %d\n\n", L);
mprintf("Number of bits:             %d\n\n\n", numBits);

mprintf("---------------- Binary sequence -----------------\n");
mprintf("x(n)\tx(n)(quantized)\tLevel\tBinary sequence\n");
for i = 1:fundamentalT
    mprintf("%.2f\t%.1f\t\t%d\t%s\n", sSignal(i), qSignal(i), level(i), binSq(i));
end

















