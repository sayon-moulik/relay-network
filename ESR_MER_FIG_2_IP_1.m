clc;
clear all;
range_MER_dB=0:3:30;
gamma_0_dB=30;
gamma_0=10^(gamma_0_dB/10);
% R=1;
% %  ---------------channel parameter setting------------------
mean_SR=1;
mean_RD=mean_SR;
mean_SD=0.5;
mean_Ip_dB=0;
mean_Ip=10^(mean_Ip_dB/10);
mean_SP_dB=[-10,-20];
mean_SP_range=10.^(mean_SP_dB/10);
mean_RP_dB=[-10,-20];
mean_RP_range=10.^(mean_RP_dB/10);
SNR_dB=30;
SNR=10^(SNR_dB/10);
i_mer=1;
no_iteration=10^6;
K=4;
for mean_SP=mean_SP_range %no of relay
    for mean_RP= mean_RP_range
        for MER_dB=range_MER_dB
            lambda_1=10^(MER_dB/10);
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
            sec_cap(i_mer)=sum(pr_sec_cap.*pr_omega_k)

            i_mer=i_mer+1;
        end
    end
end
% =========================================================
 %plot(range_MER_dB,sec_cap,'-xk');
 %hold on;
 %xlabel('MER (dB)');
 %ylabel('ESR (bps/Hz)');
 %axis([0 30 0 5]);
 save('ESR_MER_FIG_2_IP_1.mat', 'range_MER_dB', 'sec_cap');
 %save('SIM_COG_ESR_K_2_3_4_Ip_1.mat', 'range_MER_dB', 'sec_cap');
%  --------------------------------------------------------------
 %grid on;