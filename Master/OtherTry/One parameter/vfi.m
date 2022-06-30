function [idB,idD,q]=vfi(p,v)
%---------------------------------------------------------------------------------------------------------------------------
% 1. Reallocation of matrices
%---------------------------------------------------------------------------------------------------------------------------
    V=zeros(p.Nb,p.Nz);
    Vc=zeros(p.Nb,p.Nz);
    Vd=zeros(p.Nz,1);
    q=ones(p.Nb,p.Nz).*(1/p.R);
    idB=zeros(p.Nb,p.Nz);
    idD=zeros(p.Nb,p.Nz);
%---------------------------------------------------------------------------------------------------------------------------
% 2. Value function iteration
%---------------------------------------------------------------------------------------------------------------------------
    iterV=0;
    distV=10;
    distQ=10;
    tic
    while (distV>p.tol || distQ>p.tol)
        Vcomp=V;
        q0=q;
%---------------------------------------------------------------------------------------------------------------------------
% 3. Default state (Vd)
%---------------------------------------------------------------------------------------------------------------------------
        [cdef,~,~,hTdef,hNdef]=cdefault(v.z,p);
        Vd=utility(p,cdef,hTdef,hNdef)'+p.beta*v.Pz*(p.lambda*V(p.zero_ind,:)'+(1-p.lambda)*Vd);
%---------------------------------------------------------------------------------------------------------------------------
% 4. Repayment state (Vc), total value (V) and default indicator (idD)
%---------------------------------------------------------------------------------------------------------------------------
        [yT,yN,hTn,hNn] = production(v.z,p);
        for j=1:p.Nz
            for i=1:p.Nb
                cN=yN(1,j);
                cT=max(yT(1,j)-v.b'.*q(:,j)+v.b(1,i),0);
                c=((1-p.theta).*cT.^((p.eta-1)/p.eta)+p.theta.*cN.^((p.eta-1)/p.eta)).^(p.eta/(p.eta-1));
                m=utility(p,c,hTn(1,j),hNn(1,j))+p.beta*(v.Pz(j,:)*V')';
                [Vc(i,j),idB(i,j)]=max(m(:));
                V(i,j)=(Vd(j,1)>Vc(i,j))*Vd(j,1)+(1-(Vd(j,1)>Vc(i,j)))*Vc(i,j);
                idD(i,j)=(Vd(j,1)>Vc(i,j));
            end
        end
%---------------------------------------------------------------------------------------------------------------------------
% 5. Debt price (q)
%---------------------------------------------------------------------------------------------------------------------------
        q=((1-idD)*v.Pz')./p.R;
        distV=max(max(abs(V-Vcomp)./((abs(V)+abs(Vcomp))./2+0.001)));
        distQ=max(max(abs(q-q0)./((abs(q)+abs(q0))./2+0.001)));
        iterV=iterV+1;
    end
%---------------------------------------------------------------------------------------------------------------------------
end