class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			a: A
		do
			create a.make
			io.put_string (a.type_1.get_type.to_string)
			io.new_line
			io.put_string (a.type_2.get_type.to_string)
			io.new_line
		end

end
