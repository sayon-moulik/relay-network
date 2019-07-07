for i=1:100
       for j=1:100
        while true     
            a=randn(1);
            b=randn(1);
            c=sqrt(a^2+b^2)/2;
            if c<1
                break
            end 
        end
        z(i,j)=c;
    end
end
sq=z.^2;
hist(sq);
histogram(sq,10)
