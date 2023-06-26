function dstImg = homofilter(I)
    I = double(I);
    [m, n] = size(I);
    rL = 0.5;
    rH = 2;
    c = 2;
    d0 = 20;
    I1 = log(I + 1);
    FI = fft2(I1);
    n1 = floor(m / 2);
    n2 = floor(n / 2);
    D = zeros(m, n);
    H = zeros(m, n);
    for i = 1:m
        for j = 1:n
            D(i, j) = ((i - n1) ^ 2 + (j - n2) ^ 2);
            H(i, j) = (rH - rL) * (exp(c * (-D(i, j) / (d0 ^ 2)))) + rL;
        end
    end
    I2 = ifft2(H .* FI);
    I3 = real(exp(I2) - 1);
    I4 = I3 - min(I3(:));
    I4 = I4 / max(max(I4)) * 255;
    dstImg = uint8(I4);