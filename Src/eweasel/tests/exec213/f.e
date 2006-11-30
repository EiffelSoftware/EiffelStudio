expanded class F

inherit
	E

feature

	f: INTEGER assign set_f

	set_f (value: like f) is
		do
			f := value
			io.put_string ("Set f=")
			io.put_integer (value)
			io.put_new_line
		end

end