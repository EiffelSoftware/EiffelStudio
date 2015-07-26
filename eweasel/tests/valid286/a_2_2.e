class A_2_2

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f (8)              -- VUAR(2)
			f (8, 1)           -- VUAR(2)
			f (8, 2, 3)        -- VUAR(2)
			f (8, "a", 4, "b") -- VUAR(2)
			t := Current
			t (8)              -- VUAR(2)
			t (8, 1)           -- VUAR(2)
			t (8, 2, 3)        -- VUAR(2)
			t (8, "a", 4, "b") -- VUAR(2)
		end

feature

	f alias "()" (k: INTEGER; t: TUPLE [BOOLEAN])
		do
		end

end
