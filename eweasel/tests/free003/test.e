class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			s: STRING
		do
				-- Instance free calls to a do-function.
			s := {A}.item_do
			s.append_integer (1)
			io.put_string (s)
			io.put_new_line
			s := {A}.item_do
			s.append_integer (2)
			io.put_string (s)
			io.put_new_line
				-- Instance free calls to a once-function.
			s := {A}.item_once
			s.append_integer (1)
			io.put_string (s)
			io.put_new_line
			s := {A}.item_once
			s.append_integer (2)
			io.put_string (s)
			io.put_new_line
				-- Instance free calls to a do-procedure.
			{A}.put_do ("put_do1")
			{A}.put_do ("put_do2")
				-- Instance free calls to a once-procedure.
			{A}.put_once ("put_once1")
			{A}.put_once ("put_once2")
		end

end