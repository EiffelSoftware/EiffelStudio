-- Representation of a table of routine pointer for the final Eiffel
-- executable of a dynamic system

class

	DYN_ROUT_TABLE

inherit

	ROUT_TABLE
		rename
			min_used as rout_min_used
		undefine
			has_one_type
		redefine
			generate, generate_type_table
		end;

	DLE_POLY_TABLE [ROUT_ENTRY]
		rename
			writer as Rout_generator
		undefine
			is_routine_table
		redefine
			generate_type_table, min_used
		select
			min_used
		end

creation

	make

feature -- Access

	min_used: INTEGER is
			-- Minimum used type id
			-- When dealing with DLE, we have to take a pessimistic
			-- approach and consider that the minimum type id is used
			-- so that we can handle cases where it is not used in the
			-- static system but is in the dynamic
		do
			if Old_eiffel_table.was_used (rout_id) then
				Result := min_type_id
			else
				Result := rout_min_used
			end
		end;

feature -- Generation

	generate (file: INDENT_FILE) is
			-- Generation of the routine table in file "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, min_id, max_id: INTEGER;
			routine_name, c_name: STRING
		do
			c_name := rout_id.table_name;
			if not Old_eiffel_table.was_used (rout_id) or else has_changed then
				min_id := min_used;
				max_id := max_used;
				from
					file.putstring ("char *(*");
					file.putstring (dynamic_prefix);
					file.putstring (c_name);
					file.putstring ("[])() = {%N");
					i := min_id;
					goto (i);
					nb := max_id
				until
					i > nb
				loop
					entry := item;
					if i = entry.type_id then
						if entry.used then
							routine_name := entry.routine_name;
							file.putstring ("(char *(*)()) ");
							file.putstring (routine_name);
							file.putchar (',');
							file.new_line;
									-- Remember external routine declaration
							Rout_declarations.add_routine
								(entry.type.c_type, clone (routine_name))
						else
							file.putstring ("(char *(*)()) 0,%N")
						end;
						forth
					else
						file.putstring ("(char *(*)()) 0,%N")
					end;
					i := i + 1
				end;
				file.putstring ("};%N");
				if not Old_eiffel_table.was_used (rout_id) then
					file.putstring ("char *(**");
					file.putstring (c_name);
					file.putstring (")() = ");
					file.putstring (dynamic_prefix);
					file.putstring (c_name);
					file.putstring (";%N")
				else
					Rout_declarations.add_dle_table (c_name);
					Rout_declarations.add_routine_table (c_name)
				end;
				file.new_line
			end
		end;
	
	generate_type_table (file: INDENT_FILE) is
			-- Generate the associated type table in final mode.
		local
			i, nb: INTEGER;
			entry: ENTRY;
			c_name: STRING
		do
			c_name := rout_id.type_table_name;
			if
				not (Old_eiffel_table.was_used (rout_id) and
					had_type_table) or else has_changed
			then
				file.putstring ("int16 ");
				file.putstring (dynamic_prefix);
				file.putstring (c_name);
				from
					file.putstring ("[] = {%N");
					i := min_type_id;
					goto (i);
					nb := max_type_id
				until
					i > nb
				loop
					entry := item;
					if i = entry.type_id then
						entry := item;
						file.putint (entry.feature_type_id - 1);
						file.putchar (',');
						forth
					else
						file.putstring ("0,")
					end;
					file.new_line;
					i := i + 1
				end;
				file.putstring ("};%N")
			end;
			if Old_eiffel_table.was_used (rout_id) and had_type_table then
				if has_changed then
					Rout_declarations.add_dle_table (c_name);
					Rout_declarations.add_type_table (c_name)
				end
			else
				file.putstring ("int16 *");
				file.putstring (c_name);
				file.putstring (" = ");
				file.putstring (dynamic_prefix);
				file.putstring (c_name);
				file.putstring (";%N")
			end;
			file.new_line
		end;

invariant

	dynamic_system: System.is_dynamic

end -- class DYN_ROUT_TABLE
