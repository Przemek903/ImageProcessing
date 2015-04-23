% Algorytm wyrównywania histogramu

clear all
close all

% Wczytywanie obrazu
A = imread('off.tif');
B = im2double(A);
U = B;
%Okreœlenie wymiarów obrazu i iloœci poziomów jasnoœci (n)
[width, height] = size(B);
n = 200;

% Wyznaczenie histogramu obrazu oryginalnego
his = zeros(1,n);
for i=1:n
    suma = 0;
    for a = 1: width
        for b = 1: height
            if B(a,b) >= (i-1)/n && B(a,b) < (i)/n
                suma = suma + 1;
            end
        end
    end
    his(1,i) = suma;
end


% Wyznaczenie histogramu skumulowanego obrazu oryginalnego
D = zeros(1,n);
E = zeros(1,n);

suma = 0;
for i=1:n
   D(1,i) = (his(1,i)/(width * height));
   suma = suma + D(1,i);
   E(1,i) = suma;
   
end

% Operacje na obrazie podstawowym w celu wyrównania histogramu 
Img = zeros(width, height);
for i=1:n
    for a = 1: width
        for b = 1: height
            if B(a,b) >= (i-1)/n && B(a,b) < (i)/n
                Img(a,b) = E(1,i);
            end
        end
    end
end


% Wyznaczenie histogramu wyrównanego
hiseq = zeros(1,n);
for i=1:n
    suma = 0;
    for a = 1: width
        for b = 1: height
            if Img(a,b) >= (i-1)/n && Img(a,b) < (i)/n
                suma = suma + 1;
            end
        end
    end
    hiseq(1,i) = suma;
end

%Prezentacja wyników
imshow(B);
figure;
imshow(Img);
figure;
bar(his);
set(gca,'XTick', [0 1])
figure;
bar(hiseq);

figure
hist(B,n);
figure
J = histeq(B);
hist(J,n);
figure, imshow(J)
