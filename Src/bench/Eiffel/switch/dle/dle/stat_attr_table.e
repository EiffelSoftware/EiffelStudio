-- Representation of a table of attribute offsets for the final Eiffel
-- executable of an extendible system

class

	STAT_ATTR_TABLE

inherit

	ATTR_TABLE
		undefine
			min_used, is_polymorphic, has_one_type
		redefine
			generate, generate_type_table, is_polymorphic
		end;

	DLE_POLY_TABLE [ATTR_ENTRY]
		rename
			writer as Attr_generator
		undefine
			is_attribute_table, generable, final_table_size
		redefine
			generate_type_table, is_polymorphic
		end;

	SHARED_DECLARATIONS

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
			current_type_id: INTEGER;
			entry: ATTR_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C
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
					goto_used (type_id);
					if not after then
						from
							forth
						until
							after or else Result
						loop
							entry := item;
							cl_type := System.class_type_of_id (entry.type_id);
							if
								cl_type.associated_class.conform_to(first_class)							then
								Result := item.used
							end;
							forth
						end
					end
				else
					from
						start
					until
						after or else Result
					loop
						current_type_id := item.type_id;
						if current_type_id /= type_id then
							cl_type := System.class_type_of_id(current_type_id);
							if
								cl_type.associated_class.conform_to(first_class)
							then
								Result := item.used
							end
						end;
						forth
					end
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
			-- Generation of the attribute table in file "eattr*.x".
		local
			class_type: CLASS_TYPE;
			i, nb, min_val, max_val: INTEGER;
			c_name: STRING;
			p_name: STRING
		do
			c_name := clone (Encoder.table_name (rout_id));
			min_val := min_type_id;
			max_val := max_type_id;
			from
				file.putstring ("long ");
				file.putstring (static_prefix);
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
					class_type.skeleton.generate_offset (file, item.feature_id);
					file.putchar (',');
					file.new_line;
					forth
				else
					file.putstring ("0,%N")
				end;
				i := i + 1
			end;
			file.putstring ("};%N");
			file.putstring ("long *");
			file.putstring (c_name);
			file.putstring (" = ");
			file.putstring (static_prefix);
			file.putstring (c_name);
			file.putstring (";%N%N")
		end;

	generate_type_table (file: INDENT_FILE; final_mode: BOOLEAN) is
			-- Generate the associated type table.
		local
			i, nb: INTEGER;
			entry: ENTRY;
			c_name: STRING
		do
			file.putstring ("int16 ");
			if final_mode then
				c_name := clone (Encoder.type_table_name (rout_id));
				file.putstring (static_prefix);
				file.putstring (c_name)
			else
				file.putchar ('t');
				file.putint (rout_id)
			end;
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
			file.putstring ("};%N");
			if final_mode then
				file.putstring ("int16 *");
				file.putstring (c_name);
				file.putstring (" = ");
				file.putstring (static_prefix);
				file.putstring (c_name);
				file.putstring (";%N%N")
			else
				file.new_line
			end
		end;

invariant

	extendible_system: System.extendible

end -- class STAT_ATTR_TABLE
