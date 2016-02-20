function [ output_args ] = FourierPlotPower( signal, t_min, t_max )
%FOURIERPLOTPOWER Summary of this function goes here
%   Detailed explanation goes here


N = length(signal);

diff = t_max - t_min;

x = t_min:diff/N:t_max-(diff/N);
x0 = x - ((t_max + t_min) / 2);

f_signal = fftshift(fft(ifftshift(signal)));
%f_signal = [fs(N/2:N-1), fs(1:N/2)];

figure

subplot(3, 2, 1:2)
plot(x, signal, 'Marker', 'none')
axis([t_min, t_max, -inf, inf])
title('Signal')

real_plot = subplot(3, 2, 3);
stem(x0, real(f_signal), 'Marker', 'none')
axis([x0(1), x0(end), -inf, inf])
title('Real')

imag_plot = subplot(3, 2, 4);
stem(x0, imag(f_signal), 'Marker', 'none')
axis([x0(1), x0(end), -inf, inf])
title('Imaginary')

linkaxes([real_plot, imag_plot], 'xy')

magnitude = abs(f_signal);

subplot(3, 2, 5)
stem(x0, magnitude, 'Marker', 'none')
axis([x0(1), x0(end), -inf, inf])
title('Magnitude')

Pxx = f_signal.*conj(f_signal) / N;
Pxx = Pxx(N/2:N);
px0 = 0:N/2;

subplot(3, 2, 6)
stem(px0, 10*log10(Pxx), 'Marker', 'none');
axis([px0(1), px0(end), -inf, inf])
title('Power Spectral Density')

end

