class
	TEST

inherit
	ARGUMENTS

create
	make

feature

	make is
		local
			d: DATE_TIME
			i, nb: INTEGER
		do
			from
				nb := 60 * 60 * 24 * 365
				i := -nb
			until
				i >= nb
			loop
				create d.make_from_epoch (i)
				io.put_string (d.out)
				io.put_new_line
				i := i + 254321
			end
		end

end
