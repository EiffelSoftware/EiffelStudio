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

	SHARED_GENERATOR
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_BODY_ID
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_DECLARATIONS
		undefine
			setup, consistent, copy, is_equal
		end

feature 

	is_routine_table: BOOLEAN is True;
			-- Is the table a routine table ?

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			first_body_id: BODY_ID;
			second_type_id: INTEGER;
			entry, first_entry: ROUT_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C;
			found, is_deferred, same_type_id: BOOLEAN;
			i, nb, old_position: INTEGER
			local_copy: ROUT_TABLE
			save_value: BOOLEAN
			system_i: SYSTEM_I
		do
			old_position := position
			system_i := System

				-- If it is not a poofter finalization
				-- we have a quicker algorithm handy.
			if not system_i.poofter_finalization then
					-- Go to the entry of type id greater or equal than `type_id':
					-- note than deferred feature have no entries in the tables
				goto_used (type_id);
				i := position

				local_copy := Current
				first_entry := local_copy.array_item (i)

					-- Check if we are currently looking at a deferred feature
				same_type_id := first_entry.type_id = type_id
				if same_type_id and then first_entry.is_set then
						-- If current feature corresponding to `type_id' is
						-- not deferred, we can retrieve the previously computed
						-- value.
					Result := first_entry.is_polymorphic
				else
						-- We never compute the value for this entry, so we need to do it
					from
						nb := max_position
						is_deferred := True;
						cl_type := system_i.class_type_of_id (type_id);
						first_class := cl_type.associated_class;
					until
						Result or else i > nb
					loop
						entry := local_copy.array_item (i);
						second_type_id := entry.type_id;
						if second_type_id = type_id then
							is_deferred := False
						end;
						cl_type := system_i.class_type_of_id (second_type_id);
						if cl_type.associated_class.simple_conform_to (first_class) then
							if entry.used then
								if found then
									Result := not equal (entry.body_id, first_body_id)
								else
									found := True;
									first_body_id := entry.body_id;
								end;
							end;
						end;
						i := i + 1
					end;
	
					if not Result then
						Result := is_deferred and then found
					end;

						-- Memorize the value in `first_entry' if it is not a deferred
						-- feature, since this kind of call needs to be recomputed each
						-- time (it depends from where we are calling it).
					if same_type_id then
						first_entry.set_polymorphic (Result)
					end
				end
			else
					-- Not a Poofter finalization (still use the old mechanism)
				from
					i := lower
					nb := max_position
					local_copy := Current
					is_deferred := True;
					cl_type := system_i.class_type_of_id (type_id);
					first_class := cl_type.associated_class;
				until
					Result or else i > nb
				loop
					entry := local_copy.array_item (i);
					second_type_id := entry.type_id;
					if second_type_id = type_id then
						is_deferred := False
					end;
					cl_type := system_i.class_type_of_id (second_type_id);
					if cl_type.associated_class.simple_conform_to (first_class) then
						if entry.used then
							if found then
								Result := not equal (entry.body_id, first_body_id)
							else
								found := True;
								first_body_id := entry.body_id;
							end;
						end;
					end;
					i := i + 1
				end;
	
				if not Result then
					Result := is_deferred and then found
				end;
			end

			position := old_position
		end;

	generate (file: INDENT_FILE) is
			-- Generation of the routine table in file "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, index: INTEGER;
			routine_name: STRING;
			empty_function_ptr_string: STRING
			function_ptr_cast_string: STRING
			local_copy: ROUT_TABLE
		do
			from
				empty_function_ptr_string := "(char *(*)()) 0,%N"
				function_ptr_cast_string := "(char *(*)()) "
				file.putstring ("char *(*");
				file.putstring (rout_id.table_name);
				file.putstring ("[])() = {%N");
				local_copy := Current
				i := min_used;
				nb := max_used;
				goto_used (i);
				index := position
			until
				i > nb
			loop
				entry := local_copy.array_item (index);
				if i = entry.type_id then
					if entry.used then
						routine_name := entry.routine_name;
						file.putstring (function_ptr_cast_string);
						file.putstring (routine_name);
						file.putstring (",%N");
			
							-- Remember external routine declaration
						Extern_declarations.add_routine (entry.type.c_type, clone (routine_name));
					else
						file.putstring (empty_function_ptr_string);
					end;
					index := index + 1
				else
					file.putstring (empty_function_ptr_string);
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
			if position <= max_position then
				Result := item.routine_name
			else
				Result := "((void (*)()) RTNR)"
			end;
		end;

	is_implemented (type_id: INTEGER): BOOLEAN is
			-- Is the feature implemented
			-- in a static type greater than `type_id'.
		do
			goto_used (type_id);
			Result := position <= max_position 
		end

	workbench_c_type: STRING is "struct ca_info";
			-- Associated C item structure name

end
