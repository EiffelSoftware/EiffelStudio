indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- List of attribute sorted by category or skeleton of a class type (instance
-- of CLASS_TYPE).

class SKELETON

inherit
	SHARED_LEVEL
		export
			{ANY} all
		end;
	SHARED_WORKBENCH;
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	COMPILER_EXPORTER
	SHARED_GENERATION
	SHARED_BYTE_CONTEXT
		export
			{ANY} context
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER; a_class_type: CLASS_TYPE) is
			-- Create a specific skeleton corresponding to a certain CLASS_TYPE
		require
			n_non_negative: n >= 0
		do
			create area.make (n)
			count := n
			position := 0
			class_type := a_class_type
		ensure
			count_set: count = n
		end

feature -- Update

	update is
			-- Sort `area' so that skeleton goes from the lowest level
			-- to the higher level. Precompute the count of each type
			-- of attributes.
		local
			i, nb, level: INTEGER
		do
			create nb_attributes.make (level_count + 1)
			from
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				level := area.item (i).level
				nb_attributes.put (nb_attributes.item (level) + 1, level)
				i := i + 1
			end
			quick_sort (0, count - 1)
		end

feature -- Access

	class_type: CLASS_TYPE
			-- Associated class_type

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

feature {SKELETON} -- Implementation: Access

	area: SPECIAL [ATTR_DESC]
			-- Storage

feature {NONE} -- Implementation: Access

	nb_attributes: SPECIAL [INTEGER]
			-- Record cound for each type of attribute.

feature -- Status Report

	has_references: BOOLEAN is
			-- Does current have some references (i.e. true reference,
			-- fake references for referencing expanded objects)
		do
			Result := (nb_reference + nb_expanded) > 0
		end

feature -- Comparison

	equiv (old_skeletons: ARRAY [SKELETON]; other: SKELETON): BOOLEAN is
			-- Is the current skeleton equivalent to `other'?
			-- For expanded attribute, we use the old version of its
			-- associated skeleton (stored in old_skeletons which is indexed
			-- by `type_id') to ensure that it did not change.
		require
			old_skeletons_not_void: old_skeletons /= Void
			good_argument: other /= Void
		local
			i, nb, expanded_pos: INTEGER
			current_area, other_area: SPECIAL [ATTR_DESC]
			l_exp_desc: EXPANDED_DESC
			l_old_skel: SKELETON
			l_exp_class_type: CLASS_TYPE
		do
			nb := count
			if nb = other.count then
					-- First pass to ensure it is identical.
				from
					expanded_pos := -1
					current_area := area
					other_area := other.area
					Result := True;
					i := 0
				until
					not Result or else i = nb
				loop
					Result := current_area.item (i).same_as (other_area.item (i))
					check
						attribute_not_formal: current_area.item (i).level /= Formal_level
					end
					if expanded_pos = -1 and then current_area.item (i).level = Expanded_level then
						expanded_pos := i
					end
					i := i + 1
				end;
					-- Second pass for expanded attributes only. This is where we check that the
					-- skeleton for the expanded type did not change. And we do it recursively
					-- until we do not find anymore expanded attributes. Fixes eweasel test melt015
					-- and possibly others.
				if Result and then expanded_pos >= 0 then
					check
						expanded_pos_in_range: expanded_pos < nb
					end
					from
						i := expanded_pos
					invariant
						expanded_attribute: i < nb implies current_area.item (i).level = Expanded_level
					until
						not Result or else i = nb
					loop
						l_exp_desc ?= current_area.item (i)
						check
							l_exp_desc_not_void: l_exp_desc /= Void
						end
						l_exp_class_type := l_exp_desc.class_type
						l_old_skel := old_skeletons.item (l_exp_class_type.type_id)
						if l_old_skel /= Void then
								-- We now checks the old skeleton associated to `l_exp_desc' with a
								-- new one that we generate on the fly. It is definitely not the
								-- most efficient way because of the creation of a skeleton we will
								-- not use, but at least do the correct job at finding if a skeleton
								-- of a class having expanded attributes has changed.
							if l_exp_class_type.associated_class.skeleton /= Void then
								Result := l_old_skel.equiv (old_skeletons,
									l_exp_class_type.associated_class.skeleton.
										instantiation_in (l_exp_class_type))
							else
									-- Most likeley an external class, therefore its skeleton
									-- did not change.
									-- FIXME: Manu: 08/05/2003: Should we create a skeleton even
									-- for external classes, to avoid this particular case of
									-- checking voidness of `skeleton' from CLASS_C.
							end
						else
							if l_exp_class_type.associated_class.is_external then
									-- A .NET external class so we cannot tell if the skeleton
									-- changed
									-- FIXME: Manu: 10/27/2003: What if we handle incremental
									-- changes of external classes?
								Result := True
							else
									-- Previous skeleton did not exist, then it definitely changed.
								Result := False
							end
						end
						i := i + 1
					end
				end
			end;
		end;

feature -- Element change

	extend (v: ATTR_DESC) is
			-- Extend Current with `v' after `position'.
		do
			area.put (v, position)
			position := position + 1;
			has_expanded := has_expanded or else v.is_expanded
		end

feature -- Cursor movement

	start is
			-- Move cursor to the first position.
		do
			position := 0
		end

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
			if found then
				position := i - 1
			else
				position := nb + 1
				check
					position = count
				end
			end
		end

	nb_reference: INTEGER is
			-- Numer of reference attributes
		do
			Result := nb_attributes.item (reference_level)
		end;

	nb_character: INTEGER is
			-- Number of character and boolean attributes
		local
			l_nb_attributes: like nb_attributes
		do
			l_nb_attributes := nb_attributes
			Result := l_nb_attributes.item (character_level) +
				l_nb_attributes.item (boolean_level) +
				l_nb_attributes.item (integer_8_level) +
				l_nb_attributes.item (natural_8_level)
		end;

	nb_integer_16: INTEGER is
			-- Number of integer 16 bits attributes
		local
			l_nb_attributes: like nb_attributes
		do
			l_nb_attributes := nb_attributes
			Result := l_nb_attributes.item (integer_16_level) +
				l_nb_attributes.item (natural_16_level)
		end

	nb_integer_32: INTEGER is
			-- Number of integer 32 bits attributes
		local
			l_nb_attributes: like nb_attributes
		do
			l_nb_attributes := nb_attributes
			Result := l_nb_attributes.item (integer_32_level) +
				l_nb_attributes.item (natural_32_level) +
				l_nb_attributes.item (wide_char_level)
		end;

	nb_real_32: INTEGER is
			-- Number of real attributes
		do
			Result := nb_attributes.item (real_32_level)
		end;

	nb_pointer: INTEGER is
			-- Number of pointer attributes
		do
			Result := nb_attributes.item (pointer_level)
		end;

	nb_integer_64: INTEGER is
			-- Number of integer 64 bits attributes
		local
			l_nb_attributes: like nb_attributes
		do
			l_nb_attributes := nb_attributes
			Result := l_nb_attributes.item (integer_64_level) +
				l_nb_attributes.item (natural_64_level)
		end

	nb_real_64: INTEGER is
			-- Number of real 64 bits attributes
		do
			Result := nb_attributes.item (real_64_level)
		end;

	nb_bits: INTEGER is
			-- Number of bits attribute
		do
			Result := nb_attributes.item (bits_level)
		end;

	nb_expanded: INTEGER is
			-- Number of expanded attributes
		do
			Result := nb_attributes.item (expanded_level)
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
			level >= Reference_level and then level <= Expanded_level
		local
			l_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			from
				l_area := area
				i := 0
				nb := count - 1
			until
				i > nb or else l_area.item (i).level >= level
			loop
				i := i + 1
			end;
			position := i
		end;

	generate_size (buffer: GENERATION_BUFFER; as_macro: BOOLEAN) is
			-- Generate the size of current skeleton in `buffer'.
		require
			good_argument: buffer /= Void;
		local
			expanded_desc: EXPANDED_DESC
			bit_desc: BITS_DESC
			expanded_skeleton: SKELETON
			nb_ref, nb_char, nb_int16, nb_int32, nb_int64: INTEGER
			nb_r32, nb_ptr, nb_r64, nb_bit, nb_exp: INTEGER
			i, nb: INTEGER
			current_area: SPECIAL [ATTR_DESC]
			l_def_buffer: like buffer
		do
			nb_ref := nb_reference
			nb_char := nb_character
			nb_int16 := nb_integer_16
			nb_int32 := nb_integer_32
			nb_r32 := nb_real_32
			nb_ptr := nb_pointer
			nb_int64 := nb_integer_64
			nb_r64 := nb_real_64
			nb_bit := nb_bits
			nb_exp := nb_expanded

			l_def_buffer := definition_buffer
			l_def_buffer.clear_all

			l_def_buffer.put_string ("@OBJSIZ(")
			l_def_buffer.put_integer (nb_ref + nb_exp)
			l_def_buffer.put_character (',')
			l_def_buffer.put_integer (nb_char)
			l_def_buffer.put_character (',')
			l_def_buffer.put_integer (nb_int16)
			l_def_buffer.put_character (',')
			l_def_buffer.put_integer (nb_int32)
			l_def_buffer.put_character (',')
			l_def_buffer.put_integer (nb_r32)
			l_def_buffer.put_character (',')
			l_def_buffer.put_integer (nb_ptr)
			l_def_buffer.put_character (',')
			l_def_buffer.put_integer (nb_int64)
			l_def_buffer.put_character (',')
			l_def_buffer.put_integer (nb_r64)
			l_def_buffer.put_character (')')
			insert_in_buffer (buffer, l_def_buffer, as_macro)

			if nb_bit > 0 then
				from
						-- Go at the bits level
					current_area := area
					go_bits
					i := position
					nb := count - 1
				until
					i > nb or else current_area.item (i).level /= Bits_level
				loop
					bit_desc ?= current_area.item (i)
					buffer.put_string (" + OVERHEAD + ")
					l_def_buffer.put_string ("@BITOFF(")
					l_def_buffer.put_integer (bit_desc.value)
					l_def_buffer.put_character (')')
					insert_in_buffer (buffer, l_def_buffer, as_macro)
					i := i + 1
				end
			end

			if nb_exp > 0 then
				from
						-- Go at the expanded level
					current_area := area
					go_expanded
					i := position
					nb := count - 1
				until
					i > nb
				loop
					expanded_desc ?= current_area.item (i)
					expanded_skeleton := expanded_desc.class_type.skeleton
					buffer.put_string (" + OVERHEAD +")
					expanded_skeleton.generate_size (buffer, as_macro)
					i := i + 1
				end
			end
		end

	generate_workbench_size (buffer: GENERATION_BUFFER) is
			-- Generate size of the skeleton in workbench mode.
		do
			buffer.put_integer (workbench_size);
		end;

	workbench_size: INTEGER is
			-- Size of the current skeleton in workbench mode
		local
			expanded_desc: EXPANDED_DESC;
			bit_desc: BITS_DESC;
			expanded_skeleton: SKELETON;
			nb_ref, nb_char, nb_int16, nb_int32, nb_int64: INTEGER
			nb_r32, nb_ptr, nb_r64, nb_bit, nb_exp: INTEGER
			i, nb: INTEGER
			current_area: SPECIAL [ATTR_DESC]
		do
			nb_ref := nb_reference
			nb_char := nb_character
			nb_int16 := nb_integer_16
			nb_int32 := nb_integer_32
			nb_r32 := nb_real_32
			nb_ptr := nb_pointer
			nb_int64 := nb_integer_64
			nb_r64 := nb_real_64
			nb_bit := nb_bits
			nb_exp := nb_expanded

			Result := eif_objsiz(nb_ref + nb_exp, nb_char, nb_int16, nb_int32,
								nb_r32, nb_ptr, nb_int64, nb_r64);

			if nb_bit > 0 then
				from
						-- Go at the bits level
					current_area := area
					go_bits
					i := position
					nb := count - 1
				until
					i > nb or else current_area.item (i).level /= Bits_level
				loop
					bit_desc ?= current_area.item (i)
					Result := Result + ovhsiz + bitoff(bit_desc.value)
					i := i + 1
				end
			end

			if nb_exp > 0 then
				from
					current_area := area
					go_expanded
					i := position
					nb := count - 1
				until
					i > nb
				loop
					expanded_desc ?= current_area.item (i)
					expanded_skeleton := expanded_desc.class_type.skeleton
					Result := Result + ovhsiz + expanded_skeleton.workbench_size
					i := i + 1
				end
			end
		end

	generate_offset (buffer: GENERATION_BUFFER; feature_id: INTEGER; is_in_attr_table, as_macro: BOOLEAN) is
			-- Generate offset for attribute of feature id `feature_id'
			-- in `buffer'.
		require
			has_feature_id: has_feature_id (feature_id);
			good_argument: buffer /= Void;
		do
			search_feature_id (feature_id);
			generate (buffer, is_in_attr_table, as_macro);
		end;

	generate_i_th_reference_offset (buffer: GENERATION_BUFFER; i: INTEGER; as_macro: BOOLEAN) is
			-- Generate offset for reference attribute at position `i' in `buffer'.
		require
			good_argument: buffer /= Void;
			i_non_negative: i >= 0
		local
			l_def_buffer: like definition_buffer
		do
			if i /= 0 then
				l_def_buffer := definition_buffer
				l_def_buffer.clear_all
				buffer.put_three_character (' ', '+', ' ')
				l_def_buffer.put_string ("@REFACS(");
				l_def_buffer.put_integer (i);
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			end
		end;

	generate_workbench_offset (buffer: GENERATION_BUFFER; feature_id: INTEGER) is
			-- Generate offset for attribute of feature id `feature_id'
			-- in `buffer' in workbench mode only.
		require
			has_feature_id: has_feature_id (feature_id);
			good_argument: buffer /= Void;
		do
			search_feature_id (feature_id);
			buffer.put_integer (workbench_offset);
		end;

	generate (buffer: GENERATION_BUFFER; is_in_attr_table, as_macro: BOOLEAN) is
			-- Generate offset of the attribute at the current position
		require
			not_off: not off;
			good_argument: buffer /= Void;
		local
			nb_ref, nb_char, nb_int16, nb_int32, nb_int64: INTEGER
			nb_r32, nb_ptr, nb_r64: INTEGER
			current_area: SPECIAL [ATTR_DESC]
			index, level, i: INTEGER
			expanded_desc: EXPANDED_DESC
			bit_desc: BITS_DESC
			value: INTEGER
			l_def_buffer: like buffer
		do
			l_def_buffer := definition_buffer
			l_def_buffer.clear_all

			level := item.level;
				-- Save index of current found item
			index := position

			inspect
				level
			when Reference_level then
				value := index
				if value /= 0 then
					buffer.put_three_character (' ', '+', ' ')
					l_def_buffer.put_string ("@REFACS(");
					l_def_buffer.put_integer (value);
					l_def_buffer.put_character (')');
					insert_in_buffer (buffer, l_def_buffer, as_macro)
				elseif is_in_attr_table then
					buffer.put_character ('0')
				end
			when Character_level, Boolean_level, Integer_8_level, natural_8_level then
				nb_ref := nb_reference;
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@CHROFF(");
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (index - nb_ref)
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			when Integer_16_level, natural_16_level then
				nb_ref := nb_reference
				nb_char := nb_character
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@I16OFF(")
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_char);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (index - nb_ref - nb_char)
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			when Integer_32_level, natural_32_level, wide_char_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@LNGOFF(");
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_char);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int16);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (index - nb_ref - nb_char - nb_int16 )
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			when Real_32_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@R32OFF(");
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_char);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int16);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (index - nb_ref - nb_char - nb_int16 - nb_int32)
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			when Pointer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@PTROFF(");
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_char);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int16);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_r32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_r32)
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			when Integer_64_level, natural_64_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				nb_ptr := nb_pointer;
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@I64OFF(");
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_char);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int16);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_r32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_ptr);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_r32 - nb_ptr)
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			when Real_64_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@R64OFF(");
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_char);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int16);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_r32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_ptr);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int64);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_r32 - nb_ptr - nb_int64)
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
			else
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64
				nb_r64 := nb_real_64;
				buffer.put_two_character ('+', ' ')
				l_def_buffer.put_string ("@OBJSIZ(");
				l_def_buffer.put_integer (nb_ref + nb_expanded);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_char);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int16);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_r32);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_ptr);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_int64);
				l_def_buffer.put_character (',');
				l_def_buffer.put_integer (nb_r64);
				l_def_buffer.put_character (')');
				insert_in_buffer (buffer, l_def_buffer, as_macro)
				if level = Bits_level then
					from
						current_area := area
						go_bits
						i := position
					until
						i >= index
					loop
						buffer.put_string (" + OVERHEAD + ")
						l_def_buffer.put_string ("@BITOFF(");
						bit_desc ?= current_area.item (i);
						l_def_buffer.put_integer (bit_desc.value);
						l_def_buffer.put_character (')');
						insert_in_buffer (buffer, l_def_buffer, as_macro)
						i := i + 1;
					end;
					buffer.put_string (" + OVERHEAD");
				else
					if nb_bits > 0 then
						from
							current_area := area
							go_bits
							i := position
						until
							current_area.item(i).level > Bits_level
						loop
							buffer.put_string (" + OVERHEAD + ")
							l_def_buffer.put_string ("@BITOFF(")
							bit_desc ?= current_area.item (i)
							l_def_buffer.put_integer (bit_desc.value)
							l_def_buffer.put_character (')')
							insert_in_buffer (buffer, l_def_buffer, as_macro)
							i := i + 1
						end
					end

					if nb_expanded > 0 then
						from
							current_area := area
							go_expanded
							i := position
						until
							i >= index
						loop
							buffer.put_string (" + OVERHEAD + ")
							expanded_desc ?= current_area.item (i)
							expanded_desc.class_type.skeleton.generate_size (buffer, as_macro)
							i := i + 1
						end
						buffer.put_string (" + OVERHEAD")
					end
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
			nb_int64, nb_r32, nb_r64, nb_ptr: INTEGER
			index, level: INTEGER
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
			when Character_level, Boolean_level, Integer_8_level, natural_8_level then
				nb_ref := nb_reference;
				Result := eif_chroff (nb_ref + nb_expanded) + chracs (index - nb_ref);
			when Integer_16_level, natural_16_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				Result := eif_i16off (nb_ref + nb_expanded, nb_char) +
							i16acs (index - nb_ref - nb_char);
			when Integer_32_level, natural_32_level, wide_char_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				Result := eif_i32off (nb_ref + nb_expanded, nb_char, nb_int16) +
							i32acs (index - nb_ref - nb_char - nb_int16);
			when Real_32_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				Result := eif_r32off (nb_ref + nb_expanded, nb_char, nb_int16, nb_int32) +
							r32acs (index - nb_ref - nb_char - nb_int16 - nb_int32);
			when Pointer_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				Result := eif_ptroff (nb_ref + nb_expanded, nb_char, nb_int16, nb_int32, nb_r32) +
							ptracs (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_r32);
			when Integer_64_level, natural_64_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				nb_ptr := nb_pointer;
				Result := eif_i64off (nb_ref+nb_expanded,nb_char,nb_int16,nb_int32,nb_r32,nb_ptr) +
							r64acs (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_r32 - nb_ptr);
			when Real_64_level then
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64;
				Result := eif_r64off (nb_ref+nb_expanded,nb_char,nb_int16,nb_int32,nb_r32,nb_ptr,nb_int64) +
							r64acs (index - nb_ref - nb_char - nb_int16 - nb_int32 - nb_r32 - nb_ptr - nb_int64);
			else
				nb_ref := nb_reference;
				nb_char := nb_character;
				nb_int16 := nb_integer_16
				nb_int32 := nb_integer_32;
				nb_r32 := nb_real_32;
				nb_ptr := nb_pointer;
				nb_int64 := nb_integer_64;
				nb_r64 := nb_real_64;
				Result := eif_objsiz (nb_ref+nb_expanded,nb_char,nb_int16,nb_int32,nb_r32,nb_ptr,nb_int64,nb_r64);
				if level = Bits_level then
					from
						current_area := area
						go_bits
						i := position
					until
						i >= index
					loop
						bit_desc ?= current_area.item (i)
						Result := Result + ovhsiz + bitoff(bit_desc.value);
						i := i + 1
					end;
					Result := Result + ovhsiz;
				else
					if nb_bits > 0 then
						from
							current_area := area
							go_bits
							i := position
						until
							current_area.item (i).level > Bits_level
						loop
							bit_desc ?= current_area.item (i)
							Result := Result + ovhsiz + bitoff(bit_desc.value)
							i := i + 1
						end
					end

					if nb_expanded > 0 then
						from
							current_area := area
							go_expanded
							i := position
						until
							i >= index
						loop
							expanded_desc ?= current_area.item (i)
							exp_skel := expanded_desc.class_type.skeleton
							Result := Result + ovhsiz + exp_skel.workbench_size
							i := i + 1
						end
						Result := Result + ovhsiz
					end
				end
			end;

				-- Restore previous position
			position := index
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
				ba.append_integer_32 (current_area.item (i).rout_id);
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
		do
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				ba.append_short_integer (1)
				ba.append_short_integer (0)
				current_area.item (i).type_i.make_gen_type_byte_code (ba, False, class_type.type)
				ba.append_short_integer (- 1)
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
			buffer.put_character ('{')
			buffer.put_new_line
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				buffer.put_string_literal (current_area.item (i).attribute_name)
				buffer.put_string (",%N")
				i := i + 1
			end
			buffer.put_string ("};%N%N")
		end

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
			buffer.put_character ('{');
			buffer.put_new_line;
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				current_area.item (i).generate_code (buffer);
				buffer.put_string (",%N");
				i := i + 1;
			end;
			buffer.put_string ("};%N%N");
		end;

	generate_generic_type_arrays is
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
				current_area.item (i).generate_generic_code (buffer, Context.final_mode, class_type, i)
				i := i + 1;
			end;
			buffer.put_new_line;
			buffer.put_string ("static EIF_TYPE_INDEX *gtypes")
			buffer.put_integer (class_type.type_id)
			buffer.put_string (" [] = {%N")

			from
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				edesc ?= current_area.item (i)
				buffer.put_string ("g_atype")
				buffer.put_integer (class_type.type_id)
				buffer.put_character ('_')
				buffer.put_integer (i)
				buffer.put_string (",%N")
				i := i + 1;
			end;
			buffer.put_string ("};%N%N");
		end;

	generate_offset_array is
			-- Generate static C array of attributes offset table pointers.
		require
			not empty;
		local
			buffer: GENERATION_BUFFER
			current_area: SPECIAL [ATTR_DESC]
			i, nb: INTEGER
		do
			buffer := generation_buffer
			buffer.put_character ('{');
			buffer.put_new_line;
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
					--| In this instruction, we put `True' as second
					--| arguments. This means we will generate something if there is nothing
					--| to generate (ie `0'). Remember that `False' is used in all other case
				position := i
				generate (buffer, True, False)
				buffer.put_string (",%N");
				i := i + 1;
			end;
			buffer.put_string ("};%N%N");
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
			buffer.put_character ('{');
			buffer.put_new_line;
			from
				current_area := area
				i := 0
				nb := count - 1
			until
				i > nb
			loop
				buffer.put_integer (current_area.item (i).rout_id);
				buffer.put_string (",%N");
				i := i + 1;
			end;
			buffer.put_string ("};%N%N");
		end;

