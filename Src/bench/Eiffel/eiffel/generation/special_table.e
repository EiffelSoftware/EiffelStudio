-- Special routine table: dispose routine table and initialization
-- routine table

class SPECIAL_TABLE

inherit

	ROUT_TABLE
		redefine
			generate, final_table_size, generable
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

	generate (file: INDENT_FILE) is
			-- Generation of the routine table in file "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, min_id, max_id: INTEGER;
			r_name, c_name: STRING;
		do
			c_name := rout_id.table_name;
			min_id := 1;
			max_id := final_table_size;
			if System.has_separate then
				file.putstring ("extern void sep_obj_dispose(char *);%N");
			end;
			from
				file.putstring ("char *(*");
				file.putstring (c_name);
				file.putstring ("[])() = {%N");
				i := min_id;
				goto_used (i);
				nb := max_id;
			until
				i > nb
			loop
				if (not after) and then i = item.type_id then
					entry := item;
					r_name := entry.routine_name;
					file.putstring ("(char *(*)()) ");
					file.putstring (r_name);
					file.putchar (',');
					file.new_line;
					forth;
	
						-- Remember external declaration
					Extern_declarations.add_routine (void_type, clone (r_name));
				else
					file.putstring ("(char *(*)()) 0,%N");
				end;
				i := i + 1;
			end;
			if System.has_separate then
				file.putstring ("(char *(*)()) sep_obj_dispose%N");
			end;
			file.putstring ("};%N%N");

		end;

	generable: BOOLEAN is
			-- Is the current table generable ?
		require else
			True
		do
			Result := True;
		end;

	void_type: VOID_I is
			-- Void universal type
		once
			!!Result
		end;

end
