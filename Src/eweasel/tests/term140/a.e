class A [G]

feature
	
	f is
		require
			g
		do
			io.put_string ("{A}.f")
			io.put_new_line
		ensure
			g
		end

	g: BOOLEAN is
		do
			io.put_string ("{A}.g")
			io.put_new_line
			Result := True
		end

end