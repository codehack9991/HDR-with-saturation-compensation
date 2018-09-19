%HDR image generation using a single image using Inverted Local Patterns

img=imread('girl.jpg');%input image
%{
 LAB = rgb2lab(I);
 L = LAB(:,:,1)/100;
 L = adapthisteq(L,'NumTiles',[8 8],'ClipLimit',0.005);
 LAB(:,:,1) = L*100;
 img = lab2rgb(LAB);
%}

img2=imresize(img,[256,256]);%resize image to 256x256 resolution
img3=imresize(img,[256,256]);%resize image to 256x256 resolution
img_ori=img2;
img2=rgb2ycbcr(img2);
[x,y,z]=size(img2);
img_grey=img2(:,:,1);%convert RGB image to grayscale image
img_Cb = img2(:,:,2);%Cb part of YCbCr of image
img_Cr = img2(:,:,3);%Cr part of YCbCr of image

for i=1:1:x
    for j=1:1:y
        img_grey(i,j)=double((double(img_grey(i,j)-16)*255)/219);
    end
end



%mean intensity of the image
meanIntensity = mean(mean(img2(:,:,1)));

%Modifying the Cb and Cr values


for i=1:1:x
    for j=1:1:y
        if img2(i,j,1)>meanIntensity
            %img2(i,j,2) = img2(i,j,2)*1;
            %img2(i,j,3) = img2(i,j,3)*1;
            
            img2(i,j,2) = double(double(img2(i,j,2))*double((double(img2(i,j,1)/meanIntensity))^0.5));
            img2(i,j,3) = double(double(img2(i,j,3))*double((double(img2(i,j,1)/meanIntensity))^0.5));
            
            %log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
           % log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
          %img2(i,j,3) = double(double(img2(i,j,3))*double((double((img2(i,j,1)/meanIntensity))^0.5)));
        
        end    
    end
end



%{
for i=1:1:x
    for j=1:1:y
        if img_grey(i,j)>meanIntensity
            img2_a(i,j,2) = img2(i,j,2)*2;
            img2_a(i,j,3) = img2(i,j,3)*2;
            %log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
           % log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
          %img2(i,j,3) = double(double(img2(i,j,3))*double((double((img2(i,j,1)/meanIntensity))^0.5)));
        end    
    end
end    

for i=1:1:x
    for j=1:1:y
        if img_grey(i,j)>meanIntensity
            img2_b(i,j,2) = img2(i,j,2)*3;
            img2_b(i,j,3) = img2(i,j,3)*3;
            %log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
           % log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
          %img2(i,j,3) = double(double(img2(i,j,3))*double((double((img2(i,j,1)/meanIntensity))^0.5)));
        end    
    end
end    

for i=1:1:x
    for j=1:1:y
        if img_grey(i,j)>meanIntensity
            img2_c(i,j,2) = img2(i,j,2)*4;
            img2_c(i,j,3) = img2(i,j,3)*4;
            %log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
           % log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
          %img2(i,j,3) = double(double(img2(i,j,3))*double((double((img2(i,j,1)/meanIntensity))^0.5)));
        end    
    end
end    

for i=1:1:x
    for j=1:1:y
        if img_grey(i,j)>meanIntensity
            img2(i,j,2) = (img2_a(i,j,2)+img2_b(i,j,2)+img2_c(i,j,2))/9;
            img2(i,j,3) = (img2_a(i,j,3)+img2_b(i,j,3)+img2_c(i,j,3))/9;
            %log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
           % log(img2(i,j,2)) = double(double(log(img2(i,j,2)))*double((double((log(img2(i,j,1))/meanIntensity))^0.5)));
          %img2(i,j,3) = double(double(img2(i,j,3))*double((double((img2(i,j,1)/meanIntensity))^0.5)));
        end    
    end
end    
%}


[hist,o]=imhist(img_grey);%hist represents luminicance histogram
HB=0;%HB value of original image
for i=1:1:256
    HB=HB+abs(hist(i)-255);
end

% here we set some thresholds th1,th2,th3,th4 and thdark
th1=16;
th2=51;
th3=206;
th4=241;
thdark=0;

