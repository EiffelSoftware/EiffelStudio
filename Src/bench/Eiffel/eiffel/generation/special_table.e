-- Special routine table: dispose routine table and initialization
-- routine table

class SPECIAL_TABLE

inherit
	ROUT_TABLE
		redefine
			generate, final_table_size, generable
		end

feature

	final_table_size: INTEGER is
			-- Table size
		require else
			True
		do
			Result := System.type_id_counter.value;
		end;

	generate (file: INDENT_FILE) is
			-- Generation of the routine table in file "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, index: INTEGER;
			r_name: STRING;
			empty_function_ptr_string: STRING
			function_ptr_cast_string: STRING
			exists: BOOLEAN
		do
			empty_function_ptr_string := "(char *(*)()) 0,%N"
			function_ptr_cast_string := "(char *(*)()) "

			if System.has_separate then
				file.putstring ("extern void sep_obj_dispose(char *);%N");
			end;

			from
				file.putstring ("char *(*");
				file.putstring (rout_id.table_name);
				file.putstring ("[])() = {%N");
				i := 1;
				nb := final_table_size;
				exists := upper /= 0
				if exists then
					goto_used (i);
					index := position
				end
			until
				i > nb
			loop
				if exists then
					entry := array_item (index);
					if (index <= upper) and then i = entry.type_id then
						r_name := entry.routine_name;
						file.putstring (function_ptr_cast_string);
						file.putstring (r_name);
						file.putstring (",%N");
						index := index + 1;
							-- Remember external declaration
						Extern_declarations.add_routine (void_type, clone (r_name));
					else
						file.putstring (empty_function_ptr_string);
					end;
				else
					file.putstring (empty_function_ptr_string);
				end
				i := i + 1;
			end;

			if System.has_separate then
				file.putstring ("(char *(*)()) sep_obj_dispose%N");
			end;
			file.putstring ("};%N%N");
		end;

	generable: BOOLEAN is True
			-- Is the current table generable ?

	void_type: VOID_I is
			-- Void universal type
		once
			!!Result
		end;

feature -- Sort

	sort_till_position is
			-- Sort from `lower' to last inserted `position'.
		do
			upper := position - 1
			area := arycpy ($area, upper, 0, upper)
			if upper /= 0 then
				quick_sort (lower, position - 1)
			end
		end

end
