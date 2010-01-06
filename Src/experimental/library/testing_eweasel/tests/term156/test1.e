class TEST1

feature

	my_equal (a: ANY; b: like a): BOOLEAN is
			--
		do

		end

	f (a: ANY; b: like a) is
			-- 	
		require
			my_equal (a, b)
		do

		end


end
