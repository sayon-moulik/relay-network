M=5
S=10
K=15
L=20
for i=1:S
    lambda_SD(i)=abs(mag2db(i+10)); % converting a db value to abs magnitude
end
for i=1:M
    for j=1:S
        SD(i,j)=lambda_SD(i)*randn(1); 
    end
end

        