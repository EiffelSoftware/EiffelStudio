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

			f.putstring ("#include %"eif_macros.h%"%N%N");
			Class_counter.generate_extern_offsets (f);
			Static_type_id_counter.generate_extern_offsets (f);
			if Compilation_modes.is_precompiling then
				Real_body_index_counter.generate_extern_offsets (f);
				f.new_line;

				f.generate_static_declaration ("void", "build_desc", <<"void">>);

				descriptor_generate_precomp (f)
			else
				f.new_line
				descriptor_generate (f)
			end;

			generate_init_function (f)

			f.close
		end;

	descriptor_generate (f: INDENT_FILE) is
			-- C code of corresponding to run-time
			-- structure of Current descriptor
		require
			file_not_void: f /= Void
			file_exists: f.exists
		do
			f.putstring ("static struct desc_info desc[] = {%N");

			if (invariant_entry = Void) then
				f.putstring ("%T{(uint16) ");
				f.putint (Invalid_index);
				f.putstring (", (int16) -1},%N")
			else
				f.putstring ("%T{(uint16) ");
				f.putint (invariant_entry.real_body_index.id - 1);
				f.putstring (", (int16) -1},%N");
			end;

			from
				start
			until
				after
			loop
				item_for_iteration.generate (f)
				forth
			end

			f.putstring ("%N};%N")
		end;

	descriptor_generate_precomp (f: INDENT_FILE) is
			-- C code of corresponding to run-time
			-- structure of Current precompiled descriptor
		local
			i: INTEGER
		do
			f.putstring ("static struct desc_info desc");
			f.putstring ("[")
			f.putint (table_size)
			f.putstring ("];%N%Nstatic void build_desc (void) {%N")

			if (invariant_entry = Void) then
				f.putstring ("%Tdesc[0].info = (uint16) ")
				f.putint (Invalid_index)
				f.putstring (";%N")
				f.putstring ("%Tdesc[0].type = (int16) -1;%N")
			else
				f.putstring ("%Tdesc[0].info = (uint16) (")
				f.putstring (invariant_entry.real_body_index.generated_id)
				f.putstring (");%N%Tdesc[0].type = (int16) -1;%N")
			end;

			from
				start
				i := 1
			until
				after
			loop
				item_for_iteration.generate_precomp (f,i)
				i := i + item_for_iteration.count
				forth
			end;
			f.putstring ("}%N");
		end;

	generate_init_function (f: INDENT_FILE) is
			-- C code of initialization function of Current
			-- descriptor
		local
			i: INTEGER
			class_type_id: TYPE_ID
			init_name: STRING
		do
			class_type_id := class_type.id;
			init_name := class_type_id.init_name;

			f.generate_extern_declaration ("void", init_name, <<"void">>);

			f.putstring ("void ");
			f.putstring (init_name);
			f.putstring ("(void)%N{%N");
			if Compilation_modes.is_precompiling then
				f.putstring ("%Textern char desc_fill;%N");
				f.putstring ("%Tif (desc_fill != 0)%N%T%Tbuild_desc();%N")
			end;

				-- Special descriptor unit (invariant)
			f.putstring ("%T");
			f.putstring (Init_macro);
			f.putstring ("(desc");
			f.putstring (", 0, RTUD(");
			f.putstring (class_type_id.generated_id);
			f.putstring ("));%N");	

				-- Descriptor units for origin classes
			from
				start;
				i := 1
			until
				after
			loop
				f.putstring ("%T");
				f.putstring (Init_macro);
				f.putstring ("(desc");
				f.putstring ("+");
				f.putint (i);
				f.putstring (",");
				f.putstring (key_for_iteration.generated_id);
				f.putstring (",RTUD(");
				f.putstring (class_type_id.generated_id);
				f.putstring ("));%N");
				i := i + item_for_iteration.count;
				forth
			end;
			f.putstring ("}%N")
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

	Init_macro: STRING is "IDSC"
			-- Macro for descriptor initialization

end
