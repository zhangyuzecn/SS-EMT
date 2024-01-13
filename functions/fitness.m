function fv = fitness(x,IE,MI,N_sel)
fv=[];
[~,s_index] = sort(x);
selectbands_1 = s_index(1:2);
selectbands_2 = s_index(1:round(N_sel/2));
selectbands_3 = s_index(1:N_sel);

fit1 = -(sum(IE(selectbands_1)) + sum(IE(selectbands_2)) + sum(IE(selectbands_3)))/3;

MI1 = MI(selectbands_1(1),selectbands_1(2));
c=0;
MI2=0;
for i = 1:N_sel/2
    for j = i+1:N_sel/2
        MI2 =MI2 + MI(selectbands_2(i),selectbands_2(j));
        c=c+1;
    end
end
MI2 = MI2/c;
c=0;
MI3=0;
for i = 1:N_sel
    for j = i+1:N_sel
        MI3 =MI3 + MI(selectbands_3(i),selectbands_3(j));
        c=c+1;
    end
end
MI3 = MI3/c;


fit2 = (MI1+MI2+MI3)/3;
fv(1)=fit1;
fv(2)=fit2;
end