-- Persistent

class NAMER 

inherit

	SHARED_NAMER

creation

	make
	
feature 

	reset is
		do
			integer_value := 0;
			Shared_namer_values.force (integer_value, seed)
		end;

	value: STRING;
			-- String value generated
	
feature {NONE}

	seed: STRING;
			-- Seed for name generation.

	integer_value: INTEGER;
			-- Generated integer value

	make (a_seed: STRING) is
			-- Create the generator by setting its seed value.
		require
			not_a_void_string: not (a_seed = Void)
		do
			seed := clone (a_seed);
			value := seed;
		end;

feature

	next is
			-- Next unique string whose prefix is `value' and
			-- suffix is the next integer
		do
			integer_value := Shared_namer_values.item (seed);
			integer_value := integer_value + 1;
			!!value.make (10);
			value.append (seed);
			value.append_integer (integer_value);
			Shared_namer_values.force (integer_value, seed)
		end; -- next

end -- NAMER 
