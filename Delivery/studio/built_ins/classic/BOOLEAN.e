class BOOLEAN

feature -- Basic operations

	infix "and" (other: like Current): BOOLEAN is
			-- Boolean conjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "and then" (other: like Current): BOOLEAN is
			-- Boolean semi-strict conjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "implies" (other: like Current): BOOLEAN is
			-- Boolean implication of `other'
			-- (semi-strict)
		do
			Result := Precursor (other)
		end

	prefix "not": like Current is
			-- Negation
		do
			Result := Precursor
		end

	infix "or" (other: like Current): BOOLEAN is
			-- Boolean disjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "or else" (other: like Current): BOOLEAN is
			-- Boolean semi-strict disjunction with `other'
		do
			Result := Precursor (other)
		end

	infix "xor" (other: like Current): BOOLEAN is
			-- Boolean exclusive or with `other'
		do
			Result := Precursor (other)
		end

end
