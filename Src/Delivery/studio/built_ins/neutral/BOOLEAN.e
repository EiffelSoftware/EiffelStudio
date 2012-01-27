class BOOLEAN

feature -- Basic operations

	conjuncted alias "and" (other: BOOLEAN): BOOLEAN
			-- Boolean conjunction with `other'
		do
			Result := Precursor (other)
		end

	conjuncted_semistrict alias "and then" (other: BOOLEAN): BOOLEAN
			-- Boolean semi-strict conjunction with `other'
		do
			Result := Precursor (other)
		end

	implication alias "implies" (other: BOOLEAN): BOOLEAN
			-- Boolean implication of `other'
			-- (semi-strict)
		do
			Result := Precursor (other)
		end

	negated alias "not": BOOLEAN
			-- Negation
		do
			Result := Precursor
		end

	disjuncted alias "or" (other: BOOLEAN): BOOLEAN
			-- Boolean disjunction with `other'
		do
			Result := Precursor (other)
		end

	disjuncted_semistrict alias "or else" (other: BOOLEAN): BOOLEAN
			-- Boolean semi-strict disjunction with `other'
		do
			Result := Precursor (other)
		end

	disjuncted_exclusive alias "xor" (other: BOOLEAN): BOOLEAN
			-- Boolean exclusive or with `other'
		do
			Result := Precursor (other)
		end

	infix "and" (other: BOOLEAN): BOOLEAN
			-- Boolean conjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "and then" (other: BOOLEAN): BOOLEAN
			-- Boolean semi-strict conjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "implies" (other: BOOLEAN): BOOLEAN
			-- Boolean implication of `other'
			-- (semi-strict)
		do
			Result := Precursor (other)
		end

	prefix "not": BOOLEAN
			-- Negation
		do
			Result := Precursor
		end

	infix "or" (other: BOOLEAN): BOOLEAN
			-- Boolean disjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "or else" (other: BOOLEAN): BOOLEAN
			-- Boolean semi-strict disjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "xor" (other: BOOLEAN): BOOLEAN
			-- Boolean exclusive or with `other'
		do
			Result := Precursor (other)
		end

end
