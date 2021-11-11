function samp_rec(fs);

    % Signal Construction
    N = 100;
    t = 1 : N;
    sig = 2*sin(2*pi*400*t/8000);
    figure
    plot(sig);
    TITLE ('The Signal in Time Domain');
    grid on;

    p_max = 2;
    p_min = -2;

    % Sampling the Signal
    b = 8000/fs;		% sampling interval
    samp = zeros(1,N);		% constructing a zero array
    for (p = 1 : b : N)
        samp(p) = sig(p);
    end
    figure
    stem(samp);
    TITLE ('The Sampled Signal')
    grid on;

    % Quantizing the Sampled Signal
    no = N/b;			% no. of samples
    z = ceil(5*(no));		% no. of bits required
    quan = zeros(1,z);		% constructing a zero array
    c = (abs(p_max) + abs(p_min))/32  	 % size of quantized level
    u = p_min;
    w = 1;
    quant = zeros(1,N);
    for (q = 1 : b : N)
        for (r = 1 : 32)
            y = r;
            if (samp(q)>=u & samp(q)<=(u+c))
                for (v = (w+4) : -1 : w) % this loop is for converting decimal into binary
                    quan(v) = mod(y,2);
                    y = (y/2)- (mod(y,2)/2);
                end
                 quant(q) = r;
            end
            u = u + c;
        end
        u = p_min;
        w = w + 5;
    end
    quan
    
    % Writing the Quantized Signal
    fid = fopen ('quant.bin','w');
    count = fwrite (fid,quant,'int8');

    % Reading the Quantized Signal
    fid = fopen ('quant.bin','r');
    [quant_r,count] = fread (fid,inf,'int8');

    % Reconstructing the Sample of the Quantized Signal
    for (n = 1 : N)
        u = p_min;
        for (ab = 1 : 32)
            if (quant_r(n)==ab)
                quant_r(n) = u;
            end
            u = u + c;
        end
    end
    figure
    stem (quant_r);
    TITLE ('The Reconstructed Sample of Quantized Signal')
    grid on;

    % Reconstructing the Original Signal
    for (c1 = 1 : b : (N-b))
        if (b~=1)
            xyz = (quant_r(c1+b)-quant_r(c1))/b;
            for (c2 = (c1+1) : (c1+b-1))
                quant_r(c2) = quant_r(c2-1) + xyz;
            end
        end
    end
    figure
    quant_r = smooth (quant_r);
    plot (quant_r);
    TITLE ('The Reconstructed Signal')
    grid on;
end