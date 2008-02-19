class A [G]

feature

	f (x: LINKED_LIST [G]) is
		require
			is_valid: is_valid (x)
		local
			l_exp: EXP1
		do
			my_attr := x
			my_exp := l_exp
		end

	my_attr: LINKED_LIST [G]
	my_exp: EXP1

	is_valid (x: like my_attr): BOOLEAN is
		do
			Result := x /= Void
		end

end
