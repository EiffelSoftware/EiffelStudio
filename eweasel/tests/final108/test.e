
class TEST

create
	make

feature

	make
		do
			print (Current - 1.0); io.new_line
			print (Current + 2.0); io.new_line
			print (Current.value (3.0)); io.new_line
			print (Current.value2 (3.0)); io.new_line
		end

	infix "-" (n: DOUBLE): DOUBLE
		require
			show_pre (True)
		external "C inline"
		alias "2.0 * $n"
		ensure
			show_post (True)
		end
	
	value alias "+" (n: DOUBLE): DOUBLE
		require
			show_pre (True)
		external "C inline"
		alias "2.0 * $n"
		ensure
			show_post (True)
		end
	
	value2 (n: DOUBLE): DOUBLE
		require
			show_pre (True)
		external "C inline"
		alias "2.0 * $n"
		ensure
			show_post (True)
		end
	
	show_inv (b: BOOLEAN): BOOLEAN
		do
			print ("Checking invariant%N")
			Result := b
		end
	
	show_pre (b: BOOLEAN): BOOLEAN
		do
			print ("Checking precondition%N")
			Result := b
		end
	
	show_post (b: BOOLEAN): BOOLEAN
		do
			print ("Checking postcondition%N")
			Result := b
		end
invariant
	valid: show_inv (True)
end
