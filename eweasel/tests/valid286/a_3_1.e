class A_3_1

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f (8, 9)              -- VUAR(2)
			f (1, 8, 9)           -- VUAR(2)
			f (2, 3, 8, 9)        -- VUAR(2)
			f ("a", 4, "b", 8, 9) -- VUAR(2)
			t := Current
			t (8, 9)              -- VUAR(2)
			t (1, 8, 9)           -- VUAR(2)
			t (2, 3, 8, 9)        -- VUAR(2)
			t ("a", 4, "b", 8, 9) -- VUAR(2)
		end

feature

	f alias "()" (t: TUPLE [BOOLEAN]; i, j: INTEGER)
		do
		end

end
