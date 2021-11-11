%Say either 'Yes' or 'NO'
z= recordMyVoice(8000,8,1);
play(z);

% Store data in double-precision array.
myRecording = getaudiodata(z);
t=(0:1/15999:1);
figure;
plot(t,myRecording);
title('origional signal in time domain');
xlabel('time');
ylabel('amplitude');

wsf=fft(myRecording);

%Resampling at Fs=4000Hz
less=resample(myRecording,1,2);
graph4k=fft(less);
sound(less,4000);

%Resampling at Fs=12000Hz
more=resample(myRecording,3,2);
graph12k=fft(more);

% Plot the waveform for Fs=8000Hz
figure
plot(abs(wsf));
xlabel('Frequency (Hz)');
ylabel ('Signal amplitude');
title('FFT of signal with sampling freuquency=8kHz');

% Plot the waveform for Fs=4000Hz
figure
plot(abs(graph4k));
xlabel('Frequency (Hz)');
ylabel ('Signal amplitude');
title('FFT of signal with sampling freuquency=4kHz');

% Plot the waveform for Fs=12000Hz
figure
plot(abs(graph12k));
xlabel('Frequency (Hz)');
ylabel ('Signal amplitude');
title('FFT of signal with sampling freuquency=12kHz');

%Find the highest frequency of the signal
highestidx8k = find(real(wsf(1:floor(length(myRecording)))),1,'last');
highestidx4k = find(real(graph4k(1:floor(length(less)))),1,'last');
highestidx12k = find(real(graph12k(1:floor(length(more)))),1,'last');

%minimum sampling rate
mFs8k=2*highestidx8k;
mFs4k=2*highestidx4k;
mFs12k=2*highestidx12k;

%plot psd
figure
%plot(pwelch(myRecording));
plot(psd(spectrum.periodogram,myRecording,'Fs',8000,'NFFT',length(myRecording)));
xlabel('frequency(Hz)');
ylabel ('Power/Frequency');
title('PSD');











