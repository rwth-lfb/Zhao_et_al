function exists = pair_exists(list1, list2, a, b)

exists = 0;
for(i=1:length(list1))
   
   if( ((list1(i)==a) && (list2(i)==b))  ||  ((list1(i)==b) && (list2(i)==a))  )
     exists = 1;
   end
   
end