class A

create
	make

feature {NONE} -- Creation

	make
		local
			s: detachable STRING
		do
				-- "and"
			if not (Current and attached s as l) then else print (l.count) end -- VEEN
			if not (Current and attached s) then else print (s.count) end -- VUTA(2)
				-- "and then"
			if not (Current and then attached s as l) then else print (l.count) end -- VEEN
			if not (Current and then attached s) then else print (s.count) end -- VUTA(2)
				-- "implies"
			if not (Current implies not attached s as l) then print (l.count) end -- VEEN
			if not (Current implies not attached s) then print (s.count) end -- VUTA(2)
				-- "or"
			if not (Current or not attached s as l) then print (l.count) end -- VEEN
			if not (Current or not attached s) then print (s.count) end -- VUTA(2)
				-- "or else"
			if not (Current or else not attached s as l) then print (l.count) end -- VEEN
			if not (Current or else not attached s) then print (s.count) end -- VUTA(2)
		end

feature -- Basic operations

	conjuncted alias "and" (other: BOOLEAN): A
			-- Conjunction with `other'.
		do
			Result := Current
		end

	conjuncted_semistrict alias "and then" (other: BOOLEAN): A
			-- Semi-strict conjunction with `other'.
		do
			Result := Current
		end

	implication alias "implies" (other: BOOLEAN): A
			-- Implication of `other' (semi-strict).
		do
			Result := Current
		end

	negated alias "not": BOOLEAN
			-- Negation.
		do
			Result := True
		end

	disjuncted alias "or" (other: BOOLEAN): A
			-- Disjunction with `other'.
		do
			Result := Current
		end

	disjuncted_semistrict alias "or else" (other: BOOLEAN): A
			-- Semi-strict disjunction with `other'.
		do
			Result := Current
		end

	disjuncted_exclusive alias "xor" (other: BOOLEAN): A
			-- Exclusive or with `other'.
		do
			Result := Current
		end

end
