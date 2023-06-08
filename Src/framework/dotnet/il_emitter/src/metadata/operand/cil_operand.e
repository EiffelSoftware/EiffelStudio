note
	description: "[
					The operand to an instruction 
			    	This can contain a number, a string, or a reference to value
			   		A value can be a field, methodsignature, local, or param reference
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_OPERAND

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- no operand
		do
			type := {CIL_OPERAND_TYPE}.t_none
			size := {CIL_OPERAND_SIZE}.i8
			create string_value.make_empty
		end

feature -- Access

	type: CIL_OPERAND_TYPE assign set_type
			-- The `type' of operand.

	size: CIL_OPERAND_SIZE assign set_size
			-- `size'

	ref_value: detachable CIL_VALUE assign set_ref_value
			-- `ref_value'

	string_value: STRING_32 assign set_string_value
			-- `string_value'

	int_value: INTEGER_64 assign set_int_value
			-- `int_value'

	float_value: REAL_64 assign set_float_value
			-- `float_value'

	property: BOOLEAN assign set_property
			-- is `property' flag?
			--| only has meaning for `value` operands.

feature -- Status Report

	is_nan_or_inf: BOOLEAN
		do
			Result := float_value.is_nan or else float_value.is_negative_infinity or else float_value.is_positive_infinity
		end

feature -- Element change

	set_type (a_type: like type)
			-- Assign `type' with `a_type'.
		do
			type := a_type
		ensure
			type_assigned: type = a_type
		end

	set_size (a_size: like size)
			-- Assign `size' with `a_size'.
		do
			size := a_size
		ensure
			size_assigned: size = a_size
		end

	set_ref_value (a_ref_value: like ref_value)
			-- Assign `ref_value' with `a_ref_value'.
		do
			ref_value := a_ref_value
		ensure
			ref_value_assigned: ref_value = a_ref_value
		end

	set_string_value (a_string_value: like string_value)
			-- Assign `string_value' with `a_string_value'.
		do
			string_value := a_string_value
		ensure
			string_value_assigned: string_value = a_string_value
		end

	set_int_value (an_int_value: like int_value)
			-- Assign `int_value' with `an_int_value'.
		do
			int_value := an_int_value
		ensure
			int_value_assigned: int_value = an_int_value
		end

	set_float_value (a_float_value: like float_value)
			-- Assign `float_value' with `a_float_value'.
		do
			float_value := a_float_value
		ensure
			float_value_assigned: float_value = a_float_value
		end

	set_property (a_property: like property)
			-- Assign `property' with `a_property'.
		do
			property := a_property
		ensure
			property_assigned: property = a_property
		end

