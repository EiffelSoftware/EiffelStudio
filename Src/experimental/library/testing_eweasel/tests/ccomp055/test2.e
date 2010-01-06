class
	TEST2
inherit
	TEST1
		redefine
			f
		end

create
	make

feature {NONE}

	f (v: BOOLEAN) is
		do
			io.put_boolean (not v)
			io.put_new_line
		end

end