%Now we calculate values of 'low' and 'high'.
%These will determine whether original image is dark,bright,extreme or normal.

low=0;
high=0;
for i=1:1:th1-1
    low=low+hist(i)*2;
end

for i=th1:1:th2-1
    low=low+hist(i);
end

for i=th3:1:th4-1
    high=high+hist(i);
end

for i=th4:1:256
    high=high+hist(i)*2;
end

if low>(high*2)
    thdark=128; %dark image
elseif high>(low*2)
    thdark=0;   %bright image
elseif (high/low)<=2 && (high/low)>=0.5
    thdark=50;  %extreme image
% else
%     return; %original image is already HDR
end
    
%Here we apply a 3x3 low pass on img_max
img_low = imfilter(img_grey,fspecial('average',[3 3]));

%Now we apply inverse operation on img_low
%After the inverse operation, bright regions become dark and dark regions
%become bright
img_inv=size([256,256]);
for i=1:1:x
    for j=1:1:y
        p=double(255-img_low(i,j));
        p=p*p;
        img_inv(i,j)=double(p/255);
    end
end

%Dark enhancement
%Here we brighten the darker regions of the original image 
%If pixel value is less than thdark,then we increase its brightness
%Otherwise it remains same      
img_dark=size([256,256]);
for i=1:1:x
    for j=1:1:y
        if img_grey(i,j)<thdark
            temp=double(img_grey(i,j))+double(double(thdark-img_grey(i,j))*0.05);
            img_dark(i,j)=temp;           
        else
            img_dark(i,j)=img_grey(i,j);
        end
    end
end


%Mixing operation
%Here we mix the results of inverse operation and dark enhancement
%We use a parameter k which depends on type of image.
%More the darkness,more the value of k and vice-versa.
k=1.82*(1e-8)*low+0.009;
img_mix=size([256,256]);
for i=1:1:x
    for j=1:1:y
        temp=img_dark(i,j)*img_inv(i,j);
        temp=temp*k;
        img_mix(i,j)=temp;
    end
end

%Brightness enhancement
%Here we increase brightness of img_mix to get our HDR image
thb=29.17;
img_hdr=img_mix;



for i=1:1:x
        for j=1:1:y
            if img_dark(i,j)>=thb
                p=double(img_dark(i,j)-thb);%%%
                p=p*p;
                p=p*0.005;%%%
                img_hdr(i,j)=img_mix(i,j)+p;
            else
                img_hdr(i,j)=img_mix(i,j);
            end
        end
end

a=max(img_hdr);
for i=1:1:x
        for j=1:1:y
           if img_hdr(i,j)==max(a)
              disp(i)
               disp(j)
           end
        end
end


img2(:,:,1)=img_hdr;
[hist_hdr,o1]=imhist(img2(:,:,1));
img_new=ycbcr2rgb(img2);

img_des0=imread('000003_in_prediction_prediction_reinhard.jpg');%Proposed image

img_des=imresize(img_des0,[256,256]);

[hist_hdr2,o2]=imhist(img_des);%hist_hdr2 represents luminicance histogram of Proposed image



 figure;
 imshow(img_ori)
%figure;
%imshow(img_grey)
% figure;
% imshow(img_low)
%figure;
%imshow(img_inv)
%figure;
%imshow(img_dark)
%figure;
%imshow(img_mix)
% figure;
% imshow(img_hdr)
%figure;
%imshow(img_des0)
%figure;
%imshow(img_des1)
%figure;
%imshow(img_des2)
%figure;
%imshow(img_des3)
figure;
imshow(img_new)
% figure;
% imshow(img2(:,:,1))
% figure;
% imhist(img_hdr)
%figure;
%plot(hist_hdr)
%ylim([0,2000]);
%figure;
%imshow(img_des)
%figure;
%imhist(img_des)
% ylim([0,max(hist_hdr)]);
%figure;
%plot(hist)
%ylim([0,max(hist)]);
%figure;
%plot(hist_hdr2)
%ylim([0,max(hist_hdr2)]);
%figure;
%plot(hist_dark)
%ylim([0,max(hist_dark)]);
%figure;
%plot(hist_mix)
%ylim([0,max(hist_mix)]);