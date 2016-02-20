class
	B
create
	from_a

convert
	to_a: {A},
	from_a ({A})

feature

	to_a: A
		do
			create Result
		end

	from_a (a_a: A)
		local
			a: A
			b: B
		do
			a := a + b
		end

	infix "+" (b: B): B
		do
			Result := b
		end

end
