-- Descriptor unit: block in class type descriptor corresponding to
-- given parent class.

class DESC_UNIT

inherit

	ARRAY [ENTRY]
		rename
			make as array_make
		end

creation

	make

feature -- Creation

	make (c_id: INTEGER; sz: INTEGER) is
		do
			class_id := c_id;
			array_make (0, sz-1)
		end;

	class_id: INTEGER;

feature -- Generation

	C_string: STRING is
			-- C code of Current descriptor unit
			--|Note1: Currently the feature type is written for all the 
			--|features when in practice it is used rather seldom. Try
			--|to find a better representation (without affecting the
			--|incrementality).
			--|Note2: The offset of an attribute is coded on 16 bits
			--|whixh might noy be enough.
		local
			i: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
		do
			!!Result.make (0);
			from
				i := lower
			until
				i > upper
			loop
				if item (i) /= Void then
					re ?= item (i);
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						Result.append ("%T{(int16) ");
						Result.append_integer (re.real_body_index);
						Result.append (", (int16) ");
						Result.append_integer (re.static_feature_type_id -1);
						Result.append ("},%N");
					else
						ae ?= item (i);
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							Result.append ("%T{(int16) ");
							Result.append_integer (ae.workbench_offset);
							Result.append (", (int16) ");
							Result.append_integer (ae.static_feature_type_id - 1);
							Result.append ("},%N");
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					Result.append ("%T{(int16) -1, (int16) -1},%N")
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
			--    3) Sequence of pairs (short, short)
		local
			i: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
		do
				-- Append the id of the origin class
			ba.append_short_integer (class_id);

				-- Append the size of the descriptor unit
			ba.append_short_integer (upper - lower + 1);

				-- Append the descriptor entries
			from
				i := lower
			until
				i > upper
			loop
				if item (i) /= Void then
					re ?= item (i);
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						ba.append_short_integer (re.real_body_index);
						ba.append_short_integer (re.static_feature_type_id -1);
					else
						ae ?= item (i);
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							ba.append_short_integer (ae.workbench_offset);
							ba.append_short_integer (ae.static_feature_type_id - 1);
						else
							ba.append_short_integer (-1);
							ba.append_short_integer (-1)
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					ba.append_short_integer (-1);
					ba.append_short_integer (-1)
				end;
				i := i + 1
			end;
		end;

end
