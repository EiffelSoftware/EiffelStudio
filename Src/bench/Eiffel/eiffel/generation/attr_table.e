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
	SHARED_CODE_FILES;
	SHARED_GENERATOR;

creation

	make

feature

	is_attribute_table: BOOLEAN is True;
			-- Is the table an attribute offset table ?

	generable: BOOLEAN is
			-- An offset table has to be always generated because og
			-- the C main skeleton structure.
		require else
			True
		do
			Result := True;
		end;

	final_table_size: INTEGER is
			-- Table size
		do
			Result := max_type_id - min_type_id + 1;
		end;

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			old_cursor: CURSOR;
			current_type_id: INTEGER;
			entry: ATTR_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C;
		do
			old_cursor := cursor;
				-- If it is not a poofter finalization
				-- we have a quicker algorithm handy.
			if not System.poofter_finalization then
				goto_used (type_id);
				if not after then
					from
						cl_type := System.class_type_of_id (type_id);
						first_class := cl_type.associated_class;
						forth
					until
						after or else Result
					loop
						entry := item;
						cl_type := System.class_type_of_id (entry.type_id);
						if cl_type.associated_class.conform_to (first_class) then
							Result := item.used;
						end;
						forth
					end;
				end;
			else
				from
					cl_type := System.class_type_of_id (type_id);
					first_class := cl_type.associated_class;
					start
				until
					after or else Result
				loop
					current_type_id := item.type_id;
					if current_type_id /= type_id then
						cl_type := System.class_type_of_id (current_type_id);
						if cl_type.associated_class.conform_to (first_class) then
							Result := item.used
						end;
					end;
					forth
				end;
			end;
			go_to (old_cursor);
		end;

	generate (file: INDENT_FILE) is
			-- Generation of the attribute table in file "eattr*.x".
		local
			class_type: CLASS_TYPE;
			i, nb, min_val, max_val: INTEGER;
			c_name: STRING;
			p_name: STRING;
		do
			c_name := rout_id.table_name;

			min_val := min_type_id;
			max_val := max_type_id;
			from
					-- Private table
				file.putstring ("long ");
				file.putstring (c_name);
				file.putstring ("[] = {%N");
				start;
				i := min_val;
				goto (i);
				nb := max_val;
			until
				i > nb
			loop
				if i = item.type_id then
					class_type := System.class_type_of_id (item.type_id);
						--| In this instruction, we put `True' as second
						--| arguments. This means we will generate something if there is nothing
						--| to generate (ie `0'). Remember that `False' is used in all other case
					class_type.skeleton.generate_offset (file, item.feature_id, True);
					file.putchar (',');
					file.new_line;
					forth;
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
