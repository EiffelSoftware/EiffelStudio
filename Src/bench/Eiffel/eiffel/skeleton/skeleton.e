-- List of attribute sorted by category or skeleton of a class type (instance
-- of CLASS_TYPE).

class SKELETON 

inherit
	TO_SPECIAL [ATTR_DESC]
		rename
			item as area_item,
			put as area_put
		end
		
	SHARED_LEVEL
		export
			{ANY} all
		end;
	SHARED_WORKBENCH;
	SHARED_CODE_FILES;
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	COMPILER_EXPORTER
	SHARED_GENERATION
	SHARED_BYTE_CONTEXT
		export
			{ANY} context
		end

creation
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create a specific skeleton corresponding to a certain CLASS_TYPE
		do
			make_area (n)
			count := n
			position := 0
		end

feature -- Access

	count: INTEGER
			-- Number of items in skeleton.

	position: INTEGER
			-- Current position in skeleton.

	has_expanded: BOOLEAN
			-- Does skeleton have an expanded attribute?

	item: ATTR_DESC is
			-- Access `position'-th element.
		require
			good_range: position >= 0 and then position < count
		do
			Result := area.item (position)	
		end

feature -- Comparison

	equiv (other: SKELETON): BOOLEAN is
			-- Is the current skeleton equivqlent to `other' ?
		require
			good_argument: other /= Void
		local
			i, nb: INTEGER
			current_area, other_area: SPECIAL [ATTR_DESC]
		do
			nb := count
			if nb = other.count then
				from
					current_area := area
					other_area := other.area
					Result := True;
					i := 0
				until
					not Result or else i = nb
				loop
					Result := current_area.item (i).same_as (other_area.item (i));
					i := i + 1
				end;
			end;
		end;

feature -- Element change

	put (v: ATTR_DESC; i: INTEGER) is
			-- Replace `i'-th entry, if in index interval, by `v'.
		do
			area.put (v, i);
			has_expanded := has_expanded or else v.is_expanded
		end

