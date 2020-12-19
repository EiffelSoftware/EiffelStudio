class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			direction: DIRECTION
		do
			create direction.up
			io.put_string (f (create {DIRECTION}.up)); io.put_new_line -- "Up"
			io.put_string (f ({DIRECTION}.down)); io.put_new_line -- "Down"
			io.put_boolean (direction = {DIRECTION}.up); io.put_new_line -- "True"
			io.put_boolean (direction = {DIRECTION}.down); io.put_new_line -- "False"
			io.put_integer ({DIRECTION}.left.x_scroll); io.put_new_line -- "-1"
			{DIRECTION}.left.x_scroll := -4
			io.put_integer ({DIRECTION}.left.x_scroll); io.put_new_line -- "-4"
		end

feature {NONE} -- Tests

	f (d: DIRECTION): STRING
		do
			Result :=
				inspect d
				when {DIRECTION}.down then "Down"
				when {DIRECTION}.left then "Left"
				when {DIRECTION}.right then "Right"
				when {DIRECTION}.up then "Up"
				end
		end

end
