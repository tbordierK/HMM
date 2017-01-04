function indice=indice_max(v)
   n=length(v);
   indice=1;
   max=v(1);
   for i=1:n
       if v(i)>max
           indice=i;
           max=v(i);
       end
   end
end