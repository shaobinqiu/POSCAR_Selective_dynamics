clear
n_cell=18
for ii=1:6
poscar=import_poscar(['/home/qiusb/Documents/sagar_190115/sagar/sagar/crystal/latticematching_files/output/POSCAR',num2str(n_cell+ii),'.vasp']);
n_F=poscar.atomcount(2,1)/5*4;
a=sortrows(poscar.coords(poscar.atomcount(1,1)+1:end,:),-3 );
coords=[poscar.coords(1:poscar.atomcount(1,1),:);sortrows(poscar.coords(poscar.atomcount(1,1)+1:end, :), -3)];
coords(1:poscar.atomcount(1,1),3)=repmat(0.57,poscar.atomcount(1,1),1);
n=['./POSCAR',num2str(ii)];
fid=fopen(n,'w+');
fprintf(fid,[poscar.comment '\n']);
fprintf(fid,'%g\n',1);
fprintf(fid,'%-4.6f     %-4.6f     %-4.6f\n',poscar.lattice');
for kk=1:size(poscar.symbols,2)
    fprintf(fid,'%s     ',poscar.symbols{1,kk}); 
end
fprintf(fid, '\n');
for kk=1:size(poscar.atomcount,1)
     fprintf(fid,'%g     ',poscar.atomcount(kk,1)); 
end
fprintf(fid, '\n');
fprintf(fid,'Selective dynamics\n');
fprintf(fid,'Direct\n');
for vv=1:size(poscar.coords,1)-n_F
    fprintf(fid,'%-4.6f     %-4.6f     %-4.6f     T    T    T \n', coords(vv,:)');
end
for vv=size(poscar.coords,1)-n_F+1:size(poscar.coords,1)
    fprintf(fid,'%-4.6f     %-4.6f     %-4.6f     F    F    F \n', coords(vv,:)');
end
fclose(fid);
end