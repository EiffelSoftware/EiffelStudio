class I2

feature

	parentheses alias "()" (a1, a2: INTEGER)
		do
			io.put_string ("I2: ")
			io.put_integer (a1)
			io.put_string (", ")
			io.put_integer (a2)
			io.put_new_line
		end

	this: I2
		do
			Result := Current
		end

end