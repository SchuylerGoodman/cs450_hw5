function [ f_signal ] = FourierPlot( signal, t_min, t_max )
%FOURIERPLOT Plot Fourier Transform of signal from t_min to t_max.

N = length(signal)

x = t_min:t_max;
x0 = x - ((t_max + t_min) / 2);

fs = fft(signal);
f_signal = [fs(N/2:N-1), fs(1:N/2)];

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
phase = atan2(imag(f_signal), real(f_signal));

subplot(3, 2, 5)
stem(x0, magnitude, 'Marker', 'none')
axis([x0(1), x0(end), -inf, inf])
title('Magnitude')

subplot(3, 2, 6)
stem(x0, phase, 'Marker', 'none')
axis([x0(1), x0(end), -inf, inf])
title('Phase')
