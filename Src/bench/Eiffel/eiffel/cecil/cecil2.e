-- Hash table of non generic classes

class CECIL2 

inherit

	CECIL_TABLE [CLASS_C]
		redefine
			init
		end
	BASIC_ROUTINES
		export
			{NONE} ALL
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_WORKBENCH
		undefine
			setup, consistent, copy, is_equal
		end

creation

	init
	
feature 

	init (n: INTEGER) is
			-- Initialization
		require else
			True
		local
			hash_size: INTEGER
		do
			hash_size := primes.higher_prime (bottom_int_div (5 * n, 4))
			{CECIL_TABLE} Precursor (hash_size)
		end

	generate is
			-- Table generation
		local
			i: INTEGER
			a_class: CLASS_C
		do
			generate_keys

			Cecil_file.putstring ("static uint32 type_val[] = {%N")
			from
				i := lower
			until
				i > upper
			loop
				a_class := values.item (i)
				if a_class = Void then
					Cecil_file.putstring ("(uint32) 0")
				else
					a_class.generate_cecil_value
				end
				Cecil_file.putstring (",%N"); 
				i := i + 1
			end
			Cecil_file.putstring ("};%N%N")
			
			Cecil_file.putstring ("struct ctable egc_ce_type_init = {(int32) ")
			Cecil_file.putint (count)
			Cecil_file.putstring (", sizeof(uint32),")
			Cecil_file.putstring (key_name)
			Cecil_file.putstring (", (char *) type_val};%N%N")
			
			wipe_out
		end

	generate_keys is
			-- Table keys generation
		local
			i: INTEGER
			cl_name: STRING
		do
			Cecil_file.putstring ("static char *")
			Cecil_file.putstring (key_name)
			Cecil_file.putstring ("[] = {%N")
			from
				i := lower
			until
				i > upper
			loop
				cl_name := array_item (i)
				if cl_name = Void then
					Cecil_file.putstring ("(char *) 0")
				else
					Cecil_file.putchar ('"')
					Cecil_file.putstring (cl_name)
					Cecil_file.putchar ('"')
				end
				Cecil_file.putstring (",%N")
				i := i + 1
			end
			Cecil_file.putstring ("};%N%N")
		end

	key_name: STRING is
			-- Name of static key table
		do
			Result := "type_key"
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Produce byte code for the current table.
		local
			i: INTEGER
			a_class: CLASS_C
		do
			ba.append_short_integer (upper - lower + 1)
			make_key_byte_code (ba)
			from
				i := lower
			until
				i > upper
			loop
				a_class := values.item (i)
				if a_class = Void then
					ba.append_uint32_integer (0)
				else
					ba.append_uint32_integer (a_class.cecil_value)
				end
				i := i + 1
			end
			wipe_out
		end

	make_key_byte_code (ba: BYTE_ARRAY) is
			-- Produce byte code for class name array.
		local
			i: INTEGER
			cl_name: STRING
		do
			from
				i := lower
			until
				i > upper
			loop
				cl_name := array_item (i)
				if cl_name = Void then
					ba.append_short_integer (0)
				else
					ba.append_string (cl_name)
				end
				i := i + 1
			end
		end

end
