% read file
FILE = 'eric.wav';
fc = 100000;
[yt, fs]= audioread(FILE);
fs_res = 5*fc;
f_filter = 4000;
% message in frequency domain
yf = fftshift(fft(yt));
xf = linspace(-fs/2,fs/2,length(yf));
% filter
filter = generate_filter(length(yf),fs,f_filter);
yf_filtered = filter.*yf;
% back to time domain
yt_filtered= real(ifft(ifftshift(yf_filtered)));
% plotting
xt = linspace(0,length(yt_filtered)/fs, length(yt_filtered));
% resample
yt_resampled = resample(yt_filtered,fs_res,fs);
% carrier signal
t = linspace(0,length(yt_resampled)/fs_res, length(yt_resampled));
%(x2-x1)/(n-1) = 1/5*fc, linspace(x1,x2,n)
carrier = cos(2*pi*fc*t).';
carriersin = sin(2*pi*fc*t).';
yt_carrier=carrier;
yf_carrier=fftshift(fft(yt_carrier));
xt_carrier=t;
xf_carrier=linspace(-fc/2,fc/2,length(yt_carrier));
% FM Modulation - NBFM
% ————— Part A: FM modulation start ——————



% ————— Part A: FM modulation end———————
% Demodulation
% ————— Part B: FM demodulation start ——————



% ————— Part B: FM demodulation end———————