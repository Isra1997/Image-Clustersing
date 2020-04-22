function [k_best]=BestK(startK,endK)

    % list of the valuse of Q
    list_Q=[];
    
    for k=startK:endK
        % calling the clustering function 
        [IO,idx,centers,II]=imageclustering('Objects.bmp',k);
        
        % array that contains the counts of pixels in each cluster
        count=zeros(1,length(centers));

        % array that cotains the sum of differene of each point in a cluster and its center        
        sums=zeros(1,length(centers));

        % converting the image into a cloum vector   
        IIC=double(II(:));
        
        % calculating the above arrays       
        for i=1:length(idx)
            count(idx(i))= count(idx(i))+1;
            z=abs(IIC(i)-centers(idx(i)));
            sums(idx(i))=sums(idx(i)) + power(z,2);
        end
        

        % temp list that contains the average of the difference between each pixel and its cluster center for all cluters      
        list_temp=zeros(1,length(count));
        
        % calculating the above array       
        for j=1:length(sums)
            list_temp(j)=(1/count(j))*sums(j);
        end
        
        % calculating the numerator using the above array        
        current_numerator_Q=(1/k)*sum(list_temp);
        
        center_sums=0;
        % calculating the denomenrator which is the square differene of the
        % cluster centers
        for x=2:k
            center_sums=center_sums+power(abs(centers(x-1)-centers(x)),2);
        end
        
        current_denomerator_Q=(2/(k*(k-1)))*center_sums;
     
        list_Q(end+1)=(current_numerator_Q/current_denomerator_Q);
        
    end
     
    k_array=linspace(startK,endK,length(startK:endK));

    plot( k_array, list_Q,'*')
    
    [Q,k_ind]=min(list_Q);
    
    k_best=k_array(k_ind);
    
    [IO,idx,centers,II]=imageclustering('Objects.bmp',k_best);
    
    imshow(IO)
    
   
    
    
