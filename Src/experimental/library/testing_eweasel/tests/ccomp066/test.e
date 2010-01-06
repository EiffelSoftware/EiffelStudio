class
	TEST

create
	make

feature

	make is
		local
			a: DYNAMIC_DOUBLE_EXPRESSION
			b: DYNAMIC_EXPRESSION [ANY]
			x: ANY
		do
			create a
			b := a
			x := b.at (Void)
			x := b.f (Void)
		end

end
