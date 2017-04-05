class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		do
			message := "Failed"
			is_ok (Current).do_nothing
			io.put_string (message)
			io.put_new_line
		end

feature {NONE} -- Accesss

	message: STRING
			-- A message to be reported.

feature {NONE} -- Status report

	is_ok (x: separate TEST): BOOLEAN
			-- Make a recursive call to the query in the precondition.
		require
			is_message_updated
			is_ok (x)
		do
			Result := True
		end

	is_message_updated: BOOLEAN
			-- Update `message` and return `True`.
		do
			message := "OK"
			Result := True
		end

end