class A_3_1_3

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: like Current
		do
			f (8, 9)              -- VUAR(1)
			f (1, 8, 9)           -- VUAR(2) VUAR(2)
			f (2, 3, 8, 9)        -- VUAR(1)
			f ("a", 4, "b", 8, 9) -- VUAR(1)
			t := Current                    
			t (8, 9)              -- VUAR(1)
			t (1, 8, 9)           -- VUAR(2) VUAR(2)
			t (2, 3, 8, 9)        -- VUAR(1)
			t ("a", 4, "b", 8, 9) -- VUAR(1)
		end

feature

	f alias "()" (t1: TUPLE; i: INTEGER; t2: TUPLE)
		do
		end

end
