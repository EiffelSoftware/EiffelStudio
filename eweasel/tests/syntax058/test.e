class
	TEST
 
create
	make
 
feature {NONE} -- Creation
 
	make is
			-- Run test.
		local
			a: A
		do
			a := {A} [["Test: OK"]]
			io.put_string (a.item)
			io.put_new_line
		end

end