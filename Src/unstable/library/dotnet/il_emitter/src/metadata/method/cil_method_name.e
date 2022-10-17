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
			il_src_dump
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

	render (a_stream: FILE_STREAM; a_opcode: INTEGER; a_operand_type: INTEGER; a_byte: ARRAY [NATURAL_8]): BOOLEAN
		do
			to_implement ("Add implementation")
		end

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			Result := signature.il_src_dump (a_file, false, false, false)
		end
end
