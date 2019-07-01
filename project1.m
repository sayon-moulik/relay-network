m=input('give the number of users :'); % take number of usrs
r=input('give numbers of relays:');    % take number of relays
s=input('number of iterators :');      % take number of iterators
A=randn(m,s);                          % A:= M X S matrix
[MAX,Index]=max(A)                     %MAX contains the maximum of columns M of A and Index contains the indexs of those maximim values 
A=[A;Index]                            % appending the indexs of the selected values