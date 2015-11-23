class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			s: detachable STRING
		do
			(create {A}.make).do_nothing
				-- "and"
			if Current and attached s as l then print (l.count) end -- VEEN
			if Current and attached s then print (s.count) end -- VUTA(2)
				-- "and then"
			print (Current and then attached s as l and then l.count = 2) -- VEEN
			print (Current and then s /= Void and then s.count = 2) -- VUTA(2)
				-- "implies"
			if Current implies not attached s as l then else print (l.count) end -- VEEN
			if Current implies not attached s then else print (s.count) end -- VUTA(2)
				-- "or"
			if Current or not attached s as l then else print (l.count) end -- VEEN
			if Current or not attached s then else print (s.count) end -- VUTA(2)
				-- "or else"
			if Current or else not attached s as l then else print (l.count) end -- VEEN
			if Current or else not attached s then else print (s.count) end -- VUTA(2)
		end

feature -- Basic operations

	conjuncted alias "and" (other: BOOLEAN): BOOLEAN
			-- Conjunction with `other'.
		do
			Result := True
		end

	conjuncted_semistrict alias "and then" (other: BOOLEAN): BOOLEAN
			-- Semi-strict conjunction with `other'.
		do
			Result := True
		end

	implication alias "implies" (other: BOOLEAN): BOOLEAN
			-- Implication of `other' (semi-strict).
		do
			Result := True
		end

	negated alias "not": BOOLEAN
			-- Negation.
		do
			Result := True
		end

	disjuncted alias "or" (other: BOOLEAN): BOOLEAN
			-- Disjunction with `other'.
		do
			Result := True
		end

	disjuncted_semistrict alias "or else" (other: BOOLEAN): BOOLEAN
			-- Semi-strict disjunction with `other'.
		do
			Result := True
		end

	disjuncted_exclusive alias "xor" (other: BOOLEAN): BOOLEAN
			-- Exclusive or with `other'.
		do
			Result := True
		end

end
