clear%%%distinguish up and down atoms
for jj=1 
poscar=import_poscar(['/home/qiusb/Desktop/CONTCAR',num2str(jj)]);
a=sortrows(poscar.coords( 1:poscar.atomcount(1,1),:),-3 );
coords=[a;poscar.coords( poscar.atomcount(1,1)+1:end,:)];
nn=0;
for ii=1:size(a,1)
    if a(ii,3)>sum(a(:,3))/size(a,1)
        nn=nn+1;
    end
end
%coords(:,1:2)=coords(:,1:2)-repmat([0.16667  0.33333 ],98,1);
n=['./CONTCAR', num2str(jj) ];
fid=fopen(n,'w+');
fprintf(fid,[poscar.comment '\n']);
fprintf(fid,'%g\n',1);
fprintf(fid,'%-4.6f     %-4.6f     %-4.6f\n',poscar.lattice'); 
fprintf(fid,'%s     ','Si C Ag'); 
fprintf(fid, '\n');
fprintf(fid,'%g     ',[nn,poscar.atomcount(1,1)-nn,poscar.atomcount(2,1)]); 
fprintf(fid, '\n');
fprintf(fid,'Direct\n');
for vv=1:size(poscar.coords,1)
    fprintf(fid,'%-4.6f     %-4.6f     %-4.6f  \n', coords(vv,:)');
end
fclose(fid);
end