function [out] = FrangiFilter(I,sigma, yLength)
    I = double(I);
    [X, Y] = meshgrid(-yLength:yLength, -yLength:yLength);

    % Calculate the Gaussian kernel
    G = 1 / (2 * pi * sigma^2) * exp(-(X.^2 + Y.^2) / (2 * sigma^2));

    % Calculate the x and y derivatives of the Gaussian kernel
    Gx = X / (2 * pi * sigma^4) .* exp(-(X.^2 + Y.^2) / (2 * sigma^2));
    Gy = Y / (2 * pi * sigma^4) .* exp(-(X.^2 + Y.^2) / (2 * sigma^2));

    % Calculate the x and y derivatives of the image
    Ix = conv2(I, Gx, 'same');
    Iy = conv2(I, Gy, 'same');

    % Calculate the structure tensor
    S = zeros([size(I), 2, 2]);
    S(:, :, 1, 1) = conv2(Ix .^ 2, G, 'same');
    S(:, :, 1, 2) = conv2(Ix .* Iy, G, 'same');
    S(:, :, 2, 1) = S(:, :, 1, 2);
    S(:, :, 2, 2) = conv2(Iy .^ 2, G, 'same');

    % Calculate the eigenvalues of the structure tensor
    lambda1 = 0.5 * (S(:, :, 1, 1) + S(:, :, 2, 2) + sqrt((S(:, :, 1, 1) - S(:, :, 2, 2)).^2 + 4 * S(:, :, 1, 2).^2));
    lambda2 = 0.5 * (S(:, :, 1, 1) + S(:, :, 2, 2) - sqrt((S(:, :, 1, 1) - S(:, :, 2, 2)).^2 + 4 * S(:, :, 1, 2).^2));
    out=lambda2;
%     % Print debugging information
%     fprintf('Ix:\n');
%     disp(Ix);
%     fprintf('Iy:\n');
%     disp(Iy);
%     fprintf('S:\n');
%     disp(S);
%     fprintf('lambda1:\n');
%     disp(lambda1);
%     fprintf('lambda2:\n');
%     disp(lambda2);

    % Calculate the Frangi filter response
    %out = (1 - exp(((lambda2 ./ lambda1).^2) / 2));
     out = (1 - exp(((lambda2 ./ lambda1).^2) / 2));
    out2 = normalize(1-out,'range');
   
    %figure();imshow(out);
    %out(lambda1 < 0) = 0;
%     out(lambda1 > 1) = 0;
%     out(lambda1 < 1) = 1;

   figure();imshow(out);
   figure();imshow(out2);



end
