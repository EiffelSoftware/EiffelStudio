-- Representation of a table of routine pointer for the final Eiffel
-- executable

class ROUT_TABLE

inherit

	POLY_TABLE [ROUT_ENTRY]
		rename
			writer as Rout_generator
		redefine
			is_routine_table
		end;
	SHARED_GENERATOR;
	SHARED_BODY_ID;
	SHARED_DECLARATIONS;

creation

	make
	
feature 

	is_routine_table: BOOLEAN is True;
			-- Is the table a routine table ?

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			old_cursor: CURSOR;
			first_body_id: BODY_ID;
			second_type_id: INTEGER;
			entry: ROUT_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C;
			found: BOOLEAN;
			is_deferred: BOOLEAN;
		do
			old_cursor := cursor;
				-- If it is not a poofter finalization
				-- we have a quicker algorithm handy.
			if not System.poofter_finalization then
					-- Go to the entry of type id greater or equal than `type_id':
					-- note than deferred feature have no entries in the tables
				goto_used (type_id);
			else
				start
			end;
			from
				is_deferred := True;
				cl_type := System.class_type_of_id (type_id);
				first_class := cl_type.associated_class;
			until
				after or else Result
			loop
				entry := item;
				second_type_id := entry.type_id;
				if second_type_id = type_id then
					is_deferred := False
				end;
				cl_type := System.class_type_of_id (second_type_id);
				if cl_type.associated_class.conform_to (first_class) then
					if entry.used then
						if found then
							Result := not equal (entry.body_id, first_body_id)
						else
							found := True;
							first_body_id := entry.body_id;
						end;
					end;
				end;
				forth
			end;
			if not Result then
				Result := is_deferred and then found
			end;
			go_to (old_cursor);
		end;

	generate (file: INDENT_FILE) is
			-- Generation of the routine table in file "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, min_id, max_id: INTEGER;
			routine_name, c_name: STRING;
		do
			c_name := rout_id.table_name;
			min_id := min_used;
			max_id := max_used;
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
				entry := item;
				if i = entry.type_id then
					if entry.used then
						routine_name := entry.routine_name;

						file.putstring ("(char *(*)()) ");
						file.putstring (routine_name);
						file.putchar (',');
						file.new_line;
			
							-- Remember external routine declaration
						Extern_declarations.add_routine
							(entry.type.c_type, clone (routine_name));
					else
						file.putstring ("(char *(*)()) 0,%N");
					end;
					forth;
				else
					file.putstring ("(char *(*)()) 0,%N");
				end;
				i := i + 1;
			end;
			file.putstring ("};%N%N");

		end; -- generate

	feature_name (type_id: INTEGER): STRING is
			-- Feature name of the first used feature available
			-- in a static type greater than `type_id'.
		do
			goto_used (type_id);
			if not after then
				Result := item.routine_name
			else
				Result := "((void (*)())  RTNR)"
			end;
		end;

	is_implemented (type_id: INTEGER): BOOLEAN is
			-- Is the feature implemented
			-- in a static type greater than `type_id'.
		do
			goto_used (type_id);
			Result := not after
		end

	workbench_c_type: STRING is "struct ca_info";
			-- Associated C item structure name

end
