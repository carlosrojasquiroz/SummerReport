function f=gridsearch0(p,v,d,Tr)
if Tr==1
    f.GridT=p.tol;
    f.GridN=linspace(p.LowBoundN,p.UpBoundN,151);
elseif Tr==0
    f.GridT=linspace(p.LowBoundT,p.UpBoundT,151);
    f.GridN=p.tol;
end
f.Jgs0=zeros(length(f.GridT),length(f.GridN));
f.Jgs1=zeros(length(f.GridT),length(f.GridN));
f.Jgs2=zeros(length(f.GridT),length(f.GridN));
f.Jgs3=zeros(length(f.GridT),length(f.GridN));
f.Jgs4=zeros(length(f.GridT),length(f.GridN));
%--------------------------------------------------------------------------------------------------------------------------
disp('I start the algorithm')
iter=0;
for i=1:length(f.GridT)
     for j=1:length(f.GridN)
            paramgs=[f.GridT(i) f.GridN(j)];
            [f.Jgs0(i,j),f.Jgs1(i,j),f.Jgs2(i,j),f.Jgs3(i,j),f.Jgs4(i,j)]=indirectinference(paramgs,p,v,d);
            iter=iter+1;
            display(iter)
     end
end
%--------------------------------------------------------------------------------------------------------------------------
end