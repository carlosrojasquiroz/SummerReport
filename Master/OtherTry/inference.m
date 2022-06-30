function J0=inference(param,p,v,d)
%---------------------------------------------------------------------------------------------------------------------------
% Parameters: default cost
%---------------------------------------------------------------------------------------------------------------------------
p.chi1_T=param(1); 
p.chi1_N=param(2); 
%---------------------------------------------------------------------------------------------------------------------------
% Value function iteration
%---------------------------------------------------------------------------------------------------------------------------
[v.idB,v.idD,v.q]=vfi(p,v);
%---------------------------------------------------------------------------------------------------------------------------
% Simulation
%---------------------------------------------------------------------------------------------------------------------------
r=simulation(p,v);
%---------------------------------------------------------------------------------------------------------------------------
% Estimation based on simulated data
%---------------------------------------------------------------------------------------------------------------------------
if p.moment==1
%---------------------------------------------------------------------------------------------------------------------------
% Method of moments
%---------------------------------------------------------------------------------------------------------------------------
    RelativeStd=zeros(p.Get,1);
    MeanSpread=zeros(p.Get,1);
    for i=1:p.Get
    [~,SyT2]=hpfilter(log(r.yT(i,:)),p.lambdaHP);
    [~,SyN2]=hpfilter(log(r.yN(i,:)),p.lambdaHP);
    RelativeStd(i,:)=std(SyT2)/std(SyN2);
    rr=r.spread(i,:);
    MeanSpread(i,:)=mean(rr(isfinite(rr)));
    end
    Moment1=mean(RelativeStd);
    Moment2=mean(MeanSpread);
    MomentSim=[Moment1 Moment2];
    W=eye(2);
    Md=(d.MomentData-MomentSim);
    J0=Md*W*Md';
else
%---------------------------------------------------------------------------------------------------------------------------
% Indirect inference
%---------------------------------------------------------------------------------------------------------------------------
    DeltaSim=estimation(p,r);
    DeltaHatT=[d.DeltaHat(1,d.Nhorz+1) d.DeltaHat(2,d.Nhorz+1)];
    DeltaSimT=[DeltaSim(1,d.Nhorz+1) DeltaSim(2,d.Nhorz+1)];
    W=eye(2);
    Md=(DeltaHatT-DeltaSimT);
    J0=Md*W*Md';
end
%---------------------------------------------------------------------------------------------------------------------------
end