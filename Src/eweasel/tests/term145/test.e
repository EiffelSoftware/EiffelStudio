class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			c: CRASH [STRING, STRING]
		do
			create c
			io.put_boolean (c.f (""))
			io.put_new_line
		end

end
