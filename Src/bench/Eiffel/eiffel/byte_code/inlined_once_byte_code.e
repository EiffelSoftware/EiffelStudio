class INLINED_ONCE_BYTE_CODE

inherit
	ONCE_BYTE_CODE
		undefine
			has_inlined_code
		end

	INLINED_BYTE_CODE
		undefine
			is_once, generate_once, generate_result_declaration,
			pre_inlined_code, inlined_byte_code
		end

end