feature --Access

	value: detachable CIL_VALUE
			-- Return value when the opererand is a complex value.
		do
			if type = {CIL_OPERAND_TYPE}.t_value then
				Result := ref_value
			end
		end

	escaped_string: STRING_32
		local
			l_doit: BOOLEAN
			l_ret_val: STRING_32
			l_item: INTEGER_32
			l_ch: CHARACTER_32
			l_a: CHARACTER_32
			l_b: CHARACTER_32
			l_f: CHARACTER_32
			l_n: CHARACTER_32
			l_r: CHARACTER_32
			l_v: CHARACTER_32
			l_t: CHARACTER_32
			l_0: CHARACTER_32
		do
				-- TODO check if there is a simple way to write this.
			l_a := '%A'
			l_b := '%B'
			l_f := '%F'
			l_n := '%N'
			l_r := '%R'
			l_v := '%V'
			l_t := '%T'
			l_0 := '0'

			create l_ret_val.make_empty
			across string_value as i until l_doit loop
				if i.code < 32 or else i.code > 126 or else i = '\' or else i = '"' then
					l_doit := True
				end
			end
			if l_doit then
				across string_value as i loop
					l_item := i.code & 0xff
					if l_item < 32 then

						if l_a.code = l_item then
							l_ch := 'a'
							l_item := l_ch.code
						elseif l_b.code = l_item then
							l_ch := 'b'
							l_item := l_ch.code
						elseif l_f.code = l_item then
							l_ch := 'f'
							l_item := l_ch.code
						elseif l_n.code = l_item then
							l_ch := 'n'
							l_item := l_ch.code
						elseif l_r.code = l_item then
							l_ch := 'r'
							l_item := l_ch.code
						elseif l_v.code = l_item then
							l_ch := 'v'
							l_item := l_ch.code
						elseif l_t.code = l_item then
							l_ch := 't'
							l_item := l_ch.code
						end

						if l_item < 32 then
							l_ret_val.append ("\0")
							l_ret_val.append_character ((l_item // 8 + l_0.code).to_character_32)
							l_ret_val.append_character ((l_item & 7 + l_0.code).to_character_32)
						else
							l_ret_val.append ("\")
							l_ret_val.append_character (l_item.to_character_32)
						end
					elseif l_item.to_character_32 = '"' or else l_item.to_character_32 = '%H' then
						l_ret_val.append ("\")
						l_ret_val.append_character (l_item.to_character_32)
					elseif l_item > 126 then
						l_ret_val.append ("\")
						l_ret_val.append_character ((l_item // 64 + l_0.code).to_character_32)
						l_ret_val.append_character (((l_item // 8) & 7 + l_0.code).to_character_32)
						l_ret_val.append_character ((l_item & 7 + l_0.code).to_character_32)
					else
						l_ret_val.append_character (l_item.to_character_32)
					end
				end
				Result := l_ret_val
			else
				Result := string_value
			end
		end

feature -- Output

	render (a_stream: FILE_STREAM; a_opcode: INTEGER; a_operand_type: INTEGER; a_result: SPECIAL [NATURAL_8]; a_offset: INTEGER): NATURAL_32
		local
			l_sz: INTEGER
			l_str: STRING_32
			l_us_index: NATURAL_32
		do
			if attached {PE_WRITER} a_stream.pe_writer as l_writer then
				l_sz := 0
				inspect type
				when {CIL_OPERAND_TYPE}.t_none then
						-- No operand, nothing to display
				when {CIL_OPERAND_TYPE}.t_label then
						-- Shouldn't be rendered.
				when {CIL_OPERAND_TYPE}.t_value then
					if attached {CIL_VALUE} ref_value as l_ref_value then
							-- TODO check if we need to add an offset to index the
							-- byte array
						l_sz := l_ref_value.render (a_stream, a_opcode, a_operand_type, a_result, a_offset).to_integer_32
					end
				when {CIL_OPERAND_TYPE}.t_int then
						-- TODO double check
						-- this piece of code needs to be simpler
					if a_operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_immed1).to_integer_32 then
						{BYTE_SPECIAL_HELPER}.put_special_natural_8_with_integer_64 (a_result, int_value, l_sz + a_offset)
						l_sz := l_sz + 1
					elseif a_operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_immed4).to_integer_32 then
						{BYTE_SPECIAL_HELPER}.put_special_integer_32_with_integer_64 (a_result, int_value, l_sz + a_offset)
						l_sz := l_sz + 4
					elseif a_operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_immed8).to_integer_32 then
						{BYTE_SPECIAL_HELPER}.put_special_integer_64 (a_result, int_value, l_sz + a_offset)
						l_sz := l_sz + 8
					end
				when {CIL_OPERAND_TYPE}.t_real then
					if a_operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_float4).to_integer_32 then
						{BYTE_SPECIAL_HELPER}.put_special_float_with_double (a_result, float_value, l_sz + a_offset)
						l_sz := l_sz + 4
					elseif a_operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_float8).to_integer_32 then
						{BYTE_SPECIAL_HELPER}.put_special_double (a_result, float_value, l_sz + a_offset)
						l_sz := l_sz + 8
					end
				when {CIL_OPERAND_TYPE}.t_string then

						-- -Eiffel strings are not null-terminated.
					create l_str.make_from_string (string_value)

						-- check if this assumtion is correct
					check not_null_character: not l_str.has ('%U') end

						--| add the null character
					l_us_index := l_writer.hash_us (l_str, l_str.count)
					{BYTE_SPECIAL_HELPER}.put_special_integer_32_with_natural_64 (a_result, l_us_index | ({NATURAL_32} 0x70 |<< 24), a_offset)
					l_sz := l_sz + 4
				end
				Result := l_sz.to_natural_32
			end
		end

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		local
			l_buf: ARRAY [NATURAL_8]
			l_sz: INTEGER
		do
			inspect type
			when {CIL_OPERAND_TYPE}.t_none then
					-- no operand, nothing to display
			when {CIL_OPERAND_TYPE}.t_value then
				if attached ref_value as l_value then
					Result := l_value.il_src_dump (a_file)
				end
			when {CIL_OPERAND_TYPE}.t_int then
				a_file.put_integer_64 (int_value)
			when {CIL_OPERAND_TYPE}.t_real then
				if float_value.is_nan or else float_value.is_negative_infinity or else float_value.is_positive_infinity then
					create l_buf.make_filled (0, 1, 8)
					if size = {CIL_OPERAND_SIZE}.r4 then
						l_sz := 4
						l_buf := real32_to_byte (float_value.truncated_to_real)
					else
						l_sz := 8
						l_buf := real64_to_byte (float_value)
					end
					a_file.put_string ("(")
					across 1 |..| l_sz as ic loop
						a_file.put_string (l_buf [ic].to_hex_string)
					end
					a_file.put_string (")")
				else
					a_file.put_string (float_value.out)
				end
			when {CIL_OPERAND_TYPE}.t_string then
				a_file.put_string ("%"")
				a_file.put_string (escaped_string)
				a_file.put_string ("%"")
			when {CIL_OPERAND_TYPE}.t_label then
				a_file.put_string (string_value)
			else
					-- do nothing
			end
			Result := True
		end

feature {NONE} -- Implementation

	real32_to_byte (a_val: REAL_32): ARRAY [NATURAL_8]
		local
			mp: MANAGED_POINTER
		do
			create mp.make (8)
			mp.put_real_32 (a_val, 0)
			Result := mp.read_array (0, 8)
		end

	real64_to_byte (a_val: REAL_64): ARRAY [NATURAL_8]
		local
			mp: MANAGED_POINTER
		do
			create mp.make (8)
			mp.put_real_64 (a_val, 0)
			Result := mp.read_array (0, 8)
		end

end
