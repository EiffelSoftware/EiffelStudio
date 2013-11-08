class E1

feature

	parentheses alias "()" (a1: INTEGER): STRING
		do
			Result := "E1: " + a1.out
		end

	this: E1
		do
			Result := Current
		end

end