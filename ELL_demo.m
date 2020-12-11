%% Example-based single image detail enhancement based on Metropolis theorem
%% Journal paper: Electronic letters
%% First author: He Jiang
%  All authors: He Jiang Jie Yang
%  Date: 2020-12-10
%  All images files are saved in folder data, using format "*png" 

clc;clear all;warning off;
Files = dir(strcat('.\data\','*.png')); 
LengthFiles = length(Files); 
factor = 3; 
mkdir results;
for ii = 1:LengthFiles
    disp('strat processing image');
    Files(ii).name
    tic
    image=double(imread(strcat('.\data\',Files(ii).name)));
    outimg1=image(:,:,1);
    outimg2=image(:,:,2);
    outimg3=image(:,:,3);
    %% using Metropolis theorem to get H1
    H1_outimg1=MT(outimg1);             
    H1_outimg2=MT(outimg2); 
    H1_outimg3=MT(outimg3);
    %% get details
    Details=zeros(size(image,1),size(image,2),3);
    Details(:,:,1)=imresize(H1_outimg1,[size(image,1),size(image,2)],'bilinear');
    Details(:,:,2)=imresize(H1_outimg2,[size(image,1),size(image,2)],'bilinear');
    Details(:,:,3)=imresize(H1_outimg3,[size(image,1),size(image,2)],'bilinear');
    %% add details to the original images
    outimg1=outimg1+Details(:,:,1)*factor;
    outimg2=outimg2+Details(:,:,2)*factor;
    outimg3=outimg3+Details(:,:,3)*factor;
    outimg(:,:,1)=outimg1;
    outimg(:,:,2)=outimg2;
    outimg(:,:,3)=outimg3;
    toc
    imwrite(uint8(outimg),strcat('.\results\',Files(ii).name(1:end-4),'_MT.png'));
    clear outimg;
end