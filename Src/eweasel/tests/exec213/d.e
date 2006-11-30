class D

inherit
	B
	C

feature

	d: INTEGER assign set_d

	set_d (value: like d) is
		do
			d := value
			io.put_string ("Set d=")
			io.put_integer (value)
			io.put_new_line
		end

end