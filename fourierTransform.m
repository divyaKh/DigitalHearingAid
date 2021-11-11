function fourierTransform(Fs,signal,title1,title2)
%Pop up
promptMessage = sprintf('Would you like to see the signal and its frequency response?');
titleBarCaption = 'View Graphs';
button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No','Yes');
if strcmpi(button, 'Yes')
  %Plot signal
  figure;
  t=0:1/Fs:(length(signal)-1)/Fs; % and get sampling frequency */
  subplot(2,1,1);
          plot(t,signal);
          title(title1);
          ylabel('Amplitude');
          xlabel('Length (in seconds)');
   
  n=length(signal)-1; 
  f=0:Fs/n:Fs;
  wavefft=abs(fft(signal)); % perform Fourier Transform 
  subplot(2,1,2);
          plot(f,wavefft); % plot Fourier Transform */
          xlabel('Frequency in Hz');
          ylabel('Magnitude');
          title(title2);

else
    clear sound;
end    
end