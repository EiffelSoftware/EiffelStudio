-- Representation of a table of attribute offsets for the final Eiffel
-- executable

class ATTR_TABLE

inherit
	POLY_TABLE [ATTR_ENTRY]
		rename
			writer as Attr_generator
		redefine
			is_attribute_table, generable, final_table_size
		end;

	SHARED_CODE_FILES
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_GENERATOR
		undefine
			setup, consistent, copy, is_equal
		end

feature

	is_attribute_table: BOOLEAN is True;
			-- Is the table an attribute offset table ?

	generable: BOOLEAN is True
			-- An offset table has to be always generated because of
			-- the C main skeleton structure.

	final_table_size: INTEGER is
			-- Table size
		do
			Result := max_type_id - min_type_id + 1;
		end;

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			current_type_id: INTEGER;
			entry, first_entry: ATTR_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C;
			i, nb, old_position: INTEGER
			local_copy: ATTR_TABLE
			system_i: SYSTEM_I
		do
			old_position := position
			system_i := System

				-- If it is not a poofter finalization
				-- we have a quicker algorithm handy.
			if not system_i.poofter_finalization then
				goto_used (type_id);
				i := position
				if i <= max_position then
					local_copy := Current
					first_entry := local_copy.array_item (i)
					if first_entry.is_set then
						Result := first_entry.is_polymorphic
					else
						from
							cl_type := system_i.class_type_of_id (type_id);
							first_class := cl_type.associated_class;
							i := i + 1
							nb := max_position
						until
							Result or else i > nb
						loop
							entry := local_copy.array_item (i)
							cl_type := system_i.class_type_of_id (entry.type_id);
							if cl_type.associated_class.simple_conform_to (first_class) then
								Result := entry.used;
							end;
							i := i + 1
						end;
						
						first_entry.set_polymorphic (Result)
					end
				end;
			else
				from
					local_copy := Current
					cl_type := system_i.class_type_of_id (type_id);
					first_class := cl_type.associated_class;
					i := lower
					nb := max_position
				until
					Result or else i > nb
				loop
					entry := local_copy.array_item (i)
					current_type_id := entry.type_id;
					if current_type_id /= type_id then
						cl_type := system_i.class_type_of_id (current_type_id);
						if cl_type.associated_class.simple_conform_to (first_class) then
							Result := entry.used
						end;
					end;
					i := i + 1
				end;
			end;
			position := old_position
		end;

	generate (file: INDENT_FILE) is
			-- Generation of the attribute table in file "eattr*.x".
		local
			class_type: CLASS_TYPE;
			i, nb, index: INTEGER;
			attr_entry: ATTR_ENTRY
			local_copy: ATTR_TABLE
		do
			from
					-- Private table
				file.putstring ("long ");
				file.putstring (rout_id.table_name);
				file.putstring ("[] = {%N");
				local_copy := Current
				i := min_type_id;
				nb := max_type_id;
				goto (i);
				index := position
			until
				i > nb
			loop
				attr_entry := local_copy.array_item (index)
				if i = attr_entry.type_id then
					class_type := System.class_type_of_id (attr_entry.type_id);
						--| In this instruction, we put `True' as second
						--| arguments. This means we will generate something if there is nothing
						--| to generate (ie `0'). Remember that `False' is used in all other case
					class_type.skeleton.generate_offset (file, attr_entry.feature_id, True);
					file.putchar (',');
					file.new_line;
					index := index + 1;
				else
					file.putstring ("0,%N");
				end;
				i := i + 1;
			end;
			file.putstring ("};%N%N");
		end;

	workbench_c_type: STRING is "long";
			-- Associated C item structure name

end
