class X [G -> NUMERIC]
 
feature
 
	f (g1, g2: G): G
		require
			g1_not_void: g1 /= Void
			g2_not_void: g2 /= Void
		do
			print ("Current is " + generating_type.out + "%N")
			print ("g1 is " + g1.generating_type.out + "%N")
			print ("g2 is " + g2.generating_type.out + "%N")
			Result := g1 + g2
			print ("Result is " + Result.generating_type.out + "%N")
		end
 
end
