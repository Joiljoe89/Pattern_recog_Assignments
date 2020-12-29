function RGB_24bins = color_hist(RGB_24bins,I)
  m=256;n=256; % Image size 256x256
  mm=32;nn=32; % Patch size 32x32
  Ir=I(:,:,1);
  Ig=I(:,:,2);
  Ib=I(:,:,3);    
  patch_m=ceil(m/mm); patch_n=ceil(n/nn);
  edge_val=[0,32,64,96,128,160,192,224,256];
  
    for i=1:patch_m
        for j=1:patch_n
           
            r_patch=Ir(mm*(i-1)+1:mm*i,nn*(j-1)+1:nn*j);
            [Nr,edge]=histcounts(r_patch,edge_val);
            g_patch=Ig(mm*(i-1)+1:mm*i,nn*(j-1)+1:nn*j);
            [Ng,edge]=histcounts(g_patch,edge_val);
            b_patch=Ib(mm*(i-1)+1:mm*i,nn*(j-1)+1:nn*j);
            [Nb,edge]=histcounts(b_patch,edge_val);
            patch_bins=[Nr,Ng,Nb];
            RGB_24bins=[RGB_24bins;patch_bins];
        end
        
    end
   
end