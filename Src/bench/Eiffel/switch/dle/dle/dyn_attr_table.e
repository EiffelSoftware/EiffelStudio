-- Representation of a table of attribute offsets for the final Eiffel
-- executable of a dynamic system

class

	DYN_ATTR_TABLE

inherit

	ATTR_TABLE
		rename
			min_used as attr_min_used
		undefine
			has_one_type
		redefine
			generate, generate_type_table
		end;

	DLE_POLY_TABLE [ATTR_ENTRY]
		rename
			writer as Attr_generator
		undefine
			is_attribute_table, generable, final_table_size
		redefine
			generate_type_table, min_used
		select
			min_used
		end;

	SHARED_DECLARATIONS

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
				Result := attr_min_used
			end
		end;

feature -- Generation

	generate (file: INDENT_FILE) is
			-- Generation of the attribute table in file "eattr*.x".
		local
			class_type: CLASS_TYPE;
			i, nb, min_val, max_val: INTEGER;
			c_name: STRING;
			p_name: STRING
		do
			c_name := clone (Encoder.table_name (rout_id));
			if not Old_eiffel_table.was_used (rout_id) or else has_changed then
				min_val := min_type_id;
				max_val := max_type_id;
				from
					file.putstring ("long ");
					file.putstring (dynamic_prefix);
					file.putstring (c_name);
					file.putstring ("[] = {%N");
					start;
					i := min_val;
					goto (i);
					nb := max_val
				until
					i > nb
				loop
					if i = item.type_id then
						class_type := System.class_type_of_id (item.type_id);
						class_type.skeleton.generate_offset
								(file, item.feature_id);
						file.putchar (',');
						file.new_line;
						forth
					else
						file.putstring ("0,%N")
					end;
					i := i + 1
				end;
				file.putstring ("};%N");
				if not Old_eiffel_table.was_used (rout_id) then
					file.putstring ("long *");
					file.putstring (c_name);
					file.putstring (" = ");
					file.putstring (dynamic_prefix);
					file.putstring (c_name);
					file.putstring (";%N")
				else
					Attr_declarations.add_dle_table (c_name);
					Attr_declarations.add_attribute_table (c_name)
				end;
				file.new_line
			end
		end;

	generate_type_table (file: INDENT_FILE; final_mode: BOOLEAN) is
			-- Generate the associated type table.
		local
			i, nb: INTEGER;
			entry: ENTRY;
			c_name: STRING;
			do_it: BOOLEAN
		do
			if final_mode then
				c_name := clone (Encoder.type_table_name (rout_id));
				if
					not (Old_eiffel_table.was_used (rout_id) and
						had_type_table) or else has_changed
				then
					file.putstring ("int16 ");
					file.putstring (dynamic_prefix);
					file.putstring (c_name);
					do_it := true
				end
			else
				file.putstring ("int16 ");
				file.putchar ('t');
				file.putint (rout_id);
				do_it := true
			end;
			if do_it then
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
						file.putstring ("0,");
					end;
					file.new_line;
					i := i + 1
				end;
				file.putstring ("};%N")
			end;
			if final_mode then
				if Old_eiffel_table.was_used (rout_id) and had_type_table then
					if has_changed then
						Attr_declarations.add_dle_table (c_name);
						Attr_declarations.add_type_table (c_name)
					end
				else
					file.putstring ("int16 *");
					file.putstring (c_name);
					file.putstring (" = ");
					file.putstring (dynamic_prefix);
					file.putstring (c_name);
					file.putstring (";%N")
				end
			end;
			file.new_line
		end;

invariant

	dynamic_system: System.is_dynamic

end -- class DYN_ATTR_TABLE
