function recoverSignal(noisySound,Fs,noiseFactor)
%Ask for Recovery of signal
promptMessage = sprintf('Do you want to Recover Noisy Sound?');
titleBarCaption = 'Recover Sound';
button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No','Yes');
if (strcmpi(button, 'Yes'))
    if(noiseFactor<0.15 && noiseFactor>0.01)
% Threshold selection for de-noising
%THR = thselect(signal,'rigrsure');
%Wavelet transform for de-noising
recoveredSound = wden(noisySound,'heursure','s','sln',5,'sym4');

%here i/p arg2 is TPTR string which contains the threshold selection rule
%     i/p arg3 is SORH ('s' or 'h') is for soft or hard thresholding 
%     i/p arg4 is SCAL which defines multiplicative threshold rescaling 
%     i/p arg5 is N which the level of transformation
%     i/p arg6 is 'wname',a string containing the name of the desired orthogonal wavelet

    soundsc(recoveredSound,Fs);
    fourierTransform(Fs,recoveredSound,'The Recovered Wave File','The Recovered Wave FFT');
    
    promptMessage = sprintf('Do you want to Amplify recovered signal?');
    titleBarCaption = 'Amplify Sound';
    button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No','Yes');
    if (strcmpi(button, 'Yes'))
        promptMessage = sprintf('How do you want to Amplify recovered signal?');
        titleBarCaption = 'Amplify Sound';
        button = questdlg(promptMessage, titleBarCaption, 'For Normal Person', 'For Hearing Impaired','For Normal Person');
         if (strcmpi(button, 'For Normal Person'))
             code=1;
         else code=2;
         end
        amplifySignal(code,recoveredSound,Fs);
    end
        
    else
    promptMessage = sprintf('Sorry, Signal cannot be recovered due to excessive distortion by noise');
    titleBarCaption = 'Sorry!';
    errordlg(promptMessage, titleBarCaption);
    end
end          
end