feature {SKELETON} -- Convenience

	definition_buffer: GENERATION_BUFFER is
			-- Buffer used to generate the definition of a size/offsets.
		once
			create Result.make (64)
		ensure
			definition: Result /= Void
		end

	insert_in_buffer (buffer, a_def_buffer: GENERATION_BUFFER; as_macro: BOOLEAN) is
			-- Insert `a_macro_buffer' definition into `buffer' if `as_macro', otherwise `a_def_buffer'.
		require
			buffer_not_void: buffer /= Void
			a_def_buffer_not_void: a_def_buffer /= Void
		local
			l_string: STRING
			i, nb: INTEGER
		do
			if as_macro then
					-- Replace all '@', '(', ')' and ',' by underscores for the macro.
				l_string := a_def_buffer.as_string
				from
					i := 1
					nb := l_string.count
				until
					i > nb
				loop
					inspect l_string.item (i)
					when '@', '(', ')', ',' then
						l_string.put ('_', i)
					else

					end
					i := i + 1
				end
				system.extend_skeleton_table (l_string, a_def_buffer.as_string)
				buffer.put_string (l_string)
			else
				buffer.put_buffer (a_def_buffer)
			end
			a_def_buffer.clear_all
		ensure
			a_def_buffer_is_empty: a_def_buffer.is_empty
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

feature {NONE} -- Externals

	eif_chroff(nb_ref: INTEGER): INTEGER is
			-- Offset of first character after `nb_ref' references
		external
			"C use %"eif_offset.h%""
		end;

	eif_i16off(nb_ref, nb_char: INTEGER): INTEGER is
			-- Offset of first integer 16 bits after `nb_ref' references,
			-- and `nb_char' characters
		external
			"C use %"eif_offset.h%""
		end;

	eif_i32off(nb_ref, nb_char, nb_int16: INTEGER): INTEGER is
			-- Offset of first integer 32 bits after `nb_ref' references,
			-- `nb_char' characters and `nb_int16' integers.
		external
			"C use %"eif_offset.h%""
		alias
			"eif_lngoff"
		end;

	eif_r32off (nb_ref, nb_char, nb_int16, nb_int32: INTEGER): INTEGER is
			-- Offset of first real 32 bits after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers and `nb_int32' integers
		external
			"C use %"eif_offset.h%""
		end;

	eif_ptroff (nb_ref, nb_char, nb_int16, nb_int32, nb_r32: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers
			-- and `nb_r32' reals
		external
			"C use %"eif_offset.h%""
		end;

	eif_i64off (nb_ref, nb_char, nb_int16, nb_int32, nb_r32, nb_ptr: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers,
			-- `nb_r32' reals and `nb_ptr' pointers.
		external
			"C use %"eif_offset.h%""
		end;

	eif_r64off (nb_ref, nb_char, nb_int16, nb_int32, nb_r32, nb_ptr, nb_int64: INTEGER): INTEGER is
			-- Offset of first pointer after `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers,
			-- `nb_r32' reals, `nb_ptr' pointers and `nb_int64' integers.
		external
			"C use %"eif_offset.h%""
		end;

	eif_objsiz (nb_ref, nb_char, nb_int16, nb_int32, nb_r32, nb_ptr, nb_int64, nb_r64: INTEGER): INTEGER is
			-- Size of an object having `nb_ref' references,
			-- `nb_char' characters, `nb_int16' integers, `nb_int32' integers,
			-- `nb_r32' reals, `nb_ptr' pointers, `nb_int64' integers and `nb_r64' reals
		external
			"C use %"eif_offset.h%""
		end;

	bitoff (bit_val: INTEGER): INTEGER is
			-- Size of a bit object of size `bit_val'
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"BITOFF"
		end;

	chracs (n: INTEGER): INTEGER is
			-- Size of `n' characters
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"CHRACS"
		end;

	refacs (n: INTEGER): INTEGER is
			-- Size of `n' references
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"REFACS"
		end;

	i16acs (n: INTEGER): INTEGER is
			-- size of `n' integers 16 bits.
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"I16ACS"
		end

	i32acs (n: INTEGER): INTEGER is
			-- Size of `n' integers 32 bits
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"LNGACS"
		end;

	i64acs (n: INTEGER): INTEGER is
			-- Size of `n' integers 64 bits
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"I64ACS"
		end;

	r32acs (n: INTEGER): INTEGER is
			-- Size of `n' reals
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"R32ACS"
		end;

	ptracs (n: INTEGER): INTEGER is
			-- Size of `n' pointers
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"PTRACS"
		end;

	r64acs (n: INTEGER): INTEGER is
			-- Size of `n' reals 64 bits
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"R64ACS"
		end;

	ovhsiz: INTEGER is
			-- Size of the object header
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"OVERHEAD"
		end;

invariant
	class_type_not_void: class_type /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
