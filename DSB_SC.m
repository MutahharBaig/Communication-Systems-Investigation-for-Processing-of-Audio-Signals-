% read file
FILE = 'eric.wav';
fc = 100000;
fs_res = 5*fc;
modulation_index = 0.5;
[yt, fs]= audioread(FILE);
max_amp = max(abs(yt));
f_filter = 4000;
% message in frequency domain
yf = fftshift(fft(yt));
% filter
filter = generate_filter(length(yf),fs,f_filter);
yf_filtered = filter.*yf;
% back to time domain
yt_filtered= real(ifft(ifftshift(yf_filtered)));
% resample
yt_resampled = resample(yt_filtered,fs_res,fs);
% carrier signal
t_carr = linspace(0,length(yt_resampled)/fs_res, length(yt_resampled));
%(x2-x1)/(n-1) = 1/5*fc, linspace(x1,x2,n)
carrier_t = cos(2*pi*fc*t_carr).';
carrier_f = fftshift(fft(carrier_t));
% DSB-SC modulation
yt_sc = carrier_t.*yt_resampled;
yf_sc = fftshift(fft(yt_sc));
% channel
signpower = pow2db(mean(abs(yt_sc).^2));
snr = 30;
zt_sc = awgn(yt_sc, snr, signpower);
% DSB-SC envelope detector demodulation
[zt_sc_env, zf_sc_env] = env_demod(zt_sc,fs_res,fs,0,0);