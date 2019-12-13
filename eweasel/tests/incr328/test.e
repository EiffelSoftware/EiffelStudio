
class TEST
create
	make, default_create
feature
	
	make
		do
			create x
			io.put_integer (x.h (Current))
			io.put_new_line
		end

	f alias "@" (n: INTEGER): INTEGER
		do
			Result := 1
		end

	g alias "+" (n: INTEGER): INTEGER
		do
			Result := 2
		end

	x: TEST2 [TEST]

end
