-- Representation of a table of attribute offsets for the final Eiffel
-- executable

class ATTR_TABLE

inherit
	POLY_TABLE [ATTR_ENTRY]
		rename
			writer as Attr_generator
		redefine
			final_table_size
		end;

	SHARED_CODE_FILES
		undefine
			copy, is_equal
		end

	SHARED_GENERATOR
		undefine
			copy, is_equal
		end

	SHARED_GENERATION
		undefine
			copy, is_equal
		end

creation
	make

feature

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
			entry: ATTR_ENTRY;
			cl_type: CLASS_TYPE;
			first_class: CLASS_C;
			i, nb, old_position: INTEGER
			local_copy: ATTR_TABLE
			system_i: SYSTEM_I
			offset: INTEGER
		do
			nb := max_position

			if nb > 1 then
				old_position := position
				system_i := System

					-- If it is not a poofter finalization
					-- we have a quicker algorithm handy.
				if not system_i.poofter_finalization then	
					goto_used (type_id);
					i := position
					if i <= nb then
						local_copy := Current
						from
							cl_type := system_i.class_type_of_id (type_id);
							first_class := cl_type.associated_class;
							offset := cl_type.skeleton.offset (local_copy.array_item (i).feature_id)
							i := i + 1
						until
							Result or else i > nb
						loop
							entry := local_copy.array_item (i)
							cl_type := system_i.class_type_of_id (entry.type_id);
							Result := cl_type.associated_class.simple_conform_to (first_class)
									and then not (cl_type.skeleton.offset (entry.feature_id) = offset)
							i := i + 1
						end;
					end
				else
					from
						goto_used (type_id)
						local_copy := Current
						i := lower
						cl_type := system_i.class_type_of_id (type_id);
						first_class := cl_type.associated_class;
						offset := cl_type.skeleton.offset (local_copy.array_item (position).feature_id)
					until
						Result or else i > nb
					loop
						entry := local_copy.array_item (i)
						current_type_id := entry.type_id;
						if current_type_id /= type_id then
							cl_type := system_i.class_type_of_id (current_type_id);
							Result := cl_type.associated_class.simple_conform_to (first_class)
									and then not (cl_type.skeleton.offset (entry.feature_id) = offset) 
						end;
						i := i + 1
					end;
				end
				position := old_position
			end
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the attribute table in buffer "eattr*.x".
		local
			class_type: CLASS_TYPE;
			i, nb, index: INTEGER;
			attr_entry: ATTR_ENTRY
			local_copy: ATTR_TABLE
		do
			from
					-- Private table
				buffer.putstring ("long ");
				buffer.putstring (Encoder.table_name (rout_id));
				buffer.putstring ("[] = {%N");
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
					class_type.skeleton.generate_offset (buffer, attr_entry.feature_id, True);
					buffer.putchar (',');
					buffer.new_line;
					index := index + 1;
				else
					buffer.putstring ("0,%N");
				end;
				i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end;

end
