
class TEST
create
	make
feature
	make
		do 
		   create x
		   print (boolean_valid (x)); io.new_line
		   print (integer_value (x)); io.new_line
		   print (real_value (x)); io.new_line
		   print (double_value (x)); io.new_line
		   print (character_value (x)); io.new_line
		end

	boolean_valid (a: separate TEST1): BOOLEAN
		do
			Result := a.boolean_value
		end

	integer_value (a: separate TEST1): INTEGER
		do
			Result := a.integer_value
		end

	real_value (a: separate TEST1): REAL
		do
			Result := a.real_value
		end

	double_value (a: separate TEST1): DOUBLE
		do
			Result := a.double_value
		end

	character_value (a: separate TEST1): CHARACTER
		do
			Result := a.character_value
		end

	x: separate TEST1

end
