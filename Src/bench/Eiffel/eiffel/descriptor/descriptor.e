-- General notion of class descriptor.
-- A descriptor is associated with one class type, is keyed by the class 
-- id's of the origin parent classes (parent classes which introduce actual 
-- routines).

class DESCRIPTOR

inherit

	EXTEND_TABLE [DESC_UNIT, CLASS_ID]
		rename
			put as table_put,
			item as table_item,
			make as table_make
		end;
	SHARED_COUNTER
		undefine
			copy, is_equal
		end;
	COMPILER_EXPORTER
		undefine
			copy, is_equal
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

feature

	set_invariant_entry (e: ENTRY) is
		do
			invariant_entry ?= e
		end;

	invariant_entry: ROUT_ENTRY;

feature -- Generation

	generate is
			-- Generate descriptor table and initialization
			-- function of current class type.
		local
			f: INDENT_FILE
		do
			f := class_type.descriptor_file;
			f.open_write;

			f.putstring ("#include %"macros.h%"%N%N");
			Class_counter.generate_extern_offsets (f);
			Static_type_id_counter.generate_extern_offsets (f);
			if Compilation_modes.is_precompiling then
				Real_body_index_counter.generate_extern_offsets (f);
				f.new_line;
				f.putstring (precomp_C_string)
			else
				f.new_line;
				f.putstring (C_string)
			end;
			f.putstring (init_string);

			f.close
		end;

	C_string: STRING is
			-- C code of corresponding to run-time
			-- structure of Current descriptor
		do
			!! Result.make (0);
			Result.append ("static struct desc_info desc[] = {%N");

			if (invariant_entry = Void) then
				Result.append ("%T{(uint16) ");
				Result.append_integer (Invalid_index);
				Result.append (", (int16) -1},%N")
			else
				Result.append ("%T{(uint16) ");
				Result.append_integer (invariant_entry.real_body_index.id - 1);
				Result.append (", (int16) -1},%N");
			end;

			from
				start
			until
				after
			loop
				Result.append (item_for_iteration.C_string);
				forth
			end;
			Result.put ('%N', Result.count - 1);
			Result.put ('}', Result.count);
			Result.append (";%N")
		end;

	precomp_C_string: STRING is
			-- C code of corresponding to run-time
			-- structure of Current precompiled descriptor
		local
			i: INTEGER
		do
			!! Result.make (0);
			Result.append ("static struct desc_info desc");
			Result.append ("[")
			Result.append_integer (table_size)
			Result.append ("];%N%Nstatic void build_desc () {%N")

			if (invariant_entry = Void) then
				Result.append ("%Tdesc[0].info = (uint16) ");
				Result.append_integer (Invalid_index);
				Result.append (";%N")
				Result.append ("%Tdesc[0].type = (int16) -1;%N")
			else
				Result.append ("%Tdesc[0].info = (uint16) (");
				Result.append (invariant_entry.real_body_index.generated_id);
				Result.append (");%N%Tdesc[0].type = (int16) -1;%N");
			end;

			from
				start
				i := 1
			until
				after
			loop
				Result.append (item_for_iteration.precomp_C_string (i));
				i := i + item_for_iteration.count
				forth
			end;
			Result.append ("}%N");
		end;

	init_string: STRING is
			-- C code of initialization function of Current
			-- descriptor
		local
			i: INTEGER
			class_type_id: TYPE_ID
		do
			class_type_id := class_type.id;
			!! Result.make (0);
			Result.append (class_type_id.init_name);
			Result.append ("()%N{%N");
			if Compilation_modes.is_precompiling then
				Result.append ("%Textern char desc_fill;%N");
				Result.append ("%Tif (desc_fill != 0)%N%T%Tbuild_desc();%N")
			end;

				-- Special descriptor unit (invariant)
			Result.append ("%T");
			Result.append (Init_macro);
			Result.append ("(desc");
			Result.append (", 0, RTUD(");
			Result.append (class_type_id.generated_id);
			Result.append ("));%N");	

				-- Descriptor units for origin classes
			from
				start;
				i := 1
			until
				after
			loop
				Result.append ("%T");
				Result.append (Init_macro);
				Result.append ("(desc");
				Result.append ("+");
				Result.append_integer (i);
				Result.append (",");
				Result.append (key_for_iteration.generated_id);
				Result.append (",RTUD(");
				Result.append (class_type_id.generated_id);
				Result.append ("));%N");
				i := i + item_for_iteration.count;
				forth
			end;
			Result.append ("}%N")
		end;

	table_size: INTEGER is
			-- Number of entries in the descriptor table
		do
			Result := 1;
			from start until after loop
				Result := Result + item_for_iteration.count;
				forth
			end
		end

feature -- Melting

	make_byte_code (ba: BYTE_ARRAY) is
			-- Append byte code of Current descriptor
			-- Format:
			--    1) Id of class type (short)
			--    2) Number of descriptor units (short)
			--    3) Sequence of descriptor units
		do
				-- Write the id of the class type
			ba.append_short_integer (class_type.id.id);
				-- Write the number of descriptor units
				-- +1, for the special routines (invariant...)
			ba.append_short_integer (count + 1);

				-- Byte code for invariant entry
				-- Origin class.
			ba.append_short_integer (0);
				-- Number of elements.
			ba.append_short_integer (1);
				-- body index
			if (invariant_entry = Void) then
				ba.append_short_integer (-1)
			else
				ba.append_short_integer	(invariant_entry.real_body_index.id - 1)
			end;
			ba.append_short_integer (-1);

				-- Append the individual descriptor units
			from
				start
			until
				after
			loop
				item_for_iteration.make_byte_code (ba);
				forth
			end;
		end;

feature -- DLE

	Init_macro: STRING is
			-- Macro for descriptor initialization
		once
			if System.is_dynamic then
				Result := "IMDSC"
			else
				Result := "IDSC"
			end
		end;

end
