class INLINED_ONCE_BYTE_CODE

inherit
	ONCE_BYTE_CODE
		undefine
			has_inlined_code
		end

	INLINED_BYTE_CODE
		undefine
			append_once_mark,
			is_once, is_global_once,
			pre_inlined_code, inlined_byte_code, generate_once_declaration,
			generate_il, generate_il_return,
			generate_once_data, generate_once_prologue, generate_once_epilogue
		end

end
