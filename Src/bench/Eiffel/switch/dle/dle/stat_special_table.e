-- Extendible system's special routine tables: dispose routine table and
-- initialization routine table

class STAT_SPECIAL_TABLE

inherit

	SPECIAL_TABLE
		undefine
			min_used, is_polymorphic, has_one_type, generate_type_table
		redefine
			generate
		end;

	STAT_ROUT_TABLE
		undefine
			final_table_size, generable
		redefine
			generate
		end

creation

	make

feature -- Generation

	generate (file: INDENT_FILE) is
			-- Generation of the routine table in file "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, max_id: INTEGER;
			r_name, c_name: STRING
		do
			c_name := rout_id.table_name;
			max_id := final_table_size;
			from
				file.putstring ("char *(*");
				file.putstring (static_prefix);
				file.putstring (c_name);
				file.putstring ("[])() = {%N");
				i := 1;
				goto (i);
				nb := max_id
			until
				i > nb
			loop
				if not after and then i = item.type_id then
					entry := item;
					r_name := entry.routine_name;
					file.putstring ("(char *(*)()) ");
					file.putstring (r_name);
					file.putchar (',');
					file.new_line;
					forth;

						-- Remember external declaration
					Rout_declarations.add_routine (void_type, clone (r_name))
				else
					file.putstring ("(char *(*)()) 0,%N")
				end;
				i := i + 1
			end;
			file.putstring ("};%N");
			file.putstring ("char *(**");
			file.putstring (c_name);
			file.putstring (")() = ");
			file.putstring (static_prefix);
			file.putstring (c_name);
			file.putstring (";%N%N")
		end;

end -- class STAT_SPECIAL_TABLE
