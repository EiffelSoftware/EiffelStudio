class B

inherit
	A
	E

feature

	b: INTEGER assign set_b

	set_b (value: like b) is
		do
			b := value
			io.put_string ("Set b=")
			io.put_integer (value)
			io.put_new_line
		end

end