class TEST

create
	default_create, make

feature {NONE} -- Creation

        make
		do
			f (Current)
			f (create {separate TEST})
		end

feature -- Access

	f (t: separate TEST)
		do
			io.put_integer (t.item)
			io.put_new_line
		end

	item: INTEGER
		external "C inline"
			alias "return 5;"
		end

end
