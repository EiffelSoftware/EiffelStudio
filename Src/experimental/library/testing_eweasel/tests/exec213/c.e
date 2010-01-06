class C

inherit
	X
	A

feature

	c: INTEGER assign set_c

	set_c (value: like c) is
		do
			c := value
			io.put_string ("Set c=")
			io.put_integer (value)
			io.put_new_line
		end

end