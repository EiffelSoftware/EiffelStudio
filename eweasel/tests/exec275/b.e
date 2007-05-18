class B

feature

	a: INTEGER

	f (x: INTEGER) is
		do
			io.put_string ("{B}.f (")
			io.put_integer (x)
			io.put_string (")")
			io.put_new_line
		end

end