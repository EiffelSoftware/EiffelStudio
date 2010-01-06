expanded class E

inherit
	A

feature

	e: INTEGER assign set_e

	set_e (value: like e) is
		do
			e := value
			io.put_string ("Set e=")
			io.put_integer (value)
			io.put_new_line
		end

end