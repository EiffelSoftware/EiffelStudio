note
	what: "The class uses the new syntax and includes a debug instruction."

class
	A

create
	make

feature {NONE} -- Creation

	make
		do
			debug ("a")
				io.put_string ("Test: OK")
				io.put_new_line
			end
		end

end