%% Oppgave 1
t = -1:.05:2.5
figure(1)
subplot(221)
plot(t, 2*cos(2*pi*t*2))
title('cos(2pi*t)')
subplot(222)
%plot(t, cos(2*pi*t + pi))
title('cos(2pi*t + pi)')
subplot(223)
%plot(t, cos(8*pi*t))
title('cos(8pi*t)')
%subplot(224)
plot(t, cos(4*pi*t - pi/3))

%% Oppgave 2
figure(2)
t = -1.5:0.01:2.5
% Amp = 2, Periode = 0.5, Frekvens = 2, Faseskift = 0
plot(t, 2*cos(4*pi*t))
% Amp = 1, Peroide = 0.25, Frekvens = 4, Faseskifte = pi
plot(t, cos((2*pi*t)/0.25 + pi))
% Amp = 1, Peroide = 1, Frekvens = 1, Faseskift = pi/2
plot(t ,cos(2*pi*t + pi/2))
% Amp = 1, Peroide = 2, Frekvens = 0.5, Faseskift = pi/4
plot(t, cos(2*pi*t*0.5 - pi/4))


%% Oppgave 3
abs(3+4i)
1/(3+4i)

n = 0:30

figure(1)
%plot(n, cos(n/2+pi/2))
%plot(n, cos(pi*n + pi/2))
%plot(n, cos((sqrt(2)/2)*pi*n))
plot(n, cos(pi*n/5))

%% Forelesning
clear all
phi = 0:0.01:(2*pi)
x = exp(i*phi)
plot(real(x), imag(x))

A = 2
phi = 0
f = 0.1
t = 0:0.01:10
l = 50
figure(1)
for i = 1:l
    hold on
    subplot(221)
    plot(t, A*cos(2*pi*f*t+phi))
    hold on
    subplot(222)
    plot(t, A*cos(2*pi*f/2*t+phi))
    hold on
    subplot(223)
    plot(t, A*cos(2*pi*f/3*t+phi))
    hold on
    subplot(224)
    plot(t, A*cos(2*pi*f/4*t+phi))
    hold on
    phi = phi + 2*pi/l
    A=A*1.02
    t
end

%%
i = sqrt(-1)
(2+i)^2 * (2-i)^2