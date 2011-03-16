class TEST

create
	default_create, make

feature {NONE} -- Creation

        make
		do
			f (Current)
		end

feature -- Access

	f (t: TEST)
		do
			io.put_integer (t.item)
			io.put_new_line
		end

	item: INTEGER
		external "C inline"
			alias "return 5;"
		end

end
