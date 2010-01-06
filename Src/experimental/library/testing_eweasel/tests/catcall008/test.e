class TEST 
create
	make
feature

	make
			-- Run application.
		local
			p: PREDICATE [ANY, TUPLE]
			b: BOOLEAN
		do
			p := agent: BOOLEAN do print ("Passed%N") end
			
				-- The following should not be a catcall.
			b := p.item ([])
		end

end
