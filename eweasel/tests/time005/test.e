class
	TEST

create
	make

feature

	make is
		local
			d: DATE
		do
			create d.make_by_days ({INTEGER}.min_value)
		end

	assert (b: BOOLEAN)
		do
			if not b then
				io.put_string ("Not OK!%N")
			end
		end

end
