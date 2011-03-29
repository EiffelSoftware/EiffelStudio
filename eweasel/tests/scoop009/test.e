class TEST

create
	default_create, make

feature {NONE} -- Creation

        make
		do
			f (create {separate TEST})
		end

feature -- Access

	f (t: separate TEST)
		require
			t.is_valid
		do
			io.put_integer (t.count)
			io.put_new_line
		end

	is_valid: BOOLEAN
		do
			io.put_integer (count)
			io.put_new_line
			count := count + 1
			Result := count = 2
		end

	count: INTEGER

end
