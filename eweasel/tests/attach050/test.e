
class TEST

create
	make

feature

	make is
		local
			x: TEST2
		do
			create x
			io.put_string (x.s.as_lower); io.new_line
			create x
			io.put_string (x.s.as_lower); io.new_line
		end

end
