class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			a: A [TUPLE]
			ab: A [TUPLE [BOOLEAN]]
			aib: A [TUPLE [INTEGER, BOOLEAN]]
			acib: A [TUPLE [CHARACTER, INTEGER, BOOLEAN]]
		do
			create a
			create ab
			create aib
			create acib
			a.f ([])
			a.f ()
			a ([])
			-- a () -- Not supported
			a.f ([True])
			a.f (True)
			a ([True])
			a (True)
			a.f ([8, False])
			a.f (8, False)
			a ([8, False])
			a (8, False)
			a.f (['w', 3, True])
			a.f ('w', 3, True)
			a (['w', 3, True])
			a ('w', 3, True)
		end

end
