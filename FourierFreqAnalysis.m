function [ M ] = FourierFreqAnalysis( signal, t_min, t_max )
%FOURIERFREQANALYSIS Summary of this function goes here
%   Detailed explanation goes here

maxCount = 3;

N = length(signal);
diff = t_max - t_min;
x = t_min:diff/N:t_max-(diff/N);
x0 = x(1:N/2);

fs = fft(signal);
f_signal = fs(1:N/2); % only half of signal, because it is mirrored.

magnitude = abs(f_signal);

M = zeros(1, maxCount);
for t = 1:maxCount
    [~, i] = max(magnitude);
    M(t) = i - 1;
    magnitude(i) = 0; 
end

end

