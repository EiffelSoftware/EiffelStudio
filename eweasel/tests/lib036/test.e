class TEST

create
	make

feature

	make is
		local
			l_formatter: FORMAT_DOUBLE
		do
			create l_formatter.make (10, 0)
			l_formatter.hide_trailing_zeros
			io.put_string (l_formatter.formatted (0.0))
			io.put_new_line
		end

end
