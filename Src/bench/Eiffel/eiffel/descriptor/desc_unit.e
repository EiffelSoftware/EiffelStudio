-- Descriptor unit: block in class type descriptor corresponding to
-- given parent class.

class DESC_UNIT

inherit

	ARRAY [ENTRY]
		rename
			make as array_make
		end;
	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end;
	SHARED_COUNTER
		undefine
			is_equal, copy
		end

creation

	make

feature -- Creation

	make (c_id: CLASS_ID; sz: INTEGER) is
		do
			class_id := c_id;
			array_make (0, sz-1)
		end;

	class_id: CLASS_ID;

feature -- Generation

	generate (buffer: GENERATION_BUFFER; cnt : COUNTER; id_string: STRING) is
			-- C code of Current descriptor unit
			--|Note1: Currently the feature type is written for all the 
			--|features when in practice it is used rather seldom. Try
			--|to find a better representation (without affecting the
			--|incrementality).
			--|Note2: The offset of an attribute is coded on 16 bits
			--|which might not be enough.
		require
			buffer_not_void: buffer /= Void
			valid_counter: cnt /= Void
		local
			i,j: INTEGER
			re: ROUT_ENTRY
			ae: ATTR_ENTRY
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
			uint16, int16, gen_type, separator, null_init: STRING
			invalid_entry: STRING
		do
			from
				uint16 := "%N%T{(uint16) "
				int16 := ", (int16) "
				gen_type := ", gen_type"
				separator := "}, "
				null_init := ", (int16 *) 0"
				local_copy := Current
				Invalid_entry := ", (int16) -1, (int16 *) 0},"
				i := lower
			until
				i > upper
			loop
				entry_item := local_copy.item (i)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						buffer.putstring (uint16);
						buffer.putint (re.real_body_index.id - 1);
						buffer.putstring (int16);
						buffer.putint (re.static_feature_type_id - 1);

						if re.is_generic then
							buffer.putstring (gen_type);
							buffer.putint (cnt.value);
							buffer.putstring (id_string)
							j := cnt.next
						else           
							buffer.putstring (null_init);
						end;

						buffer.putstring (separator);
					else
						ae ?= entry_item
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							buffer.putstring (uint16);
							buffer.putint (ae.workbench_offset);
							buffer.putstring (int16);
							buffer.putint (ae.static_feature_type_id - 1);

							if ae.is_generic then
								buffer.putstring (gen_type);
								buffer.putint (cnt.value);
								buffer.putstring (id_string)
								j := cnt.next
							else           
								buffer.putstring (null_init);
							end;

							buffer.putstring (separator);
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					buffer.putstring (uint16);
					buffer.putint (Invalid_index);
					buffer.putstring (invalid_entry)
				end;
				i := i + 1
			end;
		end;

	generate_precomp (buffer: GENERATION_BUFFER; start: INTEGER; cnt : COUNTER; id_string: STRING) is
			-- C code of Current precompiled descriptor unit
			--|Note1: Currently the feature type is written for all the 
			--|features when in practice it is used rather seldom. Try
			--|to find a better representation (without affecting the
			--|incrementality).
			--|Note2: The offset of an attribute is coded on 16 bits
			--|which might not be enough.
		require
			buffer_not_void: buffer /= Void
			valid_counter: cnt /= Void
		local
			i,j: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
			nb: INTEGER
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
			info, desc1, desc2, gen_type, type: STRING
			non_generic, gen_type_string, end_of_line: STRING
		do
			from
					-- Initialize all the constant string used during this generation
				info := "].info = (uint16) ("
				desc1 := "%Tdesc" + id_string + "["
				desc2 := ");%N%Tdesc" + id_string + "["
				type := "].type = (int16) ("
				gen_type := "].gen_type = "
				non_generic := "(int16 *) 0;%N"
				gen_type_string := " gen_type"
				end_of_line := ";%N"
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				nb := i + start
				entry_item := local_copy.item (i)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						buffer.putstring (desc1);
						buffer.putint (nb);
						buffer.putstring (info);
						re.real_body_index.generated_id (buffer);
						buffer.putstring (desc2);
						buffer.putint (nb);
						buffer.putstring (type);
						re.generated_static_feature_type_id (buffer)
						buffer.putstring (desc2);
						buffer.putint (nb);
						buffer.putstring (gen_type);

						if re.is_generic then
							buffer.putstring (gen_type_string);
							buffer.putint (cnt.value);
							buffer.putstring (id_string);
							buffer.putstring (end_of_line)
							j := cnt.next
						else
							buffer.putstring (non_generic)
						end
					else
						ae ?= entry_item
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							buffer.putstring (desc1);
							buffer.putint (nb);
							buffer.putstring (info);
							buffer.putint (ae.workbench_offset);
							buffer.putstring (desc2);
							buffer.putint (nb);
							buffer.putstring (type);
							ae.generated_static_feature_type_id (buffer)
							buffer.putstring (desc2);
							buffer.putint (nb);
							buffer.putstring (gen_type);

							if ae.is_generic then
								buffer.putstring (gen_type_string);
								buffer.putint (cnt.value);
								buffer.putstring (id_string);
								buffer.putstring (end_of_line)
								j := cnt.next
							else
								buffer.putstring (non_generic)
							end
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					buffer.putstring (desc1);
					buffer.putint (nb);
					buffer.putstring (info);
					buffer.putint (Invalid_index);
					buffer.putstring (desc2);
					buffer.putint (nb);
					buffer.putstring (type)
					buffer.putint (-1)
					buffer.putstring (desc2);
					buffer.putint (nb);
					buffer.putstring (gen_type)
					buffer.putstring (non_generic);
				end;
				i := i + 1
			end;
		end;

	generate_generic (buffer: GENERATION_BUFFER; cnt : COUNTER; id_string: STRING) is
			-- C code for generic types in Current descriptor unit
		require
			buffer_not_void: buffer /= Void
			valid_counter : cnt /= Void
		local
			i, j: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
			static_decl, start_decl, end_decl: STRING
		do
			from
				static_decl := "static int16 gen_type"
				start_decl := " [] = {0, "
				end_decl := "-1};%N"
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				entry_item := local_copy.item (i)
				if entry_item /= Void and then entry_item.is_generic then
					re ?= entry_item
					if re /= Void then
						buffer.putstring (static_decl);
						buffer.putint (cnt.value);
						buffer.putstring (id_string);
						j := cnt.next;
						buffer.putstring (start_decl);
						re.generate_cid (buffer, False);
						buffer.putstring (end_decl)
					else
						ae ?= entry_item
						if ae /= Void then
							buffer.putstring (static_decl);
							buffer.putint (cnt.value);
							buffer.putstring (id_string);
							j := cnt.next;
							buffer.putstring (start_decl);
							ae.generate_cid (buffer, False);
							buffer.putstring (end_decl)
						end
					end;
				end;
				i := i + 1
			end;
		end;

