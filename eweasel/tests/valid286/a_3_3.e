class A_3_3

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f (8, 9)              -- VUAR(2)
			f (8, 9, 1)           -- VUAR(2)
			f (8, 9, 2, 3)        -- VUAR(2)
			f (8, 9, "a", 4, "b") -- VUAR(2)
			t := Current
			t (8, 9)              -- VUAR(2)
			t (8, 9, 1)           -- VUAR(2)
			t (8, 9, 2, 3)        -- VUAR(2)
			t (8, 9, "a", 4, "b") -- VUAR(2)
		end

feature

	f alias "()" (i, j: INTEGER; t: TUPLE [BOOLEAN])
		do
		end

end
