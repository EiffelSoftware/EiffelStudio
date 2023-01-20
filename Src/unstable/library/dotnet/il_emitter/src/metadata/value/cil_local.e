note
	description: "[
			Value is a local variable.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_LOCAL

inherit

	CIL_VALUE
		rename
			make as make_value
		redefine
			il_src_dump,
			render
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_type: detachable CIL_TYPE)
		do
			make_value (a_name, a_type)
			uses := 0
			index := -1
		ensure
			uses_set: uses = 0
			index_set: index = -1
		end

feature -- Access

	uses: INTEGER

	index: INTEGER assign set_index
			-- return index of a variable

feature -- Element change

	set_index (an_index: like index)
			-- Assign `index' with `an_index'.
		do
			index := an_index
		ensure
			index_assigned: index = an_index
		end

	increment_uses
			-- Increment uses of a variable.
		do
			uses := uses + 1
		ensure
			uses_incremented: old uses + 1 = uses
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string ("'")
			a_file.put_string (name)
			a_file.put_string ("/")
			a_file.put_integer (index)
			a_file.put_string ("'")
			Result := True
		end

	render (a_stream: FILE_STREAM; a_opcode: INTEGER; a_operand_type: INTEGER; a_result: SPECIAL [NATURAL_8]; a_offset: INTEGER): NATURAL_64
		local
			l_sz: INTEGER
		do
			if a_operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index1) then
				{BYTE_ARRAY_HELPER}.put_array_natural_8_with_integer_32 (a_result, index, a_offset)
				l_sz := 1
			elseif a_operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index2) then
				{BYTE_ARRAY_HELPER}.put_array_natural_16_with_integer_32 (a_result, index, a_offset)
				l_sz := 2
			end
			Result := l_sz.to_natural_64
		end

end
