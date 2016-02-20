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

fig_width = 2;
fig_height = 4;
fig_i = 1;

subplot(fig_height, fig_width, fig_i);
fig_i = fig_i + 1;
stem(n, input_signal, 'Marker', 'none');
axis([0, N, -inf, inf])
title('Input f(t)');

subplot(fig_height, fig_width, fig_i);
fig_i = fig_i + 1;
stem(n, output_signal, 'Marker', 'none');
axis([0, N, -inf, inf])
title('Output g(t)');

% Get Fourier transform of input
f_in = fft(ifftshift(input_signal));

subplot(fig_height, fig_width, fig_i);
fig_i = fig_i + 1;
stem(x0, real(fftshift(f_in)), 'Marker', 'none');
axis([x0(1), x0(end), -inf, inf])
title('Input F(h) real');

% Get Fourier transform of output
f_out = fft(ifftshift(output_signal));

subplot(fig_height, fig_width, fig_i);
fig_i = fig_i + 1;
stem(x0, real(fftshift(f_out)), 'Marker', 'none');
axis([x0(1), x0(end), -inf, inf])
title('Output G(h) real');

% Divide G(h) by F(h) to get F(h) (or H)
f_h = zeros(1, N);
for i = 1:N
    f_h(i) = 0 + 0i;
    if f_in(i) ~= 0
        f_h(i) = f_out(i) / f_in(i);
    end
end

% Plot magnitude of F(h)
mag_f_h = abs(fftshift(f_h));
subplot(fig_height, fig_width, fig_i);
fig_i = fig_i + 1;
stem(x0, mag_f_h, 'Marker', 'none');
axis([x0(1), x0(end), -inf, inf])
title('H(u) Magnitude');

% Get inverse Fourier transform of H
h = ifftshift(ifft(f_h));
subplot(fig_height, fig_width, fig_i);
fig_i = fig_i + 1;
stem(n, h, 'Marker', 'none');
axis([n(1), n(end), -inf, inf])
title('h(t)');

% Convolve input and h to see if it matches output
g = conv(input_signal, h, 'same');
subplot(fig_height, fig_width, fig_i);
fig_i = fig_i + 1;
stem(n, g, 'Marker', 'none');
axis([n(1), n(end), -inf, inf])
title('g(t) estimated');

end

