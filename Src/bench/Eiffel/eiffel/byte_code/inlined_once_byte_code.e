class INLINED_ONCE_BYTE_CODE

inherit
	ONCE_BYTE_CODE
		undefine
			has_inlined_code
		end

	INLINED_BYTE_CODE
		undefine
			is_once, generate_once,
			pre_inlined_code, inlined_byte_code, generate_once_declaration,
			generate_il, generate_il_return, is_global_once
		end

end
