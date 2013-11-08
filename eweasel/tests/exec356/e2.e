class E2

feature

	parentheses alias "()" (a1, a2: INTEGER): STRING
		do
			Result := "E2: " + a1.out + ", " + a2.out
		end

	this: E2
		do
			Result := Current
		end

end