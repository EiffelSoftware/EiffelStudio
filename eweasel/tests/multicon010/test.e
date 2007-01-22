
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class 
		TEST[G -> {COMPARABLE rename default_create as comparables_default_create end, NUMERIC rename is_equal as numerics_is_equal, generating_type as numerics_generating_type end} create default_create end]

creation	
	make

feature -- Initialization

	make
		local
			procedure: PROCEDURE[ANY,TUPLE[G]]
			function: FUNCTION[ANY,TUPLE[G],G]
			query: FUNCTION[ANY,TUPLE,G]
			predicate: PREDICATE[ANY,TUPLE]
			l_g: G
		do
			create l_g.default_create
			l_g := (l_g.one + l_g.one)*(l_g.one + l_g.one + l_g.one)*((l_g.one + l_g.one)*(l_g.one + l_g.one + l_g.one) + l_g.one)
			procedure := agent (a_g: G) do set_g (a_g) end
			function := agent (a_g: G): G do Result := doubled (a_g) end
			query := agent g
			predicate := agent (a_g1, a_g2: G): BOOLEAN do Result := equivalent (a_g1,a_g2) end (l_g, ?)
			procedure.call ([l_g])
			print (function.item ([query.item ([])]))
			print ("%N")
			print (predicate.item ([l_g]))
			print ("%N")
			print (l_g.generating_type)
			print ("%N")

		end

feature -- For testing

	set_g (a_g: G)
			-- Set g to `a_g'
		require
			a_g_not_void: a_g /= Void
		do
			g := a_g
		ensure
			a_g_set: a_g = g
		end

	g: G
		-- Field for testing	

	equivalent(a_g1,a_g2: G): BOOLEAN
		require
			a_g1_not_void: a_g1 /= Void
			a_g2_not_void: a_g2 /= Void
		do
			Result := a_g1.is_equal (a_g2)
		ensure
			bb_or_not_2b: Result or not Result --?
		end

	doubled (a_g: G): G
		require
			a_g_not_void: a_g /= Void
		do
			Result := a_g * (a_g.one + a_g.one)
		ensure
			doubled: Result = (a_g.one + a_g.one) * a_g
		end
end
