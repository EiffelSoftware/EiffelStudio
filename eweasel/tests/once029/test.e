class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			d1, d2: separate DIRECTION
		do
			create d1.up
			create d2.up
			io.put_boolean (d1 = d2); io.put_new_line -- True iff once_key = PROCESS
			create {separate DIRECTION} d1.up
			io.put_boolean (d1 = d2); io.put_new_line -- True iff once_key = PROCESS
			create <NONE> d1.up
			io.put_boolean (d1 = d2); io.put_new_line -- True iff once_key = PROCESS
			io.put_boolean (create {separate DIRECTION}.up = d2); io.put_new_line -- True iff once_key = PROCESS
			io.put_boolean (create <NONE> {separate DIRECTION}.up = d2); io.put_new_line -- True iff once_key = PROCESS
			create <NONE> d2.up
			io.put_boolean (d1 = d2); io.put_new_line -- True iff once_key = PROCESS
			io.put_boolean (create {separate DIRECTION}.up = d2); io.put_new_line -- True iff once_key = PROCESS
			io.put_boolean (create <NONE> {separate DIRECTION}.up = d2); io.put_new_line -- True iff once_key = PROCESS
		end

end
