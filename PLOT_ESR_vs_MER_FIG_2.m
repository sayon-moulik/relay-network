clc;
clear all;
range_MER_dB=0:3:30;
L=length(range_MER_dB);
load('ESR_MER_FIG_2_IP_0dot316');
plot(range_MER_dB,sec_cap(3*L+1:4*L),'-b','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(2*L+1:3*L),'-b','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(L+1:2*L),'-r','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(1:L),'-k','MarkerSize',7,'linewidth',2);
grid on;
xlabel('MER (dB)');
ylabel('ESR (bps/Hz)');
legend('SP=-20, RP=-20','SP=-20, RP=-10','SP=-10, RP=-20','SP=-10, RP=-10','location','SouthEast');
annotation('textbox',...
    [0.1635 0.792857142857143 0.207928571428571 0.0857142857142857],...
    'String',{'IP : -5 dB'},...
    'LineStyle',':',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');
savefig('Plot_ESR_MER_FIG_2_IP_0dot316.fig');
figure;
load('ESR_MER_FIG_2_IP_1');
plot(range_MER_dB,sec_cap(3*L+1:4*L),'-b','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(2*L+1:3*L),'-b','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(L+1:2*L),'-r','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(1:L),'-k','MarkerSize',7,'linewidth',2);
grid on;
xlabel('MER (dB)');
ylabel('ESR (bps/Hz)');
legend('SP=-20, RP=-20','SP=-20, RP=-10','SP=-10, RP=-20','SP=-10, RP=-10','location','SouthEast');
annotation('textbox',...
    [0.1635 0.792857142857143 0.207928571428571 0.0857142857142857],...
    'String',{'IP : 0 dB'},...
    'LineStyle',':',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');
savefig('Plot_ESR_MER_FIG_2_IP_1.fig');
figure;
load('ESR_MER_FIG_2_IP_3dot162');
plot(range_MER_dB,sec_cap(3*L+1:4*L),'-b','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(2*L+1:3*L),'-b','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(L+1:2*L),'-r','MarkerSize',7,'linewidth',2);
hold on;
plot(range_MER_dB,sec_cap(1:L),'-k','MarkerSize',7,'linewidth',2);
grid on;
clear all;
xlabel('MER (dB)');
ylabel('ESR (bps/Hz)');
legend('SP=-20, RP=-20','SP=-20, RP=-10','SP=-10, RP=-20','SP=-10, RP=-10','location','SouthEast');
annotation('textbox',...
    [0.1635 0.792857142857143 0.207928571428571 0.0857142857142857],...
    'String',{'IP : 5 dB'},...
    'LineStyle',':',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off');
savefig('Plot_ESR_MER_FIG_2_IP_3dot162.fig');