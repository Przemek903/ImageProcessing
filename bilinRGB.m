% Algorytm interpolacji dwuliniwej obrazu kolorowego
clear all
close all

% Wczytywanie obrazu
A = imread('peppers.tif');
B = im2double(A);
U = B;

%Okreœlenie wymiarów obrazu i ustalenie powiêkszenia
[width, height, rgb] = size(B);
pow = 3;

%Deklaracja macierzy wynikowej nowego obrazu
Int = zeros( width*pow, height*pow, rgb);

% Wyznaczenie ratio obrazu pocz¹tkowego i wynikowego
ratiox = 1/pow;
ratioy = 1/pow;

% Algorytm interpolacji dwuliniowej
for r = 1:rgb
    for i = ceil(pow): width*pow
       for j = ceil(pow): height*pow
            x = i*ratiox;
            y = j*ratioy;
            a1 = B(floor(x), floor(y),r);
            a2 = B(floor(x), ceil(y),r);
            a3 = B(ceil(x), floor(y),r);
            a4 = B(ceil(x), ceil(y),r);
            a = x - floor(x);
            b = y - floor(y);
            Fa0 = (1-a)*a1 + a*a3;
            Fa1 = (1-a)*a2 + a*a4;
            Fab = (1-b)*Fa0 + b*Fa1;
            Int(i,j,r) = Fab;
       end
    end
end

% Prezentacja wyników
imshow(B);
figure;
imshow(Int);