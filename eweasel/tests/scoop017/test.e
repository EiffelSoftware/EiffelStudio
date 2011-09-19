class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do 
		   create x
		   io.put_boolean   (boolean_value   (x)); io.new_line
		   io.put_integer   (integer_value   (x)); io.new_line
		   io.put_real      (real_value      (x)); io.new_line
		   io.put_double    (double_value    (x)); io.new_line
		   io.put_character (character_value (x)); io.new_line
		   io.put_string    (string_value    (x)); io.new_line
		end

feature {NONE} -- Tests

	boolean_value (a: separate TEST1): BOOLEAN
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

	string_value (a: separate TEST1): STRING
		do
			Result := import_string (a.string_value)
		end

	x: separate TEST1

feature {NONE} -- Duplication

	import_string (s: separate STRING): STRING
		local
			i: INTEGER
		do
			from
				create Result.make_empty
			until
				i >= s.count
			loop
				i := i + 1
				Result.extend (s.item (i))
			end
		end

end
