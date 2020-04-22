function [output_image,clusterIndexes,clusterCenters,grayimg]=imageclustering(input_image,k)
    % reading the image
    I=imread(input_image);
    
    % converting the read image to grayscale  
    grayimg=rgb2gray(I);
    
    % converting the image to a colum vector
    grayLevels = double(grayimg(:));
    
    % calculating the cluster size
    [clusterIndexes, clusterCenters] = kmeans(grayLevels, k,'emptyaction','singleton');
    
    [m,n]=size(grayimg);
    output_image=zeros(m,n);
    labels=reshape(clusterIndexes,m,n);
   
    % allocating the value of the center of the cluster to each pixel
    % according to its allocated cluster
    for i=1:m
        for j=1:n
            output_image(i,j)=clusterCenters(labels(i,j));
        end
    end
    
    
    output_image=uint8(output_image);
    
    % imshow(output_image);
  