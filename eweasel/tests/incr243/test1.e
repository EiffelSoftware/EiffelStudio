class TEST1

feature
	
	f is
		local
			d: ARRAY [REAL_64]
			dsf: TEST
		do
			dsf.make
			d := {ARRAY [REAL_64]} << 1 >>
		end
		

end
