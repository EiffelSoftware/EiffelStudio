class A_3_2

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f (8, 9)              -- VUAR(2)
			f (8, 1, 9)           -- VUAR(2)
			f (8, 2, 3, 9)        -- VUAR(2)
			f (8, "a", 4, "b", 9) -- VUAR(2)
			t := Current
			t (8, 9)              -- VUAR(2)
			t (8, 1, 9)           -- VUAR(2)
			t (8, 2, 3, 9)        -- VUAR(2)
			t (8, "a", 4, "b", 9) -- VUAR(2)
		end

feature

	f alias "()" (i: INTEGER; t: TUPLE [BOOLEAN]; j: INTEGER)
		do
		end

end
