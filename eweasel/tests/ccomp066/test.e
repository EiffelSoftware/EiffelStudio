class
	TEST

create
	make

feature

	make is
		local
			a: DYNAMIC_DOUBLE_EXPRESSION
			b: DYNAMIC_EXPRESSION [ANY]
			l_any: ANY
		do
			create a
			b := a
			l_any := b.at (Void)
		end

end
