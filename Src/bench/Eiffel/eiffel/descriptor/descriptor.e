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
	SHARED_GENERATION
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
			descriptor_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Retrieve the buffer and clear it
			buffer := generation_buffer
			buffer.clear_all

			buffer.append ("#include %"eif_macros.h%"%N%N");
			Class_counter.generate_extern_offsets (buffer);
			Static_type_id_counter.generate_extern_offsets (buffer);
			if Compilation_modes.is_precompiling then
				Real_body_index_counter.generate_extern_offsets (buffer);
				buffer.new_line
				buffer.generate_static_declaration ("void", "build_desc", <<"void">>);
				buffer.new_line
				descriptor_generate_generic (buffer)
				buffer.new_line
				descriptor_generate_precomp (buffer)
			else
				buffer.new_line
				descriptor_generate_generic (buffer)
				buffer.new_line
				descriptor_generate (buffer)
			end;

			generate_init_function (buffer)

			descriptor_file := class_type.open_descriptor_file
			descriptor_file.put_string (buffer)
			descriptor_file.close
		end;

	descriptor_generate (buffer: GENERATION_BUFFER) is
			-- C code of corresponding to run-time
			-- structure of Current descriptor
		require
			buffer_not_void: buffer /= Void
		local
			cnt : COUNTER
		do
			buffer.putstring ("static struct desc_info desc[] = {%N");

			if (invariant_entry = Void) then
				buffer.putstring ("%T{(uint16) ");
				buffer.putint (Invalid_index);
				buffer.putstring (", (int16) -1, (int16 *) 0},%N")
			else
				buffer.putstring ("%T{(uint16) ");
				buffer.putint (invariant_entry.real_body_index.id - 1);
				buffer.putstring (", (int16) -1, (int16 *) 0},%N")
			end;

			from
				!!cnt
				start
			until
				after
			loop
				item_for_iteration.generate (buffer, cnt)
				forth
			end

			buffer.putstring ("%N};%N")
		end;

	descriptor_generate_generic (buffer : GENERATION_BUFFER) is
			-- C code for generic type arrays.
		require
			buffer_not_void: buffer /= Void
		local
			cnt : COUNTER
		do
			from
				!!cnt
				start
			until
				after
			loop
				item_for_iteration.generate_generic (buffer, cnt);
				forth
			end;
			buffer.putstring ("%N")
		end;

	descriptor_generate_precomp (buffer: GENERATION_BUFFER) is
			-- C code of corresponding to run-time
			-- structure of Current precompiled descriptor
		require
			buffer_not_void: buffer /= Void
		local
			i: INTEGER
			cnt: COUNTER
		do
			buffer.putstring ("static struct desc_info desc");
			buffer.putstring ("[")
			buffer.putint (table_size)
			buffer.putstring ("];%N%Nstatic void build_desc (void) {%N")

			if (invariant_entry = Void) then
				buffer.putstring ("%Tdesc[0].info = (uint16) ")
				buffer.putint (Invalid_index)
				buffer.putstring (";%N")
				buffer.putstring ("%Tdesc[0].type = (int16) -1;%N")
				buffer.putstring ("%Tdesc[0].gen_type = (int16 *) 0;%N")
			else
				buffer.putstring ("%Tdesc[0].info = (uint16) (")
				invariant_entry.real_body_index.generated_id (buffer)
				buffer.putstring (");%N%Tdesc[0].type = (int16) -1;%N")
				buffer.putstring ("%Tdesc[0].gen_type = (int16 *) 0;%N")
			end;

			from
				!!cnt
				start
				i := 1
			until
				after
			loop
				item_for_iteration.generate_precomp (buffer,i,cnt)
				i := i + item_for_iteration.count
				forth
			end;
			buffer.putstring ("}%N");
		end;

	generate_init_function (buffer: GENERATION_BUFFER) is
			-- C code of initialization function of Current
			-- descriptor
		local
			i: INTEGER
			class_type_id: TYPE_ID
			init_name: STRING
			desc, rtud, init_macro, sep: STRING
		do
			class_type_id := class_type.id;
			init_name := class_type_id.init_name;
			init_macro := "%TIDSC"
			rtud := ", RTUD("
			rtud.append (class_type_id.generated_id_string)
			rtud.append ("));%N")


			buffer.generate_extern_declaration ("void", init_name, <<"void">>);

			buffer.putstring ("void ");
			buffer.putstring (init_name);
			buffer.putstring ("(void)%N{%N");
			if Compilation_modes.is_precompiling then
				buffer.putstring ("%Textern char desc_fill;%N%
								%%Tif (desc_fill != 0)%N%T%Tbuild_desc();%N")
			end;

				-- Special descriptor unit (invariant)
			buffer.putstring (init_macro);
			buffer.putstring ("(desc, 0")
			buffer.putstring (rtud)

				-- Descriptor units for origin classes
			from
				desc := "(desc + "
				sep := ", "
				start
				i := 1
			until
				after
			loop
				buffer.putstring (init_macro);
				buffer.putstring (desc);
				buffer.putint (i);
				buffer.putstring (sep);
				key_for_iteration.generated_id (buffer);
				buffer.putstring (rtud);
				i := i + item_for_iteration.count;
				forth
			end;
			buffer.putstring ("}%N")
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

			-- No type
			ba.append_short_integer (-1);
			-- No generics
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

end
