class A

feature

	a $SYNONYM: INTEGER assign set_a

	set_a (value: like a) is
		do
			a := value
			io.put_string ("Set a=")
			io.put_integer (value)
			io.put_new_line
		end

end