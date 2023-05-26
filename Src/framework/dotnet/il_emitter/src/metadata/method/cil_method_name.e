note
	description: "[
		Value: a method name (used as an operand)
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_METHOD_NAME

inherit

	CIL_VALUE
		rename
			make as make_value
		redefine
			il_src_dump,
			render
		end
	REFACTORING_HELPER



create
	make

feature {NONE} -- Initialization

	make (a_method_sig: CIL_METHOD_SIGNATURE)
		do
			make_value("", Void)
			signature := a_method_sig
		ensure
			signature_set: signature = a_method_sig
		end

feature -- Access

	signature: CIL_METHOD_SIGNATURE


feature -- Output

	render (a_stream: FILE_STREAM; a_opcode: INTEGER; a_operand_type: INTEGER; a_byte: SPECIAL [NATURAL_8]; a_offset: INTEGER): NATURAL_64
		local
			l_res: BOOLEAN
		do
			if a_opcode = {CIL_INSTRUCTION_OPCODES}.index_of ({CIL_INSTRUCTION_OPCODES}.i_calli) then
				if signature.pe_index_type = 0 then
					l_res := signature.pe_dump (a_stream, True)
				end
				{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (a_byte, signature.pe_index_type | ({PE_TABLES}.tstandalonesig |<< 24).to_natural_64, a_offset)
			else
				if signature.pe_index = 0 and then signature.pe_index_call_site = 0 then
					l_res := signature.pe_dump (a_stream, False)
				end
				if signature.pe_index /= 0 then
					{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (a_byte, signature.pe_index | ({PE_TABLES}.tmethoddef |<< 24).to_natural_64, a_offset)
				elseif not signature.generic.is_empty then
					{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (a_byte, signature.pe_index_call_site | ({PE_TABLES}.tmethodspec |<< 24).to_natural_64, a_offset)
				else
					{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (a_byte, signature.pe_index_call_site | ({PE_TABLES}.tmemberref |<< 24).to_natural_64, a_offset)
				end
			end
			Result := 4
		end

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			Result := signature.il_src_dump (a_file, false, false, false)
		end
end
