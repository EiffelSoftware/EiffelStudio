-- Special routine table: dispose routine table and initialization
-- routine table

class SPECIAL_TABLE

inherit
	ROUT_TABLE
		redefine
			generate, final_table_size
		end

creation
	make

feature

	final_table_size: INTEGER is
			-- Table size
		require else
			True
		do
			Result := System.type_id_counter.value;
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the routine table in buffer "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, index: INTEGER;
			r_name: STRING;
			empty_function_ptr_string: STRING
			function_ptr_cast_string: STRING
			exists: BOOLEAN
			local_copy: like Current
		do
			empty_function_ptr_string := "(char *(*)()) 0,%N"
			function_ptr_cast_string := "(char *(*)()) "

			if System.has_separate then
				buffer.putstring ("extern void sep_obj_dispose(char *);%N");
			end;

			from
				buffer.putstring ("char *(*");
				buffer.putstring (Encoder.table_name (rout_id));
				buffer.putstring ("[])() = {%N");
				i := 1;
				nb := final_table_size;
				exists := max_position /= 0
				if exists then
					goto_used (i);
					index := position
				end
				local_copy := Current
			until
				i > nb
			loop
				if exists then
					entry := local_copy.array_item (index);
					if (index <= max_position) and then i = entry.type_id then
						r_name := entry.routine_name
						buffer.putstring (function_ptr_cast_string);
						buffer.putstring (r_name);
						buffer.putstring (",%N");
						index := index + 1;
							-- Remember external declaration
						Extern_declarations.add_routine (void_type, r_name)
					else
						buffer.putstring (empty_function_ptr_string);
					end;
				else
					buffer.putstring (empty_function_ptr_string);
				end
				i := i + 1;
			end;

			if System.has_separate then
				buffer.putstring ("(char *(*)()) sep_obj_dispose%N");
			end;
			buffer.putstring ("};%N%N");
		end;

	void_type: VOID_I is
			-- Void universal type
		once
			!!Result
		end;

feature -- Sort

	sort_till_position is
			-- Sort from `lower' to last inserted `max_position'.
		do
			if max_position > 0 then
				quick_sort (lower, max_position)
			end
		end

end
