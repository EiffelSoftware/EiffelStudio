class B[G->INTEGER,H->DOUBLE]
inherit
      A[G,H]
convert
   to_a: {A[DOUBLE,INTEGER]}
feature
   to_a: A[DOUBLE,INTEGER]
       do end
end