feature -- Melting

	make_byte_code (ba: BYTE_ARRAY) is
			-- Append byte code of Current descriptor
			-- unit to the `ba' byte array.
			-- Format:
			--    1) Id of origin class (short)
			--    2) Number of elements (short)
			--    3) Sequence of triples (short, short, list_of_short)
		local
			i: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
		do
				-- Append the id of the origin class
			ba.append_short_integer (class_id.id);

				-- Append the size of the descriptor unit
			ba.append_short_integer (upper - lower + 1);

				-- Append the descriptor entries
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				entry_item := local_copy.item (i)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						ba.append_short_integer (re.real_body_index.id - 1);
						ba.append_short_integer (re.static_feature_type_id -1);

						if re.is_generic then
							ba.append_short_integer (0)
							re.make_gen_type_byte_code (ba)
						end;

						ba.append_short_integer (-1)
					else
						ae ?= entry_item
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							ba.append_short_integer (ae.workbench_offset);
							ba.append_short_integer (ae.static_feature_type_id - 1);

							if ae.is_generic then
								ba.append_short_integer (0)
								ae.make_gen_type_byte_code (ba)
							end;

							ba.append_short_integer (-1)
						else
							ba.append_short_integer (-1);
							ba.append_short_integer (-1);
							ba.append_short_integer (-1)
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					ba.append_short_integer (-1);
					ba.append_short_integer (-1);
					ba.append_short_integer (-1)
				end;
				i := i + 1
			end;
		end;

end
