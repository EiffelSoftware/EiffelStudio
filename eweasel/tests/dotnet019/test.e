class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			d: DAY_OF_WEEK
		do
			d := {DAY_OF_WEEK}.wednesday
			io.put_integer (d.to_integer)
			io.put_integer (d.value_)
			io.put_string (d.to_string)
			io.put_string (d.out)
			io.put_string (d.get_type.out)
			d := d & {DAY_OF_WEEK}.saturday
			io.put_integer (d.value_)
			d := d | d.monday
			io.put_integer (d.value_)
			d := d.from_integer (5)
			io.put_integer (d.value_)
			io.put_new_line
		end

end
