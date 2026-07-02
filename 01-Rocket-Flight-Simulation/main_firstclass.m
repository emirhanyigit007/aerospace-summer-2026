% MAIN.M - Roket Fırlatma Simülasyonu Ana Dosyası
clear; clc; close all;

% 1. Simülasyon Zaman Aralığı (0'dan 150. saniyeye kadar)
tspan = [0 150];

% 2. Başlangıç Koşulları Vektörü [x; y; vx; vy; m]
% x = 0 m (Yatay konum)
% y = 0 m (Dikey konum / İrtifa)
% vx = 0 m/s (Yatay hız)
% vy = 0.1 m/s (Dikey hız - sıfıra bölme hatasını engellemek için küçük bir değer)
% m = 500 kg (Toplam kalkış kütlesi: 150 kg gövde + 350 kg yakıt)
Y0 = [0; 0; 0; 0.1; 500];

% 3. Diferansiyel Denklem Çözücü (ode45) ile Simülasyonu Koşturma
% rocket_dynamics fonksiyonunu her zaman adımı için çağırır
[t, Y] = ode45(@rocket_dynamics, tspan, Y0);

% 4. Sonuçları Ayrıştırma
x  = Y(:, 1); % Yatay menzil
y  = Y(:, 2); % İrtifa
vx = Y(:, 3); % Yatay hız
vy = Y(:, 4); % Dikey hız
m  = Y(:, 5); % Anlık kütle

% Toplam Hız Büyüklüğü Hesaplama (Bileşke Hız)
v = sqrt(vx.^2 + vy.^2);

% 5. Sadece Roket Havada Olduğu Sürece Verileri Filtrele (Yere düşüşten sonrası)
havada_mi = y >= 0;
t = t(havada_mi);
x = x(havada_mi);
y = y(havada_mi);
v = v(havada_mi);
m = m(havada_mi);

% 6. VERİ GÖRSELLEŞTİRME (GRAFİKLER)
figure('Name', '6-DOF Mini Roket Simülasyon Sonuçları', 'NumberTitle', 'off');

% Grafik 1: Roketin İzlediği Yörünge
subplot(2,2,1);
plot(x/1000, y/1000, 'b-', 'LineWidth', 2);
grid on;
xlabel('Yatay Menzil (km)');
ylabel('İrtifa (km)');
title('Uçuş Yörüngesi (Trajectory)');

% Grafik 2: Zamana Bağlı İrtifa
subplot(2,2,2);
plot(t, y/1000, 'r-', 'LineWidth', 2);
grid on;
xlabel('Zaman (s)');
ylabel('İrtifa (km)');
title('Zamana Bağlı İrtifa');

% Grafik 3: Zamana Bağlı Hız
subplot(2,2,3);
plot(t, v, 'g-', 'LineWidth', 2);
grid on;
xlabel('Zaman (s)');
ylabel('Hız (m/s)');
title('Zamana Bağlı Toplam Hız');

% Grafik 4: Zamana Bağlı Kütle Azalımı (Yakıt Tüketimi)
subplot(2,2,4);
plot(t, m, 'm-', 'LineWidth', 2);
grid on;
xlabel('Zaman (s)');
ylabel('Toplam Kütle (kg)');
title('Zamana Bağlı Roket Kütlesi');