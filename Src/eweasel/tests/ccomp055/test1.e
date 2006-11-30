class
	TEST1

create
	make

feature

	make is
		do
			(agent f (False)).call (Void)
			(agent f (True)).call (Void)
		end

feature {NONE}

	f (v: BOOLEAN) is
		do
			io.put_boolean (v)
			io.put_new_line
		end

end
