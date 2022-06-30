function J=objectivecriterion(d,DeltaSim)
%DeltaHatT=d.DeltaHat(:,d.Nhorz+1)';
%DeltaSimT=DeltaSim(:,p.Nhorz+1)';
%if iW==0
%    W=[d.StdevDelta(1,d.Nhorz+1)^-1 d.StdevDelta(2,d.Nhorz+1)^-1].*eye(2);
%else
%    W=eye(2);
%end
%Md=(DeltaHatT-DeltaSimT);
%J=Md*W*Md';
%
W=eye(2);
Md=(DataMoments-DeltaSim);
J=Md*W*Md';
end