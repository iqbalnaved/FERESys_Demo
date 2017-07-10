% This function detects the face region using the FaceDetec() C++ function
% , which uses Viola-Jones Face Detection Algorithm. Then plots the original image with a green
% rectangle around the face region. Finally, returns the extracted face.
function I = FaceDetectCrop(A)
% type = 'pgm';
% A = imread (file, type);
Img = double (rgb2gray(A));

% Face = [xmin ymin width height] of the detected face
Face = FaceDetect('haarcascade_frontalface_alt2.xml',Img);
if length(Face) == 4
    Rectangle = [Face(1) Face(2); Face(1)+Face(3) Face(2); Face(1)+Face(3) Face(2)+Face(4); Face(1)  Face(2)+Face(4); Face(1) Face(2)];
    rect = [Rectangle(1,1) Rectangle(1,2) Rectangle(3,2)-Rectangle(2,2) Rectangle(2,1)-Rectangle(1,1)]; %xmin ymin width height
    Img =imcrop(Img, rect);
    I = imresize(Img, [128 128]); % setting all detected face images to 128x128
    imshow (A);
    % truesize;
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'g');
    hold off;
else
    I = [];
end
