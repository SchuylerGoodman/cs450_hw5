function [ transfer_function ] = FindTransferFunction( input_signal, output_signal )
%FINDTRANSFERFUNCTION Summary of this function goes here
%   Detailed explanation goes here

N = length(input_signal);
if (N ~= length(output_signal))
    error('input and output signals must be same length.');
end

n = 0:N-1;
x0 = n - (N/2);

figure

subplot(2, 2, 1);
stem(x0, input_signal, 'Marker', 'none');
axis([x0(1), x0(end), -inf, inf])
title('Input f(t)');

subplot(2, 2, 2);
stem(x0, output_signal, 'Marker', 'none');
axis([x0(1), x0(end), -inf, inf])
title('Output g(t)');

% Get Fourier transform of input
f_in = fft(input_signal);

% Get Fourier transform of output
f_out = fft(output_signal);

% Divide F(output) by F(input) to get F(h) (or H)
f_h = rdivide(f_out, f_in);

% Plot magnitude of F(h)
mag_f_h = abs(f_h);
subplot(2, 2, 3);
stem(x0, mag_f_h, 'Marker', 'none');
axis([x0(1), x0(end), -inf, inf])
title('H(u) Magnitude');

% Get inverse Fourier transform of H
h = ifft(f_h);
subplot(2, 2, 4);
stem(x0, h, 'Marker', 'none');
axis([x0(1), x0(end), -inf, inf])
title('h(t)');

end

