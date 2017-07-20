promptMessage = sprintf('Would you like to record your own audio for further processing?');
titleBarCaption = 'Record Sound';
button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No','Yes');
if strcmpi(button, 'Yes')
    %Program code of recording audio
    z=audiorecorder;
    myicon = imread('microphone.png');
    h=msgbox('Speak Up, I am Recording...','Recording','custom',myicon);
    recordblocking(z,15); %Records a 15 sec audio
    delete(h);
    myRecording = getaudiodata(z);

    %Block to play audio and corresponding graph
    promptMessage=sprintf('Do want to play your recorded file?');
    titleBarCaption='Play';
    button = questdlg(promptMessage,titleBarCaption,'Yes', 'No','Yes');
    if strcmpi(button,'Yes')
    play(z);
    else
    end
    fourierTransform(9000,myRecording,'The Recorded Wave File','The Recorded Wave FFT');
    recoverSignal(myRecording,9000,0.05);   %specifying the noise factor randmly between the required range so that there is no problem in recovering
    
else
    
    load handel.mat
    filename = 'handel.wav';
    audiowrite(filename,y,Fs);
    clear y Fs
    [y,Fs] = audioread('handel.wav');
    
    promptMessage = sprintf('Which version of pre specified sound file do you want to hear?');
    titleBarCaption = 'Specify Sound';
    button = questdlg(promptMessage, titleBarCaption, 'Perfect', 'Noisy','Cancel','Perfect');
    if strcmpi(button, 'Perfect')
        % Play the perfect sound.
        signal=y;
        soundsc(y,Fs);
        fourierTransform(Fs,y,'The Perfect Wave File','The Perfect Wave FFT');
        
    else if strcmpi(button, 'Noisy')
            % Add noise to it.
            prompt= 'Enter noise factor to be added to sound (0.01<n<0.15): ';
            answer = inputdlg(prompt);
            noiseFactor = str2double(answer{1});
            noisySound = y + noiseFactor*randn(length(y), 1);
            % Play the noisy sound.
            signal=noisySound;
            soundsc(noisySound, Fs);
            fourierTransform(Fs,noisySound,'The Noisy Wave File','The Noisy Wave FFT');
            clear sound;
            recoverSignal(noisySound,Fs,noiseFactor);
        else
            % Cancel Dialog Box
            %add a command to stop the execution of program below if pressed cancel
        end
        
    end
    
end