feature -- Cursor movement

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		do
			position := position + 1
		end;

	go_to (pos: INTEGER) is
			-- Move cursor until `pos'
		do
			position := pos
		end

feature -- Status

	empty: BOOLEAN is
			-- Is there an item in current skeleton?
		do
			Result := count = 0
		end

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := position >= count
		end

	off: BOOLEAN is
			-- Is cursor position a valid one?
		do
			Result := position < 0 or else position >= count
		end

	first: ATTR_DESC is
		do
			Result := area.item (0)
		end

	has_feature_id (feature_id: INTEGER): BOOLEAN is
			-- Has the skeleton an attribute of feature id `feature_id' ?
		do
			search_feature_id (feature_id);
			Result := not (position = count);
		end;

	search_feature_id (feature_id: INTEGER) is
			-- Search an attribute description fo feature id `feature_id'
		require
			not empty
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
			found: BOOLEAN
		do
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				found or else i > nb
			loop
				found := current_area.item (i).feature_id = feature_id
				i := i + 1
			end
			if not found then
				position := nb
			else
				position := i - 1
			end
		end

	nb_reference: INTEGER is
			-- Numer of reference attributes
		do
			Result := nb_level (0, Reference_level);
		end;

	nb_character: INTEGER is
			-- Number of character and boolean attributes
			-- `nb_reference' has to be called before this function
		do
			Result := nb_level (position, Character_level) +
					  nb_level (position, Boolean_level) +
					  nb_level (position, Integer_8_level)
		end;

	nb_integer_16: INTEGER is
			-- Number of integer 16 bits attributes
			-- `nb_character' has to be called before this function
		do
			Result := nb_level (position, Integer_16_level) +
					nb_level (position, Wide_char_level)
		end

	nb_wide_char: INTEGER is
			-- Number of unicode characters
			-- `nb_integer_16' has to be called before this function
		do
			Result := nb_level (position, Wide_char_level);
		end

	nb_integer_32: INTEGER is
			-- Number of integer 32 bits attributes
			-- `nb_integer_16' has to be called before this function
		do
			Result := nb_level (position, Integer_32_level);
		end;

	nb_real: INTEGER is
			-- Number of real attributes
			-- `nb_integer_32' has to be called before this function
		do
			Result := nb_level (position, Real_level);
		end;

	nb_pointer: INTEGER is
			-- Number of pointer attributes
			-- `nb_real' has to be called before this function
		do
			Result := nb_level (position, Pointer_level);
		end;

	nb_integer_64: INTEGER is
			-- Number of integer 64 bits attributes
			-- `nb_pointer' has to be called before this function
		do
			Result := nb_level (position, Integer_64_level);
		end;

	nb_double: INTEGER is
			-- Number of double attributes
			-- `nb_integer_64' has to be called before this function
		do
			Result := nb_level (position, Double_level);
		end;

	nb_bits: INTEGER is
			-- Number of bits attribute
			-- `nb_double' has to be called before this function
		do
			Result := nb_level (position, Bits_level);
		end;

	nb_expanded: INTEGER is
			-- Number of expanded attributes
			-- `nb_bits' has to be called before this function
		do
			Result := nb_level (position, Expanded_level);
		end;
	
	nb_level (start_index, level: INTEGER): INTEGER is
			-- Number of item of level `level', when searching
			-- from `start_index'
		require
			good_level: level >= Reference_level and then level <= Expanded_level
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
			item_level: INTEGER
			done: BOOLEAN
		do
			if count /= 0 then
				from
					current_area := area
					i := start_index
					nb := count - 1
					if i <= nb then
						done := current_area.item (i).level > level
					end
				until
					done or else i > nb
				loop
					item_level := current_area.item (i).level
					if item_level < level then
							-- We are not on the requested level yet.
						i := i + 1
					else
						if item_level = level then
							Result := Result + 1
							i := i + 1
						else
								-- We are beyond the requested level.
							done := True
						end
					end
				end
				position := i
			end
		end

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
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb or else current_area.item (i).level >= level
			loop
				i := i + 1
			end;
			position := i
		end;

	generate_size (buffer: GENERATION_BUFFER) is
			-- Generate the size of current skeleton in `buffer'.
		require
			good_argument: buffer /= Void;
		local
			expanded_desc: EXPANDED_DESC;
			bit_desc: BITS_DESC;
			expanded_skeleton: SKELETON;
			nb_ref, nb_char, nb_int16, nb_int32, nb_int64: INTEGER
			nb_flt, nb_ptr, nb_dbl, nb_bit, nb_exp: INTEGER
			bits_pos, expanded_pos, i, nb: INTEGER
			current_area: SPECIAL [ATTR_DESC]
		do
			nb_ref := nb_reference
			nb_char := nb_character
			nb_int16 := nb_integer_16
			nb_int32 := nb_integer_32
			nb_flt := nb_real
			nb_ptr := nb_pointer
			nb_int64 := nb_integer_64
			nb_dbl := nb_double
				-- Record `position' where BIT description starts
			bits_pos := position
			nb_bit := nb_bits
				-- Record `position' where EXPANDED description starts
			expanded_pos := position
			nb_exp := nb_expanded

			buffer.putstring ("@OBJSIZ(");
			buffer.putint (nb_ref + nb_exp);
			buffer.putchar (',');
			buffer.putint (nb_char);
			buffer.putchar (',');
			buffer.putint (nb_int16);
			buffer.putchar (',');
			buffer.putint (nb_int32);
			buffer.putchar (',');
			buffer.putint (nb_flt);
			buffer.putchar (',');
			buffer.putint (nb_ptr);
			buffer.putchar (',');
			buffer.putint (nb_int64);
			buffer.putchar (',');
			buffer.putint (nb_dbl);
			buffer.putchar (')');

			from
					-- Go at the bits level
				current_area := area
				i := bits_pos
				nb := count - 1
			until
				i > nb or else current_area.item (i).level /= Bits_level
			loop
				bit_desc ?= current_area.item (i)
				buffer.putstring (" + OVERHEAD + @BITOFF(");
				buffer.putint (bit_desc.value);
				buffer.putchar (')');
				i := i + 1;
			end;

			from
					-- Go at the expanded level
				current_area := area
				i := expanded_pos
			until
				i > nb
			loop
				expanded_desc ?= current_area.item (i)
				expanded_skeleton := expanded_desc.class_type.skeleton;
				buffer.putstring (" + OVERHEAD +");
				expanded_skeleton.generate_size (buffer);
				i := i + 1;
			end;
		end;

	generate_workbench_size (buffer: GENERATION_BUFFER) is
			-- Generate size of the skeleton in workbench mode.
		do
			buffer.putint (workbench_size);
		end;

	workbench_size: INTEGER is
			-- Size of the current skeleton in workbench mode
		local
			expanded_desc: EXPANDED_DESC;
			bit_desc: BITS_DESC;
			expanded_skeleton: SKELETON;
			nb_ref, nb_char, nb_int16, nb_int32, nb_int64: INTEGER
			nb_flt, nb_ptr, nb_dbl, nb_bit, nb_exp: INTEGER
			bits_pos, expanded_pos, i, nb: INTEGER
			current_area: SPECIAL [ATTR_DESC]
		do
			nb_ref := nb_reference
			nb_char := nb_character
			nb_int16 := nb_integer_16
			nb_int32 := nb_integer_32
			nb_flt := nb_real
			nb_ptr := nb_pointer
			nb_int64 := nb_integer_64
			nb_dbl := nb_double
				-- Record `position' where BIT description starts
			bits_pos := position
			nb_bit := nb_bits
				-- Record `position' where EXPANDED description starts
			expanded_pos := position
			nb_exp := nb_expanded

			Result := objsiz(nb_ref + nb_exp, nb_char, nb_int16, nb_int32,
								nb_flt, nb_ptr, nb_int64, nb_dbl);

			current_area := area
			from
					-- Go at the bits level
				i := bits_pos
				nb := count - 1
			until
				i > nb or else current_area.item (i).level /= Bits_level
			loop
				bit_desc ?= current_area.item (i)
				Result := Result + ovhsiz + bitoff(bit_desc.value);
				i := i + 1;
			end;

			from
				i := expanded_pos
				nb := count - 1
			until
				i > nb
			loop
				expanded_desc ?= current_area.item (i)
				expanded_skeleton := expanded_desc.class_type.skeleton;
				Result := Result + ovhsiz + expanded_skeleton.workbench_size;
				i := i + 1;
			end;
		end;

	generate_offset (buffer: GENERATION_BUFFER; feature_id: INTEGER; is_in_attr_table: BOOLEAN) is
			-- Generate offset for attribute of feature id `feature_id'
			-- in `buffer'.
		require
			has_feature_id: has_feature_id (feature_id);
			good_argument: buffer /= Void;
		do
			search_feature_id (feature_id);
			generate (buffer, is_in_attr_table);
		end;

	offset (feature_id: INTEGER): INTEGER is
			-- Compute offset of `feature_id' in final code.
		require
			final_mode: context.final_mode
		do
			search_feature_id (feature_id)
			if has_expanded then
				Result := position
				if item.level > Reference_level then
					Result := Result + nb_level (0, Expanded_level)
				end
			else
				Result := position
			end
		end

	generate_workbench_offset (buffer: GENERATION_BUFFER; feature_id: INTEGER) is
			-- Generate offset for attribute of feature id `feature_id'
			-- in `buffer' in workbench mode only.
		require
			has_feature_id: has_feature_id (feature_id);
			good_argument: buffer /= Void;
		do
			search_feature_id (feature_id);
			buffer.putint (workbench_offset);
		end;

	generate (buffer: GENERATION_BUFFER; is_in_attr_table: BOOLEAN) is
			-- Generate offset of the attribute at the current position
		require
			not_off: not off;
			good_argument: buffer /= Void;
		local
			nb_ref, nb_char, nb_int16, nb_int32, nb_int64: INTEGER
			nb_flt, nb_ptr, nb_dbl: INTEGER
			bits_pos: INTEGER
			current_area: SPECIAL [ATTR_DESC]
			index, level, i: INTEGER
			expanded_desc: EXPANDED_DESC
			bit_desc: BITS_DESC
			value: INTEGER
		do
			level := item.level;
				-- Save index of current found item
			index := position
			inspect
				level
			when Reference_level then
				value := index
				if value /= 0 then
					buffer.putstring (" + @REFACS(");
					buffer.putint (value);
					buffer.putchar (')');
				elseif is_in_attr_table then
					buffer.putchar ('0')
				end
			when Character_level, Boolean_level, Integer_8_level then
				nb_ref := nb_reference;
				buffer.putstring ("+ @CHROFF(");
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (index - nb_ref)
				buffer.putchar (')');
			when Integer_16_level, Wide_char_level then
				nb_ref := nb_reference
				nb_char := nb_character
				buffer.putstring ("+ @I16OFF(")
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (nb_char);
				buffer.putchar (',');
				buffer.putint (index - nb_ref - nb_char)
				buffer.putchar (')');
			when Integer_32_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				buffer.putstring ("+ @LNGOFF(");
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (nb_char);
				buffer.putchar (',');
				buffer.putint (nb_int16);
				buffer.putchar (',');
				buffer.putint (index - nb_ref - nb_char - nb_int16 )
				buffer.putchar (')');
			when Real_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				buffer.putstring ("+ @FLTOFF(");
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (nb_char);
				buffer.putchar (',');
				buffer.putint (nb_int16);
				buffer.putchar (',');
				buffer.putint (nb_int32);
				buffer.putchar (',');
				buffer.putint (index - nb_ref - nb_char - nb_int16 - nb_int32)
				buffer.putchar (')');
			when Pointer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				buffer.putstring ("+ @PTROFF(");
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (nb_char);
				buffer.putchar (',');
				buffer.putint (nb_int16);
				buffer.putchar (',');
				buffer.putint (nb_int32);
				buffer.putchar (',');
				buffer.putint (nb_flt);
				buffer.putchar (',');
				buffer.putint (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_flt)
				buffer.putchar (')');
			when Integer_64_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				buffer.putstring ("+ @I64OFF(");
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (nb_char);
				buffer.putchar (',');
				buffer.putint (nb_int16);
				buffer.putchar (',');
				buffer.putint (nb_int32);
				buffer.putchar (',');
				buffer.putint (nb_flt);
				buffer.putchar (',');
				buffer.putint (nb_ptr);
				buffer.putchar (',');
				buffer.putint (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_flt - nb_ptr)
				buffer.putchar (')');
			when Double_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64
				buffer.putstring ("+ @DBLOFF(");
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (nb_char);
				buffer.putchar (',');
				buffer.putint (nb_int16);
				buffer.putchar (',');
				buffer.putint (nb_int32);
				buffer.putchar (',');
				buffer.putint (nb_flt);
				buffer.putchar (',');
				buffer.putint (nb_ptr);
				buffer.putchar (',');
				buffer.putint (nb_int64);
				buffer.putchar (',');
				buffer.putint (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_flt - nb_ptr - nb_int64)
				buffer.putchar (')');
			else
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64
				nb_dbl := nb_double;
					-- Save where the Bit level start
				bits_pos := position
				buffer.putstring ("+ @OBJSIZ(");
				buffer.putint (nb_ref + nb_expanded);
				buffer.putchar (',');
				buffer.putint (nb_char);
				buffer.putchar (',');
				buffer.putint (nb_int16);
				buffer.putchar (',');
				buffer.putint (nb_int32);
				buffer.putchar (',');
				buffer.putint (nb_flt);
				buffer.putchar (',');
				buffer.putint (nb_ptr);
				buffer.putchar (',');
				buffer.putint (nb_int64);
				buffer.putchar (',');
				buffer.putint (nb_dbl);
				buffer.putchar (')');
				if level = Bits_level then
					from
						current_area := area
						i := bits_pos
					until
						i >= index
					loop
						buffer.putstring (" + OVERHEAD + @BITOFF(");
						bit_desc ?= current_area.item (i);
						buffer.putint (bit_desc.value);
						buffer.putchar (')');
						i := i + 1;
					end;
					buffer.putstring (" + OVERHEAD");
				else
					current_area := area
					from
						i := bits_pos
					until
						current_area.item(i).level > Bits_level
					loop
						buffer.putstring (" + OVERHEAD + @BITOFF(");
						bit_desc ?= current_area.item (i);
						buffer.putint (bit_desc.value);
						buffer.putchar (')');
						i := i + 1;
					end;

					from
					until
						i >= index
					loop
						buffer.putstring (" + OVERHEAD + ");
						expanded_desc ?= current_area.item (i)
						expanded_desc.class_type.skeleton.generate_size (buffer);
						i := i + 1
					end;
					buffer.putstring (" + OVERHEAD");
				end;
			end;

				-- Restore previous position
			position := index
		end;

	workbench_offset: INTEGER is
			-- Offset of the attribute at the current position in
			-- workbench mode
		require
			not_off: not off;
		local
			nb_ref, nb_char, nb_int16, nb_int32: INTEGER
			nb_int64, nb_flt, nb_dbl, nb_ptr: INTEGER
			index, level, bits_pos: INTEGER
			i: INTEGER
			expanded_desc: EXPANDED_DESC
			bit_desc: BITS_DESC
			exp_skel: SKELETON
			current_area: SPECIAL [ATTR_DESC]
		do
			level := item.level;
				-- Save index of current found item
			index := position
			inspect
				level
			when Reference_level then
				Result := refacs (index);
			when Character_level, Boolean_level, Integer_8_level then
				nb_ref := nb_reference;
				Result := chroff (nb_ref + nb_expanded) + chracs (index - nb_ref);
			when Integer_16_level, Wide_char_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				Result := i16off (nb_ref + nb_expanded, nb_char) +
							i16acs (index - nb_ref - nb_char);
			when Integer_32_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				Result := i32off (nb_ref + nb_expanded, nb_char, nb_int16) +
							i32acs (index - nb_ref - nb_char - nb_int16);
			when Real_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				Result := fltoff (nb_ref + nb_expanded, nb_char, nb_int16, nb_int32) +
							fltacs (index - nb_ref - nb_char - nb_int16 - nb_int32); 
			when Pointer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				Result := ptroff (nb_ref + nb_expanded, nb_char, nb_int16, nb_int32, nb_flt) +
							ptracs (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_flt);
			when Integer_64_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				Result := i64off (nb_ref+nb_expanded,nb_char,nb_int16,nb_int32,nb_flt,nb_ptr) +
							dblacs (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_flt - nb_ptr);
			when Double_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64;
				Result := dbloff (nb_ref+nb_expanded,nb_char,nb_int16,nb_int32,nb_flt,nb_ptr,nb_int64) +
							dblacs (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_flt - nb_ptr - nb_int64);
			else
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_flt := nb_real;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64;
				nb_dbl := nb_double;
					-- Save where the Bit level start
				bits_pos := position
				Result := objsiz (nb_ref+nb_expanded,nb_char,nb_int16,nb_int32,nb_flt,nb_ptr,nb_int64,nb_dbl);
				if level = Bits_level then
					from
						current_area := area
						i := bits_pos
					until
						i >= index
					loop
						bit_desc ?= current_area.item (i)
						Result := Result + ovhsiz + bitoff(bit_desc.value);
						i := i + 1
					end;
					Result := Result + ovhsiz;
				else
					from
						current_area := area
						i := bits_pos
					until
						current_area.item (i).level > Bits_level
					loop
						bit_desc ?= current_area.item (i);
						Result := Result + ovhsiz + bitoff(bit_desc.value);
						i := i + 1;
					end;

					from
					until
						i >= index
					loop
						expanded_desc ?= current_area.item (i);
						exp_skel := expanded_desc.class_type.skeleton;
						Result := Result + ovhsiz + exp_skel.workbench_size;
						i := i + 1
					end;
					Result := Result + ovhsiz;
				end;
			end;
		end;

feature -- Skeleton byte code
	
	make_names_byte_code (ba: BYTE_ARRAY) is
			-- Generate attribute names in `ba'.
		require
			good_argument: ba /= Void
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				ba.append_string (current_area.item (i).attribute_name);
				i := i + 1;
			end;
		end;

	make_rout_id_array (ba: BYTE_ARRAY) is
			-- Generate routine id array in `ba'.
		require
			good_argument: ba /= Void
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				ba.append_int32_integer (current_area.item (i).rout_id);
				i := i + 1;
			end;
		end;

	make_type_byte_code (ba: BYTE_ARRAY) is
			-- Generate meta-type array byte code
		require
			good_argument: ba /= Void
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			from
				current_area := area
				i := 0
				nb := count - 1	
			until
				i > nb
			loop
				ba.append_uint32_integer (current_area.item (i).sk_value)
				i := i + 1
			end;
		end;

	make_gen_type_byte_code (ba: BYTE_ARRAY) is
			-- Generate full type array byte code
		require
			good_argument: ba /= Void
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
			edesc: EXPANDED_DESC
		do
			from
				current_area := area
				i := 0
				nb := count - 1	
			until
				i > nb
			loop
				edesc ?= current_area.item (i)
				if edesc /= Void then
					ba.append_short_integer (1)
					edesc.make_gen_type_byte_code (ba)
				else
					ba.append_short_integer (0)
				end
				i := i + 1
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
				-- Generate byte code description of attribute at the current
				-- description
			ba.append_integer (workbench_offset);
		end;

	generate_name_array is
			-- Generate static C array of attributes names in the
			-- skeleton file.
		require
			not empty;
		local
			buffer: GENERATION_BUFFER
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			buffer := generation_buffer
			buffer.putchar ('{');
			buffer.new_line;
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				buffer.putchar ('"');
				buffer.putstring (current_area.item (i).attribute_name);
				buffer.putstring ("%",%N");
				i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end;

	generate_type_array is
			-- Generate static C array of attributes type codes in the
			-- skeleton file.
		require
			not empty;
		local
			buffer: GENERATION_BUFFER
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			buffer := generation_buffer
			buffer.putchar ('{');
			buffer.new_line;
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				current_area.item (i).generate_code (buffer);
				buffer.putstring (",%N");
				i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end;

	generate_generic_type_arrays (code : INTEGER) is
			-- Generate static C arrays of attributes full type codes in the
			-- skeleton file.
		require
			not empty;
		local
			buffer: GENERATION_BUFFER
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
			edesc: EXPANDED_DESC
		do
			buffer := generation_buffer
			current_area := area

			from
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				edesc ?= current_area.item (i)
				if edesc /= Void then
					edesc.generate_generic_code (buffer, code, i);
				end
				i := i + 1;
			end;
			buffer.new_line;
			buffer.putstring ("static int16 *gtypes")
			buffer.putint (code)
			buffer.putstring (" [] = {%N")

			from
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				edesc ?= current_area.item (i)
				if edesc /= Void then
					buffer.putstring ("g_atype")
					buffer.putint (code)
					buffer.putchar ('_')
					buffer.putint (i)
				else
					buffer.putstring ("(int16*)0")
				end
				buffer.putstring (",%N")
				i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end;

	generate_offset_array is
			-- Generate static C array of attributes offset table pointers.
		require
			not empty;
		local
			buffer: GENERATION_BUFFER
--			rout_id: INTEGER
--			tbl: ATTR_TABLE
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			buffer := generation_buffer
			buffer.putchar ('{');
			buffer.new_line;
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
--				rout_id := current_area.item (i).rout_id;
--				tbl ?= Eiffel_table.poly_table (rout_id);
					--| In this instruction, we put `True' as second
					--| arguments. This means we will generate something if there is nothing
					--| to generate (ie `0'). Remember that `False' is used in all other case
--				generate_offset (buffer, tbl.first.feature_id, True)
				position := i
				generate (buffer, True)
				buffer.putstring (",%N");
				 i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end;

	generate_rout_id_array is
			-- Generate static C array of attributes routine ids
		require
			not empty;
		local
			buffer: GENERATION_BUFFER
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			buffer := generation_buffer
			buffer.putchar ('{');
			buffer.new_line;
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				buffer.putint (current_area.item (i).rout_id);
				buffer.putstring (",%N");
				i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end;

feature -- Sort

	sort is
			-- Sort skeleton in ascending order.
		do
			quick_sort (0, count - 1)
		end

feature {NONE} -- Implementation of quick sort algorithm

	quick_sort (min, max: INTEGER) is
			-- Apply `quick_sort' algorithm.
			-- If `max' < `min' then it stops.
		local
			pivo_index: INTEGER
		do
			if min < max then
				pivo_index := partition_quick_sort (min, max)
				quick_sort (min, pivo_index - 1)
				quick_sort (pivo_index + 1, max)
			end
		end

	partition_quick_sort  (min, max: INTEGER): INTEGER is
			-- Apply `quick_sort' algorithm to position [`min'..`max']
		require
			correct_bounds: min <= max
		local
			up, down: INTEGER
			x, temp: ATTR_DESC 
			current_area: SPECIAL [ATTR_DESC]
		do
			current_area := area
				-- Define the pivot value as the first element of table
			x := current_area.item (min)

				-- Initialize UP to first
			up := min

				-- Initialize DOWN to last
			down := max

			from
			until
				up >= down    -- Repeat until up meets or passes down
			loop
					-- Increment up until up selects the first element
					-- greater than the pivot value
				from
				until
					up >= max or else current_area.item (up) > x
				loop
					up := up + 1
				end
			
					-- Decrement down until it selects the first element
					-- lesser than or equal to the pivot
				from
				until
					current_area.item (down) <= x
				loop
					down := down - 1
				end

				if up < down then
						-- If up < down  exchange their values until up
						-- meets or passes down
					temp := current_area.item (up)
					current_area.put (current_area.item (down), up)
					current_area.put (temp, down)
				end
			end

			temp := current_area.item (down)
			current_area.put (current_area.item (min), down)
			current_area.put (temp, min)
			Result := down
		end

