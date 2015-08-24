class TEST

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run application.
		local
			s: separate TEST
		do
			create s
			f (s)
			separate s as t do
				t.g (twin.p)
			end
		end

feature -- Test

	f (t: separate TEST)
		do
			t.g (twin.p)
		end

	g (x: POINTER)
		do
			print (x)
			io.put_new_line
		end

	p: POINTER

end
