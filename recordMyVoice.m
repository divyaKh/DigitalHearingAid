function z = recordMyVoice(Fs,nBits,nChannels)
z=audiorecorder(Fs,nBits,nChannels);
    myicon = imread('microphone.png');
    h=msgbox('Speak Up, I am Recording...','Recording','custom',myicon);
    recordblocking(z,2); %Records a 2 sec audio
    delete(h);
    
end