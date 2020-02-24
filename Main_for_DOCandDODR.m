close all
clear all
clc
%20200224 vertical 논문 제출함.
%현재 남은 코드는 이코드가 전부이며, 논문 리뷰시 여기서 해결해야 함.
%지금 DOC관련 코드로는 이코드로 재현 가능해보임. 특히 인풋이 Y를 그리고 있는데 논문에서는 u를 그리고 있음을 유의
%DOC에서 fc=1.5가 critical point처럼 급격히 값이 커지는데 논문에서는 그렇게 구현되어 있지 않음. 왜지?

%DODR은 구현이 잘 안되는거 같은데... 왜지? 노이즈 정보때문인듯

%% parameters
% code parameters
type = 4;                           % AWD:4, 2WD:2
roadnoise = 1;                      %apply roadnoise=1, otherwise 0
dataplot = 1;                       %plot data=1, otherwise 0
actuator_dynamics_on = 1;           %apply actuaotr dynamics=1, otherwise 0

% design parameters
cutoff_frequency_of_actuator = 10;   % Hz
finite_time_of_DOC = 3;             % sec  
Ts = 0.01;                          % sec
v_initial = 10;                     % m/s  
v_final = 10;                       % m/s

%% parameters
% vehicle_parameters_TaehyunShim;
% vehicle_parameters_EclassSedan;
% vehicle_parameters_EclassSUV;
vehicle_parameters_AclassHatchback;

global ms; global Jy; global Jw; global a; global b; global h;
global ksf; global ksr; global bsf; global bsr; global mw; global kt;
global ktf; global ktr; global r; global g;

%% Make system model
[An,Bn,Dn,Arn,Brn,Drn,M,C,K,F] = System_model(type);
xin = [0 0 v_initial 0 0]';
xfn = [0 0 v_final-v_initial 0 0]';
% xfn = [0.1 0 0 0 0]';
xirn = [v_initial]';
xfrn = [v_final-v_initial]';
% xfrn = [0]';


%% analysis of nominal system
Analysis_nominal_system(An,Bn,Dn,v_initial,v_final,xin,xfn);

%% Make roadnoise
[w,Sw] = Road_noise(roadnoise,a,b,v_initial,Ts,finite_time_of_DOC);

%% Actuator - 1st order low pass filter
[A_actuator,B_actuator,D_actuator,xi_actuator,xf_actuator,Ar_actuator,Br_actuator,Dr_actuator,xir_actuator,xfr_actuator] = Include_actuator(actuator_dynamics_on,type,An,Bn,Dn,Arn,Brn,Drn,xin,xfn,xirn,xfrn,cutoff_frequency_of_actuator);

if actuator_dynamics_on == 1
    A = A_actuator; B = B_actuator; D = D_actuator; 
    Ar = Ar_actuator; Br = Br_actuator; Dr = Dr_actuator;
    xi = xi_actuator; xf = xf_actuator;
    xir = xir_actuator; xfr = xfr_actuator;
else
    A = An; B = Bn; D = Dn;
    Ar = Arn; Br = Brn; Dr = Drn;
    xi = xin; xf = xfn;
    xir = xirn; xfr = xfrn;
end
save A.mat A;save B.mat B; save D.mat D; save Sw.mat Sw;
save Ar.mat Ar;save Br.mat Br; save Dr.mat Dr;

%% DOC and DODR
[Wd,Wc,Wcr,iWc,iWcr,rho,rho_rigid,t,tr] = DOCandDODR(A,B,D,Ar,Br,Dr,finite_time_of_DOC,Ts,Sw,xi,xf,xir,xfr);
% [rho_frequency] = DODR_frequency(A,B,D,iWc,Sw,xf,roadnoise);
[rho_from_input,rho_rigid_from_input,u,ur,Y,Yr] = InputandResponse(iWc,iWcr,A,B,D,Ar,Br,Dr,t,tr,Ts,xi,xf,xir,xfr,type,w,finite_time_of_DOC);

%% Cehck Controllability
R_AB = rank(ctrb(A,B));
R_Wc = rank(Wc);

%% data plot
DATA_Plot(dataplot,actuator_dynamics_on,type,roadnoise,u,ur,Y,Yr,w,Ts,t,tr);
% DATASET_Plot;




