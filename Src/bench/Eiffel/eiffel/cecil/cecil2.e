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
			copy, is_equal
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
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
			Precursor {CECIL_TABLE} (hash_size)
		end

	generate is
			-- Table generation
		local
			i: INTEGER
			a_class: CLASS_C
			local_values: like values
			buffer: GENERATION_BUFFER
		do
			buffer := generation_buffer
			generate_keys (buffer)

			buffer.putstring ("static uint32 type_val[] = {%N")
			from
				local_values := values
				i := lower
			until
				i > upper
			loop
				a_class := local_values.item (i)
				if a_class = Void then
					buffer.putstring ("(uint32) 0")
				else
					a_class.generate_cecil_value
				end
				buffer.putstring (",%N"); 
				i := i + 1
			end
			buffer.putstring ("};%N%N")
			
			buffer.putstring ("struct ctable egc_ce_type_init = {(int32) ")
			buffer.putint (count)
			buffer.putstring (", sizeof(uint32),")
			buffer.putstring (key_name)
			buffer.putstring (", (char *) type_val};%N%N")
			
			wipe_out
		end

	generate_keys (buffer: GENERATION_BUFFER) is
			-- Table keys generation
		local
			i: INTEGER
			cl_name: STRING
			local_copy: like Current
		do
			buffer.putstring ("static char *")
			buffer.putstring (key_name)
			buffer.putstring ("[] = {%N")
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				cl_name := local_copy.array_item (i)
				if cl_name = Void then
					buffer.putstring ("(char *) 0")
				else
					buffer.putchar ('"')
					buffer.putstring (cl_name)
					buffer.putchar ('"')
				end
				buffer.putstring (",%N")
				i := i + 1
			end
			buffer.putstring ("};%N%N")
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
			local_values: like values
		do
			ba.append_short_integer (upper - lower + 1)
			make_key_byte_code (ba)
			from
				local_values := values
				i := lower
			until
				i > upper
			loop
				a_class := local_values.item (i)
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
			local_copy: like Current
		do
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				cl_name := local_copy.array_item (i)
				if cl_name = Void then
					ba.append_short_integer (0)
				else
					ba.append_string (cl_name)
				end
				i := i + 1
			end
		end

end