feature -- Trace

	trace is
			-- Debug purpose
		local
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				io.error.putstring (current_area.item (i).attribute_name);
				io.error.putstring (": ");
				item.trace;
				io.error.new_line;
				i := i + 1;
			end;
		end

feature {NONE} -- Externals

	chroff(nb_ref: INTEGER): INTEGER is
			-- Offset of first character after `nb_ref' references
		external
			"C"
		end;

	i16off(nb_ref, nb_char: INTEGER): INTEGER is
			-- Offset of first integer 16 bits after `nb_ref' references,
			-- and `nb_char' characters
		external
			"C"
		end;

	i32off(nb_ref, nb_char, nb_int16: INTEGER): INTEGER is
			-- Offset of first integer 32 bits after `nb_ref' references,
			-- `nb_char' characters and `nb_int16' integers.
		external
			"C"
		alias
			"lngoff"
		end;

	fltoff (nb_ref, nb_char, nb_int16, nb_int32: INTEGER): INTEGER is
			-- Offset of first float after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers and `nb_int32' integers
		external
			"C"
		end;

	ptroff (nb_ref, nb_char, nb_int16, nb_int32, nb_flt: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers
			-- and `nb_flt' floats
		external
			"C"
		end;

	i64off (nb_ref, nb_char, nb_int16, nb_int32, nb_flt, nb_ptr: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers,
			-- `nb_flt' floats and `nb_ptr' pointers.
		external
			"C"
		end;

	dbloff (nb_ref, nb_char, nb_int16, nb_int32, nb_flt, nb_ptr, nb_int64: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers,
			-- `nb_flt' floats, `nb_ptr' pointers and `nb_int64' integers.
		external
			"C"
		end;

	objsiz (nb_ref, nb_char, nb_int16, nb_int32, nb_flt, nb_ptr, nb_int64, nb_dbl: INTEGER): INTEGER is
			-- Size of an object having `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers,
			-- `nb_flt' floats, `nb_ptr' pointers, `nb_int64' integers and `nb_dbl' doubles
		external
			"C"
		end;

	bitoff (bit_val: INTEGER): INTEGER is
			-- Size of a bit object of size `bit_val'
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"BITOFF"
		end;

	chracs (n: INTEGER): INTEGER is
			-- Size of `n' characters
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"CHRACS"
		end;

	refacs (n: INTEGER): INTEGER is
			-- Size of `n' references
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"REFACS"
		end;

	i16acs (n: INTEGER): INTEGER is
			-- size of `n' integers 16 bits.
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"I16ACS"
		end

	i32acs (n: INTEGER): INTEGER is
			-- Size of `n' integers 32 bits
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"LNGACS"
		end;

	i64acs (n: INTEGER): INTEGER is
			-- Size of `n' integers 64 bits
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"I64ACS"
		end;

	fltacs (n: INTEGER): INTEGER is
			-- Size of `n' reals
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"FLTACS"
		end;

	ptracs (n: INTEGER): INTEGER is
			-- Size of `n' pointers
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"PTRACS"
		end;

	dblacs (n: INTEGER): INTEGER is
			-- Size of `n' doubles
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"DBLACS"
		end;

	ovhsiz: INTEGER is
			-- Size of the object header
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"OVERHEAD"
		end;

end
