class B

inherit
	A
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			Precursor
			o.put_string ("Test 2: OK")
			o.put_new_line
		end

end