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
			pos, first_body_id: INTEGER;
			entry: ROUT_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C;		
		do
			pos := position;
				-- Go to the entry of type id greater or equal than `type_id':
				-- note than deferred feature have no entries in the tables
			goto_used (type_id);
			if not offright then
				from
					entry := item;
					first_body_id := entry.body_id;
					cl_type := System.class_type_of_id (type_id);
					first_class := cl_type.associated_class;
					forth;
				until
					offright or else Result
				loop
					entry := item;
					cl_type := System.class_type_of_id (entry.type_id);
					if cl_type.associated_class.conform_to (first_class) then
						Result := 	entry.used
									and then
									entry.body_id /= first_body_id;
					end;
					forth
				end;
			end;
			go (pos);
		end;

	generate (file: UNIX_FILE) is
			-- Generation of the routine table in file "_rout.c".
		local
			entry: ROUT_ENTRY;
			i, nb, min_id, max_id: INTEGER;
			routine_name, c_name: STRING;
		do
			c_name := Encoder.table_name (rout_id);
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
                            (entry.type.c_type, routine_name.twin);
					else
						file.putstring ("(fnptr) 0,%N");
					end;
					forth;
				else
					file.putstring ("(fnptr) 0,%N");
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
			check
				not_off: not offright
			end;
			Result := item.routine_name
		end;

	workbench_c_type: STRING is "struct ca_info";
			-- Associated C item structure name

end
