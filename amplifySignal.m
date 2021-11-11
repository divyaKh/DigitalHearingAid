function amplifySignal(code,soundSignal,Fs)

switch(code)
    case 1     %No hearing loss
        max_signal=max(abs(soundSignal));
        factor=1/max_signal;
        amplifiedSignal=soundSignal*factor;
        
    case 2    %Hearing Loss
            prompt= 'Enter the amount of loss in hearing in db: ';
            answer = inputdlg(prompt);
            lossFactor = str2double(answer{1});
            gainRequired=db2mag(lossFactor);
            amplifiedSignal=soundSignal*gainRequired;
end
        soundsc(amplifiedSignal,Fs);
        fourierTransform(Fs,amplifiedSignal,'The Amplified Wave File','The Amplified Wave FFT');



end

