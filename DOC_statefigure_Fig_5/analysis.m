clear all
close all
clc

t = [0 : 0.01 : 3];
tr = [0 : 0.01 : 3];
load u_1.mat;
load ur_1.mat;
load u_10.mat;
load ur_10.mat;
load Y_1.mat;
load Yr_1.mat
load Y_10.mat;
load Yr_10.mat;

figure;
% set(gcf,'Position', [1950 550 630 450])
set(gca,'Fontsize',16,'FontWeight','demi')
plot(tr,Yr_10(:,1)','k','LineWidth',3)
hold on
plot(t,Y_1(:,1)','--b','LineWidth',3)
plot(tr,Y_10(:,1)','--r','LineWidth',3)
xlabel('time(sec)')
ylabel('m')
title('heave')
legend('open loop','fa=1Hz','fa=10Hz')
grid on

figure;
% set(gcf,'Position', [1950 550 630 450])
set(gca,'Fontsize',16,'FontWeight','demi')
plot(tr,Yr_10(:,2)','k','LineWidth',3)
hold on
plot(t,Y_1(:,2)','--b','LineWidth',3)
plot(tr,Y_10(:,2)','--r','LineWidth',3)
xlabel('time(sec)')
ylabel('[rad/sec]')
title('pitch')
legend('open loop','fa=1Hz','fa=10Hz')
grid on

figure;
% set(gcf,'Position', [1950 550 630 450])
set(gca,'Fontsize',16,'FontWeight','demi')
plot(tr,Yr_10(:,3)','k','LineWidth',3)
hold on
plot(t,Y_1(:,3)','--b','LineWidth',3)
plot(tr,Y_10(:,3)','--r','LineWidth',3)
xlabel('time(sec)')
ylabel('m/sec')
title('dx')
legend('open loop','fa=1Hz','fa=10Hz')
grid on

figure;
% set(gcf,'Position', [1950 550 630 450])
set(gca,'Fontsize',16,'FontWeight','demi')
plot(tr,ur_10(1,:)*2,'k','LineWidth',3)
hold on
plot(t,u_1(1,:)*2,'--b','LineWidth',3)
plot(tr,u_10(1,:)*2,'--r','LineWidth',3)
xlabel('time(sec)')
ylabel('N')
title('input')
legend('open loop','fa=1Hz','fa=10Hz')
grid on

