% Algorytm interpolacji dwukwadratowej obrazu kolorowego

clear all
close all

% Wczytywanie obrazu
A = imread('szachkol.jpg');
B = im2double(A);
U = B;

%Okreœlenie wymiarów obrazu i ustalenie powiêkszenia
[width, height, rgb] = size(B);
pow = 2;

%Deklaracja macierzy wynikowej nowego obrazu
Int = zeros( width*pow, height*pow, rgb);

% Wyznaczenie ratio obrazu pocz¹tkowego i wynikowego
ratiox = 1/pow;
ratioy = 1/pow;

% Algorytm interpolacji dwukwadratowej
for r = 1:rgb
    for i = ceil(pow)*2: width*pow-1 
       for j = ceil(pow)*2: height*pow-1
            x = i*ratiox;
            y = j*ratioy;
            a1 = B(floor(x) -1 , floor(y) - 1, r);
            a2 = B(floor(x) -1 , floor(y), r);
            a3 = B(floor(x) -1 , floor(y) + 1, r);

            a4 = B(floor(x) , floor(y) - 1, r);
            a5 = B(floor(x) , floor(y), r );
            a6 = B(floor(x) , floor(y) + 1, r);

            a7 = B(floor(x) + 1 , floor(y) - 1, r);
            a8 = B(floor(x) + 1 , floor(y), r );
            a9 = B(floor(x) + 1 , floor(y) + 1, r);
            a = x - floor(x);
            b = y - floor(y);
            Fa0 = a4 + (a2 - a1)*a + (a1 - 2*a4 + a2)*a*a;
            Fa1 = a5 + (a8 - a7)*a + (a7 - 2*a5 + a8)*a*a;
            Fa2 = a6 + (a4 - a3)*a + (a3 - 2*a6 + a4)*a*a;
            Fab = Fa1 + (Fa2 - Fa0)*b + (Fa0 - 2*Fa1 + Fa2)*b*b;
            Int(i,j,r) = Fab;
       end
    end
end

% Prezentacja wyników
imshow(B);
figure;
imshow(Int);