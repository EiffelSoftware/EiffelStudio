class A_1_1

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f               -- VUAR(2)
			f (1)           -- VUAR(2)
			f (2, 3)        -- VUAR(2)
			f ("a", 4, "b") -- VUAR(2)
			t := Current
			t (1)           -- VUAR(2)
			t (2, 3)        -- VUAR(2)
			t ("a", 4, "b") -- VUAR(2)
		end

feature

	f alias "()" (t: TUPLE [BOOLEAN])
		do
		end

end
