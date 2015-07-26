class A_2_1_2

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f (8)              -- VUAR(1)
			f (1, 8)           -- VUAR(2) VUAR(2)
			f (2, 3, 8)        -- VUAR(1)
			f ("a", 4, "b", 8) -- VUAR(1)
			t := Current
			t (8)              -- VUAR(1)
			t (1, 8)           -- VUAR(2) VUAR(2)
			t (2, 3, 8)        -- VUAR(1)
			t ("a", 4, "b", 8) -- VUAR(1)
		end

feature

	f alias "()" (t1, t2: TUPLE)
		do
		end

end
