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
			pos: INTEGER;
		do
			pos := position;
			goto_used (type_id);
			if not after then
				from
					forth
				until
					after or else Result
				loop
					Result := item.used;
					forth
				end;
			end;
			go (pos);
		end;

	generate (file: UNIX_FILE) is
			-- Generation of the attribute table in file "_attr.c".
		local
			class_type: CLASS_TYPE;
			i, nb, min_val, max_val: INTEGER;
			c_name: STRING;
			p_name: STRING;
		do
			c_name := Encoder.table_name (rout_id);

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
					class_type.skeleton.generate_offset
												(file, item.feature_id);
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
