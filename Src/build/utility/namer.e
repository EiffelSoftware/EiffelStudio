-- Persistent

class NAMER 

inherit

	SHARED_NAMER

creation

	make
	
feature 

	reset is
		do
			integer_generator.reset
		end;

	seed: STRING;
			-- Seed for name generation.

	value: STRING;
			-- String value generated
	
feature {NONE}

	integer_generator: INT_GENERATOR;
			-- Generator of unique integers

feature 

	make (a_seed: STRING) is
			-- Create the generator by setting its seed value.
		require
			not_a_void_string: not (a_seed = Void)
		do
			seed := clone (a_seed);
			value := seed;
			!!integer_generator;
			if Shared_namer_values.has (a_seed) then
				integer_generator.set (Shared_namer_values.item (a_seed));
			end;
		end; -- Create

	next is
			-- Next unique string whose prefix is `value' and
			-- suffix is the next integer
		do
			integer_generator.next;
			!!value.make (10);
			value.append (seed);
			value.append_integer (integer_generator.value);
			Shared_namer_values.force (integer_generator.value, seed)
		end; -- next

end -- NAMER 
