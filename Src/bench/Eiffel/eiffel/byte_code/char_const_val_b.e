class
	CHAR_CONST_VAL_B 

inherit
	CHAR_VAL_B
		rename
			make as old_make
		redefine
			generation_value, make_byte_code
		end
	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

creation

	make

feature

	rout_id: INTEGER
			-- Routine id of the constant

	feature_id: INTEGER
			-- Feature id of the constant

	make (i: CHARACTER; c: CONSTANT_I) is
		require
			good_argument: c /= Void
		do
			old_make (i)
			rout_id := c.rout_id_set.first
			feature_id := c.feature_id
		end

	generation_value: CHARACTER is
			-- Value to generate
		local
			constant_i: CONSTANT_I
			char_value: CHAR_VALUE_I
			current_feature_table: FEATURE_TABLE
		do
			current_feature_table := context.current_type.base_class.feature_table
			constant_i ?= current_feature_table.origin_table.item (rout_id)
			char_value ?= constant_i.value
			Result := char_value.char_val
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a character constant feature in
			-- an interval
		local
			cl_type: CL_TYPE_I
			base_class: CLASS_C
			rout_info: ROUT_INFO
		do
			ba.append (Bc_current)
			cl_type := context.current_type
			base_class := cl_type.base_class
			if base_class.is_precompiled then
				rout_info := System.rout_info_table.item (rout_id)
				ba.append (Bc_pfeature)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
				ba.append_short_integer (-1)
			else
				ba.append (Bc_feature)
				ba.append_integer (feature_id)
				ba.append_short_integer (cl_type.associated_class_type.static_type_id - 1)
				ba.append_short_integer (-1)
			end
		end

end
