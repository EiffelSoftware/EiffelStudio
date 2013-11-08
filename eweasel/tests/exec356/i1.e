class I1

feature

	parentheses alias "()" (a1: INTEGER)
		do
			io.put_string ("I1: ")
			io.put_integer (a1)
			io.put_new_line
		end

	this: I1
		do
			Result := Current
		end

end