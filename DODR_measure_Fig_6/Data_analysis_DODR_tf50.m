clear all
close all
clc

% Set_rho_tf50 = zeros(20);
% Set_Wc_tf50 = zeros(20,7,7);
% Set_Wd_tf50 = zeros(20,7,7);
f = [0.5 : 0.5 : 10];
% 
% for i = 1 : length(f)
%     [rho, Wc, Wd] = Main_for_DOCandDODR_Loop(f(i)); 
%     Set_rho_tf50(i) = rho;
%     Set_Wc_tf50(i,:,:) = Wc;
%     Set_Wd_tf50(i,:,:) = Wd;
% end
% 
% save Set_rho_tf50.mat Set_rho_tf50;
% save Set_Wc_tf50.mat Set_Wc_tf50;
% save Set_Wd_tf50.mat Set_Wd_tf50;

load Set_rho_tf50.mat;
load Set_Wc_tf50.mat;
load Set_Wd_tf50.mat;

for i = 1: length(f)
    dummy(:,:) = Set_Wc_tf50(i,:,:);
    dummy2(:,:) = Set_Wd_tf50(i,:,:);
    rho(i) = trace(inv(dummy)*dummy2);
    invWctrace(i) = trace(inv(dummy));
    Wdtrace(i) = trace(dummy2);
    rho_c(i) = trace(inv(dummy)*[0 0 10 0 0 0 0]'*[0 0 10 0 0 0 0]);
end

for j = 1 : 7
    for i = 1 : length(f)    
        dummy(:,:) = Set_Wc_tf50(i,:,:);
        idummy = inv(dummy);
        invWc(j,i) = idummy(j,j);        
    end
end

Wc1(:,:) =  Set_Wc_tf50(2,:,:);
Wc2(:,:) =  Set_Wc_tf50(3,:,:);
Wd(:,:) =  Set_Wd_tf50(1,:,:);

figure;plot(f,rho,'b','LineWidth',3)
hold on
plot([1.5, 1.5], [0,5000000],'--r','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
xlabel('cut off frequency of actuator(Hz)')
title('DODR at final time = 50')
grid on
legend('DODR', 'critical line')

figure;plot(f,rho_c,'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
xlabel('cut off frequency of actuator(Hz)')
title('DOC at final time = 50')
grid on

figure;plot(f,invWctrace,'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
xlabel('cut off frequency of actuator(Hz)')
title('trace of inverse of Wc')
grid on

figure;plot(f,Wdtrace,'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
xlabel('cut off frequency of actuator(Hz)')
title('trace of Wd')
grid on



figure;plot(f,invWc(1,:),'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
% xlabel('cut off frequency of actuator(Hz)')
title('(1,1) of inverse of Wc')
grid on

figure;plot(f,invWc(2,:),'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
% xlabel('cut off frequency of actuator(Hz)')
title('(2,2) of inverse of Wc')
grid on

figure;plot(f,invWc(3,:),'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
% xlabel('cut off frequency of actuator(Hz)')
title('(3,3) of inverse of Wc')
grid on

figure;plot(f,invWc(4,:),'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
xlabel('cut off frequency of actuator(Hz)')
title('(4,4) of inverse of Wc')
grid on

figure;plot(f,invWc(5,:),'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
xlabel('cut off frequency of actuator(Hz)')
title('(5,5) of inverse of Wc')
grid on

figure;plot(f,invWc(6,:),'b','LineWidth',3)
set(gca,'Fontsize',14,'FontWeight','demi')
xlabel('cut off frequency of actuator(Hz)')
title('(6,6), (7,7) of inverse of Wc')
grid on

% figure;plot(f,invWc(7,:),'b','LineWidth',3)
% set(gca,'Fontsize',14,'FontWeight','demi')
% xlabel('cut off frequency of actuator(Hz)')
% title('(7,7) of inverse of Wc')
% grid on