-- List of attribute sorted by category or skeleton of a class type (instance
-- of CLASS_TYPE).

class SKELETON 

inherit

	GENERIC_SKELETON;
	SHARED_LEVEL
		export
			{ANY} all
		end;
	SHARED_WORKBENCH;
	SHARED_CODE_FILES;
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	COMPILER_EXPORTER

creation
	make
	
feature 

	has_feature_id (feature_id: INTEGER): BOOLEAN is
			-- Has the skeleton an attribute of feature id `feature_id' ?
		do
			search_feature_id (feature_id);
			Result := not after;
		end;

	search_feature_id (feature_id: INTEGER) is
			-- Search an attribute description fo feature id `feature_id'
		require
			not empty;
		do
			from
				start;
			until
				after or else item.feature_id = feature_id
			loop
				forth
			end;
		end;

	nb_reference: INTEGER is
			-- Numer of reference attributes
		do
			Result := nb_level (Reference_level);
		end;

	nb_integer: INTEGER is
			-- Number of integer attributes
		do
			Result := nb_level (Integer_level);
		end;

	nb_character: INTEGER is
			-- Number of character and boolean attributes
		do
			Result := nb_level (Character_level) + nb_level (Boolean_level);
		end;

	nb_real: INTEGER is
			-- Number of real attributes
		do
			Result := nb_level (Real_level);
		end;

	nb_double: INTEGER is
			-- Number of double attributes
		do
			Result := nb_level (Double_level);
		end;

	nb_pointer: INTEGER is
			-- Number of pointer attributes
		do
			Result := nb_level (Pointer_level);
		end;

	nb_bits: INTEGER is
			-- Number of bits attribute
		do
			Result := nb_level (Bits_level);
		end;

	nb_expanded: INTEGER is
			-- Number of expanded attributes
		do
			Result := nb_level (Expanded_level);
		end;

	
	nb_level (level: INTEGER): INTEGER is
			-- Number of item of level `level'.
		require
			level <= Expanded_level and then level >= Reference_level;
		local
			old_cursor: CURSOR;
		do
			from
				old_cursor := cursor;
				goto (level);
			until
				after or else item.level > level
			loop
				Result := Result + 1;
				forth;
			end;
			go_to (old_cursor);
		end;

	go_reference is
			-- Go to the reference attributes
		do
			goto (Reference_level);
		end;

	go_expanded is
			-- Go to the expanded
		do
			goto (Expanded_level);
		end;

	go_bits is
			-- Go to the bits attribute
		do
			goto (Bits_level);
		end;

	goto (level: INTEGER) is
			-- Position the cursor to the first reference of level `level'.
		require
			level >= Reference_level and then level <= Expanded_level;
		do
			from
				start
			until
				after or else item.level >= level
			loop
				forth
			end;
		end;

	generate_size (file: INDENT_FILE) is
			-- Generate the size of current skeleton in file `file'.
		require
			good_argument: file /= Void;
			is_open: file.is_open_write or file.is_open_append;
		local
			expanded_desc: EXPANDED_DESC;
			bit_desc: BITS_DESC;
			expanded_skeleton: SKELETON;
		do
			file.putstring ("@OBJSIZ(");
			file.putint (nb_reference + nb_expanded);
			file.putchar (',');
			file.putint (nb_character);
			file.putchar (',');
			file.putint (nb_integer);
			file.putchar (',');
			file.putint (nb_real);
			file.putchar (',');
			file.putint (nb_pointer);
			file.putchar (',');
			file.putint (nb_double);
			file.putchar (')');
			go_bits;
			from
			until
				after or else item.level /= Bits_level
			loop
				bit_desc ?= item;
				file.putstring ("+OVERHEAD+BITOFF(");
				file.putint (bit_desc.value);
				file.putchar (')');
				forth;
			end;
			go_expanded;
			from
			until
				after
			loop
				expanded_desc ?= item;
				expanded_skeleton := expanded_desc.class_type.skeleton;
				file.putstring ("+OVERHEAD+");
				expanded_skeleton.generate_size (file);
				forth;
			end;
		end;

	generate_workbench_size (file: INDENT_FILE) is
			-- Generate size of the skeleton in workbench mode.
		do
			file.putint (workbench_size);
		end;

	workbench_size: INTEGER is
			-- Size of the current skeleton in workbench mode
		local
			expanded_desc: EXPANDED_DESC;
			bit_desc: BITS_DESC;
			expanded_skeleton: SKELETON;
		do
			Result := objsiz(
							nb_reference + nb_expanded,
							nb_character,
							nb_integer,
							nb_real,
							nb_pointer,
							nb_double);
			from
				go_bits;
			until
				after or else item.level /= Bits_level
			loop
				bit_desc ?= item;
				Result := Result + ovhsiz + bitoff(bit_desc.value);
				forth;
			end;
			go_expanded;
			from
			until
				after
			loop
				expanded_desc ?= item;
				expanded_skeleton := expanded_desc.class_type.skeleton;
				Result := Result + ovhsiz + expanded_skeleton.workbench_size;
				forth;
			end;
		end;

	generate_offset (file: INDENT_FILE; feature_id: INTEGER; is_in_attr_table: BOOLEAN) is
			-- Generate offset for attribute of feature id `feature_id'
			-- in file `file'.
		require
			has_feature_id: has_feature_id (feature_id);
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		do
			search_feature_id (feature_id);
			generate (file, is_in_attr_table);
		end;

	generate_workbench_offset (file: INDENT_FILE; feature_id: INTEGER) is
			-- Generate offset for attribute of feature id `feature_id'
			-- in file `file' in workbench mode only.
		require
			has_feature_id: has_feature_id (feature_id);
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		do
			search_feature_id (feature_id);
			file.putint (workbench_offset);
		end;

	generate (file: INDENT_FILE; is_in_attr_table: BOOLEAN) is
			-- Generate offset of the attribute at the current position
		require
			not_off: not off;
			good_argument: file /= Void;
			good_context: file.is_open_write or else file.is_open_append;
		local
			nb_ref, nb_int, nb_char, nb_flt, nb_dbl, nb_ptr: INTEGER;
			pos, level: INTEGER;
			real_nb_ref, nb: INTEGER;
			expanded_desc: EXPANDED_DESC;
			bit_desc: BITS_DESC;
			value: INTEGER
		do
			level := item.level;
			inspect
				level
			when Reference_level then
				value := index - 1
				if value /= 0 then
					file.putstring (" + @REFACS(");
					file.putint (value);
					file.putchar (')');
				elseif is_in_attr_table then
					file.putchar ('0')
				end
			when Character_level, Boolean_level then
				nb_ref := nb_reference;
				file.putstring ("+ @CHROFF(");
				file.putint (nb_ref + nb_expanded);
				file.putchar (',');
				file.putint (index - nb_ref - 1)
				file.putchar (')');
			when Integer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				file.putstring ("+ @LNGOFF(");
				file.putint (nb_ref + nb_expanded);
				file.putchar (',');
				file.putint (nb_character);
				file.putchar (',');
				file.putint (index - nb_ref - nb_char - 1)
				file.putchar (')');
			when Real_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				file.putstring ("+ @FLTOFF(");
				file.putint (nb_ref + nb_expanded);
				file.putchar (',');
				file.putint (nb_char);
				file.putchar (',');
				file.putint (nb_int);
				file.putchar (',');
				file.putint (index - nb_ref - nb_char - nb_int - 1)
				file.putchar (')');
			when Pointer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				nb_flt := nb_real;
				file.putstring ("+ @PTROFF(");
				file.putint (nb_ref + nb_expanded);
				file.putchar (',');
				file.putint (nb_char);
				file.putchar (',');
				file.putint (nb_int);
				file.putchar (',');
				file.putint (nb_flt);
				file.putchar (',');
				file.putint (index - nb_ref - nb_char - nb_int - nb_flt - 1)
				file.putchar (')');
			when Double_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				file.putstring ("+ @DBLOFF(");
				file.putint (nb_ref + nb_expanded);
				file.putchar (',');
				file.putint (nb_char);
				file.putchar (',');
				file.putint (nb_int);
				file.putchar (',');
				file.putint (nb_flt);
				file.putchar (',');
				file.putint (nb_ptr);
				file.putchar (',');
				file.putint (index - nb_ref - nb_char - nb_int - nb_flt - nb_ptr - 1)
				file.putchar (')');
			else
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				nb_dbl := nb_double;
				file.putstring ("+ @OBJSIZ(");
				file.putint (nb_ref + nb_expanded);
				file.putchar (',');
				file.putint (nb_char);
				file.putchar (',');
				file.putint (nb_int);
				file.putchar (',');
				file.putint (nb_flt);
				file.putchar (',');
				file.putint (nb_ptr);
				file.putchar (',');
				file.putint (nb_dbl);
				file.putchar (')');
				if level = Bits_level then
					from
						pos := index;
						go_bits;
					until
						index >= pos
					loop
						file.putstring ("+OVERHEAD+BITOFF(");
						bit_desc ?= item;
						file.putint (bit_desc.value);
						file.putchar (')');
						forth;
					end;
					file.putstring ("+OVERHEAD");
				else
					from
						pos := index;
						go_bits;
					until
						after or else item.level /= Bits_level
					loop
						file.putstring ("+OVERHEAD+BITOFF(");
						bit_desc ?= item;
						file.putint (bit_desc.value);
						file.putchar (')');
						forth;
					end;
					from
						go_expanded;
					until
						index >= pos
					loop
						file.putstring ("+OVERHEAD+");
						expanded_desc ?= item;
						expanded_desc.class_type.skeleton.generate_size (file);
						forth
					end;
					file.putstring ("+OVERHEAD");
				end;
			end;
		end;

	workbench_offset: INTEGER is
			-- Offset of the attribute at the current position in
			-- workbench mode
		require
			not_off: not off;
		local
			nb_ref, nb_int, nb_char, nb_flt, nb_dbl, nb_ptr: INTEGER;
			pos, level: INTEGER;
			real_nb_ref, nb: INTEGER;
			expanded_desc: EXPANDED_DESC;
			bit_desc: BITS_DESC;
			exp_skel: SKELETON;
		do
			level := item.level;
			inspect
				level
			when Reference_level then
				Result := refacs (index - 1);
			when Character_level, Boolean_level then
				nb_ref := nb_reference;
				Result := 
					chroff (nb_ref + nb_expanded) +
					chracs (index - nb_ref - 1);
			when Integer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				Result := 
					lngoff (nb_ref+nb_expanded, nb_char) +
					lngacs (index - nb_ref - nb_char - 1);
			when Real_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				Result :=
					fltoff (nb_ref+nb_expanded, nb_char, nb_int) +
					fltacs (index - nb_ref - nb_char - nb_int - 1); 
			when Pointer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				nb_flt := nb_real;
				Result :=
					ptroff (nb_ref+nb_expanded,nb_char,nb_int,nb_flt) +
					ptracs (index - nb_ref - nb_char - nb_int - nb_flt - 1);
			when Double_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				Result :=
					dbloff (nb_ref+nb_expanded,nb_char,nb_int,nb_flt,nb_ptr) +
					dblacs
				(index - nb_ref - nb_char - nb_int - nb_flt - nb_ptr - 1);
			else
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int := nb_integer;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				nb_dbl := nb_double;
				Result := 
					objsiz
					(nb_ref+nb_expanded,nb_char,nb_int,nb_flt,nb_ptr,nb_dbl);
				if level = Bits_level then
					from
						pos := index;
						go_bits;
					until
						index >= pos
					loop
						bit_desc ?= item;
						Result := Result + ovhsiz + bitoff(bit_desc.value);
						forth;
					end;
					Result := Result + ovhsiz;
				else
					from
						pos := index;
						go_bits;
					until
						after or else item.level /= Bits_level
					loop
						bit_desc ?= item;
						Result := Result + ovhsiz + bitoff(bit_desc.value);
						forth;
					end;
					from
						go_expanded;
					until
						index >= pos
					loop
						expanded_desc ?= item;
						exp_skel := expanded_desc.class_type.skeleton;
						Result := Result + ovhsiz + exp_skel.workbench_size;
						forth
					end;
					Result := Result + ovhsiz;
				end;
			end;
		end;
-- Skeleton byte code
	
	make_names_byte_code (ba: BYTE_ARRAY) is
			-- Generate attribute names in `ba'.
		require
			good_argument: ba /= Void
		do
			from
				start
			until
				after
			loop
				ba.append_string (item.attribute_name);
				forth;
			end;
		end;

	make_rout_id_array (ba: BYTE_ARRAY) is
			-- Generate routine id array in `ba'.
		require
			good_argument: ba /= Void
		do
			from
				start;
			until
				after
			loop
				ba.append_int32_integer (item.rout_id.id);
				forth;
			end;
		end;

	make_type_byte_code (ba: BYTE_ARRAY) is
			-- Generate meta-type array byte code
		require
			good_argument: ba /= Void
		do
			from
				start
			until
				after
			loop
				if System.java_generation then
					ba.append_uint32_integer (item.real_sk_value)
				else
					ba.append_uint32_integer (item.sk_value)
				end
				forth
			end;
		end;

	make_size_byte_code (ba: BYTE_ARRAY) is
			-- Generate datas for evaluation of the skeleton size
		do
			ba.append_integer (workbench_size);
		end;

	make_offset_byte_code (ba: BYTE_ARRAY; feature_id: INTEGER) is
			-- Generate byte code description of the feature of
			-- feature `feature_id' in `ba'.
		require
			has_feature_id: has_feature_id (feature_id);
		do
			search_feature_id (feature_id);
			make_offset (ba);
		end;

	make_offset (ba: BYTE_ARRAY) is
			-- Generate byte code description of attribute at the current
			-- description
		require
			not_off: not off;
			good_argument: ba /= Void
		do
			ba.append_integer (workbench_offset);
		end;

	Skeleton_file: INDENT_FILE is
		do
			Result := System.Skeleton_file
		end;

	generate_name_array is
			-- Generate static C array of attributes names in the
			-- skeleton file.
		require
			Skeleton_file.is_open_write;
			not empty;
		do
			Skeleton_file.putchar ('{');
			Skeleton_file.new_line;
			from
				start
			until
				after
			loop
				Skeleton_file.putchar ('"');
				Skeleton_file.putstring (item.attribute_name);
				Skeleton_file.putstring ("%",%N");
				forth;
			end;
			Skeleton_file.putstring ("};%N%N");
		end;

	generate_type_array is
			-- Generate static C array of attributes type codes in the
			-- skeleton file.
		require
			Skeleton_file.is_open_write;
			not empty;
		do
			Skeleton_file.putchar ('{');
			Skeleton_file.new_line;
			from
				start
			until
				after
			loop
				item.generate_code (Skeleton_file);
				Skeleton_file.putstring (",%N");
				forth;
			end;
			Skeleton_file.putstring ("};%N%N");
		end;

	generate_offset_array is
			-- Generate static C array of attributes offset table pointers.
		require
			Skeleton_file.is_open_write;
			not empty;
		local
			rout_id: ROUTINE_ID;
			tbl: POLY_TABLE [ENTRY];
		do
			Skeleton_file.putchar ('{');
			Skeleton_file.new_line;
			from
				start;
			until
				after
			loop
				rout_id := item.rout_id;
				tbl := Eiffel_table.poly_table (rout_id);
					-- Generate a special prefix when dealing with DLE.
				Skeleton_file.putstring (rout_id.table_name);
				Skeleton_file.putstring (" - ");
				Skeleton_file.putint (tbl.min_type_id - 1);
				Skeleton_file.putstring (",%N");
				forth;
			end;
			Skeleton_file.putstring ("};%N%N");
		end;

	make_extern_declarations is
		-- Prepare extern declarations for final mode
		-- generation
	local
		rout_id: ROUTINE_ID;
	do
		from
			start
		until
			after
		loop
			rout_id := item.rout_id;
			Extern_declarations.add_skeleton_attribute_table
				(rout_id.table_name);
			Eiffel_table.mark_used (rout_id);
			forth
		end;
	end;

	generate_rout_id_array is
			-- Generate static C array of attributes routine ids
		require
			Skeleton_file.is_open_write;
			not empty;
		do
			Skeleton_file.putchar ('{');
			Skeleton_file.new_line;
			from
				start;
			until
				after
			loop
				Skeleton_file.putint (item.rout_id.id);
				Skeleton_file.putstring (",%N");
				forth;
			end;
			Skeleton_file.putstring ("};%N%N");
		end;

feature {NONE} -- Externals

	chroff(nb_ref: INTEGER): INTEGER is
			-- Offset of first character after `nb_ref' references
		external
			"C"
		end;

	lngoff(nb_ref, nb_char: INTEGER): INTEGER is
			-- Offset of first integer after `nb_ref' references,
			-- and `nb_char' characters
		external
			"C"
		end;

	fltoff (nb_ref, nb_char, nb_int: INTEGER): INTEGER is
			-- Offset of first float after `nb_ref' references,
			-- `nb_char' characters and `nb_int' integers
		external
			"C"
		end;

	ptroff (nb_ref, nb_char, nb_int, nb_flt: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int' integers and `nb_flt' floats
		external
			"C"
		end;

	dbloff (nb_ref, nb_char, nb_int, nb_flt, nb_ptr: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int' integers, `nb_flt' floats,
			-- and `nb_ptr' pointers
		external
			"C"
		end;

	objsiz (nb_ref, nb_char, nb_int, nb_flt, nb_ptr, nb_dbl: INTEGER): INTEGER is
			-- Size of an object having `nb_ref' references,
			-- `nb_char' characters, `nb_int' integers, `nb_flt' floats,
			-- `nb_ptr' pointers and `nb_dbl' doubles
		external
			"C"
		end;

	bitoff (bit_val: INTEGER): INTEGER is
			-- Size of a bit object of size `bit_val'
		external
			"C"
		end;

	chracs (n: INTEGER): INTEGER is
			-- Size of `n' characters
		external
			"C"
		end;

	refacs (n: INTEGER): INTEGER is
			-- Size of `n' references
		external
			"C"
		end;

	lngacs (n: INTEGER): INTEGER is
			-- Size of `n' integers
		external
			"C"
		end;

	fltacs (n: INTEGER): INTEGER is
			-- Size of `n' reals
		external
			"C"
		end;

	ptracs (n: INTEGER): INTEGER is
			-- Size of `n' pointers
		external
			"C"
		end;

	dblacs (n: INTEGER): INTEGER is
			-- Size of `n' doubles
		external
			"C"
		end;

	ovhsiz: INTEGER is
			-- Size of the object header
		external
			"C"
		end;

end
