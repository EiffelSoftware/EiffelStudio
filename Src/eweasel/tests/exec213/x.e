class X

feature

	x: INTEGER

	set_x (value: like x) is
		do
			x := value
			io.put_string ("Set x=")
			io.put_integer (value)
			io.put_new_line
		end

end