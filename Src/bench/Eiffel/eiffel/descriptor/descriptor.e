-- General notion of class descriptor.
-- A descriptor is associated with one class type, is keyed by the class 
-- id's of the origin parent classes (parent classes which introduce actual 
-- routines).

class DESCRIPTOR

inherit

	EXTEND_TABLE [DESC_UNIT, INTEGER]
		rename
			put as table_put,
			item as table_item,
			make as table_make
		end;
	SHARED_WORKBENCH
		undefine
			twin
		end

creation

	make

feature

	make (ct: CLASS_TYPE; s: INTEGER) is
			-- Create a descriptor of size `s'.
		do
			class_type := ct;
			table_make (s)
		end

feature

	class_type: CLASS_TYPE;
			-- Class type (instantiated) associated with
			-- Current descriptor

feature -- Generation

	generate is
			-- Generate descriptor table and initialization
			-- function of current class type.
		local
			f: UNIX_FILE
		do
			f := class_type.descriptor_file;
			f.open_write;

			f.putstring (C_string);
			f.putstring (init_string);

			f.close
		end;

	C_string: STRING is
			-- C code of corresponding to run-time
			-- structure of Current descriptor
		local
			class_id, prev_id: INTEGER;
			i: INTEGER
		do
			!! Result.make (0);
			Result.append ("#include %"macros.h%"%N");
			Result.append ("%Nstruct desc_info desc");
			Result.append_integer (class_type.id);
			Result.append ("[] = {%N");
			from
				start
			until
				offright
			loop
				Result.append (item_for_iteration.C_string);
				forth
			end;
			Result.put ('%N', Result.count - 1);
			Result.put ('}', Result.count);
			Result.append (";%N");
		end;

	init_string: STRING is
			-- C code of initialization function of Current
			-- descriptor
		local
			i: INTEGER
		do
			!! Result.make (0);
			Result.append ("%NInit");
			Result.append_integer (class_type.id);
			Result.append ("()%N{%N");
			from
				start
			until
				offright
			loop
				Result.append ("%TIDSC(desc");
				Result.append_integer (class_type.id);
				Result.append ("+");
				Result.append_integer (i);
				Result.append (",");
				Result.append_integer (key_for_iteration);
				Result.append (",RTUD(");
				Result.append_integer (class_type.id);
				Result.append ("-1));%N");
				i := i + item_for_iteration.count;
				forth;
			end;
			Result.append ("}%N");
		end;

feature -- Melting

	make_byte_code (ba: BYTE_ARRAY) is
			-- Append byte code of Current descriptor
			-- Format:
			--    1) Id of class type (short)
			--    2) Number of descriptor units (short)
			--    3) Sequence of descriptor units
		do
				-- Write the id of the class type
			ba.append_short_integer (class_type.id);
				-- Write the number of descriptor units
			ba.append_short_integer (count);

				-- Append the individual descriptor units
			from
				start
			until
				offright
			loop
				item_for_iteration.make_byte_code (ba);
				forth
			end;
		end;

end
