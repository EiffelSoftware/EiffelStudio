-- Representation of a table of routine pointer for the final Eiffel
-- executable of an extendible system

class

	STAT_ROUT_TABLE

inherit

	ROUT_TABLE
		undefine
			min_used, has_one_type
		redefine
			generate, generate_type_table, is_polymorphic
		end;

	DLE_POLY_TABLE [ROUT_ENTRY]
		rename
			writer as Rout_generator
		undefine
			is_routine_table
		redefine
			generate_type_table, is_polymorphic
		end

creation

	make

feature -- Status report

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id?
			-- Check first if there is a `dynamic' declaration in the Ace
			-- file for that feature.
		local
			pos: INTEGER;
			first_body_id: BODY_ID;
			second_type_id: INTEGER;
			entry: ROUT_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C;
			found: BOOLEAN;
			is_deferred: BOOLEAN
		do
			cl_type := System.class_type_of_id (type_id);
			first_class := cl_type.associated_class;
			if first_class.dle_is_polymorphic (rout_id) then
					-- There is a `dynamic' declaration in the Ace
					-- file for that feature.
				Result := true
			else
				pos := index;
					-- If it is not a poofter finalization
					-- we have a quicker algorithm handy.
				if not System.poofter_finalization then
						-- Go to the entry of type id greater or equal than
						-- `type_id': note than deferred feature have no
						-- entries in the tables.
					goto_used (type_id)
				else
					start
				end;
				from
					is_deferred := true
				until
					after or else Result
				loop
					entry := item;
					second_type_id := entry.type_id;
					if second_type_id = type_id then
						is_deferred := false
					end;
					cl_type := System.class_type_of_id (second_type_id);
					if cl_type.associated_class.conform_to (first_class) then
						if entry.used then
							if found then
								Result := not equal (entry.body_id, first_body_id)
							else
								found := true;
								first_body_id := entry.body_id
							end
						end
					end;
					forth
				end;
				if not Result then
					Result := is_deferred and found
				end;
				if not Result then
						-- Keep track of this statically bound call
					System.dle_static_calls.mark_static (rout_id, type_id)
				end;
				go_i_th (pos)
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
			min_id := min_used;
			max_id := max_used;
			from
				file.putstring ("char *(*");
				file.putstring (static_prefix);
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
						file.putstring ("(fnptr) 0,%N")
					end;
					forth
				else
					file.putstring ("(fnptr) 0,%N")
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

	generate_type_table (file: INDENT_FILE) is
			-- Generate the associated type table in final mode.
		local
			i, nb: INTEGER;
			entry: ENTRY;
			c_name: STRING
		do
			file.putstring ("int16 ");
			c_name := rout_id.type_table_name;
			file.putstring (static_prefix);
			file.putstring (c_name)
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
			file.putstring ("int16 *");
			file.putstring (c_name);
			file.putstring (" = ");
			file.putstring (static_prefix);
			file.putstring (c_name);
			file.putstring (";%N%N")
		end;

invariant

	extendible_system: System.extendible

end -- class STAT_ROUT_TABLE
