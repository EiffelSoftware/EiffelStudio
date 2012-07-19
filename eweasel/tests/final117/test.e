class TEST

create
	make

feature

	make
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = integer_constant
			loop
				i := i + 1
			end
		end

	integer_constant: NATURAL_32 = 100
end
