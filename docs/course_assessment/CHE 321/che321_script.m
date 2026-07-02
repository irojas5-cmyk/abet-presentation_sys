clc;
clear all;

L=10;
A=0.01;
caf=40;

v=1;
vr=1;
k1=0.001;
k2=0.0001;

  %Outlet boundary conditions
  cal=caf;
  cbl=0;
  ccl=0;
  
  cend(:,:)=zeros;
  
for i=1:1:10
    
    cend(i,1)=cal;
    cend(i,2)=cbl;
    cend(i,3)=ccl;
    cend(i,4)=i;
    
    %Inlet boundary conditions
    cao= (v*caf + vr*cal)/(v+vr);
    cbo= (vr*cbl)/(v+vr);
    cco= (vr*ccl)/(v+vr);

    volspan=[0 A*L*1000];  %total volume range

    %Initial condition for the solver
    cinit=[cao; cbo; cco];

    [vol,c] = ode45(@che321_func,volspan,cinit);
    
    %Change cal,cbl,ccl in every iteration
    %Size of vol matrix
    s=size(vol);
    cal=c(s(1,1),1);
    cbl=c(s(1,1),2);
    ccl=c(s(1,1),3);
    

end

    graph=plot(cend(:,4),cend(:,1),cend(:,4),cend(:,2),cend(:,4),cend(:,3));
    set(graph,'LineWidth',5)
    xlabel('iteration');
    ylabel('Concentration');
    legend('A','B','C','Location','Best')
    set(gca,'FontSize',20)


    subplot(2,1,1) 
    graph2=plot(vol,c(:,1),vol,c(:,2),vol,c(:,3));
    set(graph2,'LineWidth',5)
    xlabel('Volume');
    ylabel('Concentration');
    legend('A','B','C','Location','Best')
    set(gca,'FontSize',20)


    subplot(2,1,2) 
    graph2=plot(vol,(caf-c(:,1))/caf);
    set(graph2,'LineWidth',5)
    xlabel('Volume');
    ylabel('X');
    legend('Conversion','Location','Best')
    set(gca,'FontSize',20)