function dYdt = rocket_dynamics(t, Y)
    % ROCKET_DYNAMICS - Roketin anlık fiziksel türevlerini hesaplar.
    
    % Durum değişkenlerini vektörden çıkaralım
    y  = Y(2); % İrtifa
    vx = Y(3); % Yatay hız
    vy = Y(4); % Dikey hız
    m  = Y(5); % Anlık kütle

    % --- SABİTLER VE ÇEVRESEL MODELLER ---
    g = 9.81;            % Yerçekimi ivmesi (m/s^2)
    Cd = 0.45;           % Roketin aerodinamik sürüklenme katsayısı
    A = pi * (0.15^2);   % Roket kesit alanı (Yarıçapı 15 cm olan silindir)
    
    % İrtifaya bağlı Hava Yoğunluğu (Üstel Atmosfer Modeli)
    rho0 = 1.225;        % Deniz seviyesindeki hava yoğunluğu (kg/m^3)
    H = 8500;            % Ölçek yüksekliği (m)
    rho = rho0 * exp(-y / H); % İrtifa arttıkça hava seyrekleşir
    
    % --- MOTOR VE İTKİ PARAMETRELERİ ---
    t_burn = 25;         % Motorun toplam yanma süresi (saniye)
    Thrust_max = 12000;  % Motorun ürettiği itme kuvveti (Newton)
    m_empty = 150;       % Roketin boş kütlesi (kg)
    m_fuel_dot = 12;     % Saniyede tüketilen yakıt miktarı (kg/s)
    
    % --- İTKİ VE KÜTLE DEĞİŞİM KONTROLÜ ---
    % Eğer motor hala yanıyorsa ve içeride yakıt varsa
    if t <= t_burn && m > m_empty
        T = Thrust_max;       % İtki aktif
        mdot = -m_fuel_dot;   % Kütle azalıyor
        
        % Gravity Turn (Yerçekimi Dönüşü) Taklidi:
        % İlk 3 saniye dik yükselir, sonra rokete hafif bir eğim verilir.
        if t < 3
            theta = deg2rad(90); % Dik açı
        else
            theta = deg2rad(90 - 2.5 * (t - 3)); % Zamanla yataya doğru eğilir
        end
    else
        T = 0;    % Motor sustu (Coast fazı)
        mdot = 0; % Kütle sabit kaldı
        theta = 0;
    end
    
    % --- AERODİNAMİK SÜRÜKLENME (HAVA DİRENCİ) ---
    v = sqrt(vx^2 + vy^2); % Toplam hız
    
    if v > 1e-3
        D = 0.5 * rho * (v^2) * Cd * A; % Toplam Sürtünme Kuvveti
        Dx = D * (vx / v);              % Yatay sürtünme bileşeni
        Dy = D * (vy / v);              % Dikey sürtünme bileşeni
    else
        Dx = 0;
        Dy = 0;
    end
    
    % --- HAREKET DENKLEMLERİ (F = m*a  ->  a = F/m) ---
    ax = (T * cos(theta) - Dx) / m;                % Yatay İvme
    ay = (T * sin(theta) - Dy - (m * g)) / m;      % Dikey İvme
    
    % Türevleri içeren sütun vektörünü döndür [dx; dy; dvx; dvy; dm]
    dYdt = [vx; vy; ax; ay; mdot];
end