clc;
clear all;
gamma_0_dB=0;
gamma_0=10^(gamma_0_dB/10);
% R=1;

% %  ---------------channel parameter setting------------------
mean_SR=1;
mean_RD=mean_SR;
mean_SD=0.5;
mean_Ip_dB=-5;
mean_Ip=10^(mean_Ip_dB/10);
mean_SP=0.2;
mean_RP=mean_SP;

SNR_dB=0:5:30;
RANGE_SNR=10.^(SNR_dB/10);

i_snr=1;
no_iteration=10^6;
for K=2:4 %no of relay
    for SNR=RANGE_SNR
        lambda_1=10^(20/10);
        lambda_2=lambda_1;
        
        mean_SE=mean_SD/lambda_1;
        mean_RE=mean_RD/lambda_2;
        
        count_sec_cap=zeros(K+1,1); % 1st element :esr_direct, rest: esr_relay
        count_omega_k=zeros(K+1,1);
        for i_iteration=1:no_iteration
            chnl_SD = sqrt(SNR*mean_SD).*abs(sqrt(0.5)*(randn(1)...
                +i*randn(1)));
            chnl_SE = sqrt(SNR*mean_SE).*abs(sqrt(0.5)*(randn(1)...
                +i*randn(1)));
            chnl_SP = sqrt(SNR*mean_SP).*abs(sqrt(0.5)*(randn(1)...
                +i*randn(1)));
            for i_relay=1:K
                chnl_SR(i_relay)=sqrt(SNR*mean_SR).*abs(sqrt(0.5)*(randn(1)...
                    +i*randn(1)));
                chnl_RD(i_relay) = sqrt(SNR*mean_RD).*abs(sqrt(0.5)*(randn(1)...
                    +i*randn(1)));
                chnl_RE(i_relay) = sqrt(SNR*mean_RE).*abs(sqrt(0.5)*(randn(1)...
                    +i*randn(1)));
                chnl_RP(i_relay) = sqrt(SNR*mean_RP).*abs(sqrt(0.5)*(randn(1)...
                    +i*randn(1)));
            end
            %Ahmed
            [~,decoding_set]=find(mean_Ip*chnl_SR.^2./(chnl_SP.^2)>=gamma_0);
            %relay selection rule
            [selected_RD_SNR,selected_relay_index] = max(chnl_RD(decoding_set).^2,[],2);% select column wise
            size_of_decoding_set= numel(decoding_set);
            
            count_omega_k(size_of_decoding_set+1)=count_omega_k(size_of_decoding_set+1)+1;
            
            if size_of_decoding_set==0
                end_SNR_D(i_iteration) = mean_Ip*chnl_SD.^2./(chnl_SP.^2);
                end_SNR_E(i_iteration) = mean_Ip*chnl_SE.^2./(chnl_SP.^2);
                R_s = max(0,log2((1+end_SNR_D(i_iteration))/(1+end_SNR_E(i_iteration))));
            else
                end_SNR_D(i_iteration) =  (mean_Ip*chnl_SD.^2)./(chnl_SP.^2)...
                    +mean_Ip*chnl_RD(decoding_set(selected_relay_index)).^2./(chnl_RP(decoding_set(selected_relay_index)).^2);
                end_SNR_E(i_iteration) =  mean_Ip*chnl_SE.^2./(chnl_SP.^2)...
                    +mean_Ip*chnl_RE(decoding_set(selected_relay_index)).^2./(chnl_RP(decoding_set(selected_relay_index)).^2);
                R_s = max(0,0.5*log2((1+end_SNR_D(i_iteration))/(1+end_SNR_E(i_iteration))));
            end
            count_sec_cap = count_sec_cap+R_s;
        end
        pr_omega_k=count_omega_k./no_iteration;
        pr_sec_cap=count_sec_cap./no_iteration;
        sec_cap(i_snr)=sum(pr_sec_cap.*pr_omega_k)
        
        i_snr=i_snr+1;
    end
end
% =========================================================
 %plot(range_MER_dB,sec_cap,'-xk');
 %hold on;
 %xlabel('MER (dB)');
 %ylabel('ESR (bps/Hz)');
 %axis([0 30 0 5]);
 save('ESR_vs_SNR_FIG_1_IP_0dot316_sayon.mat', 'RANGE_SNR', 'sec_cap');
 %save('SIM_COG_ESR_K_2_3_4_Ip_1.mat', 'range_MER_dB', 'sec_cap');
%  --------------------------------------------------------------
 %grid on;