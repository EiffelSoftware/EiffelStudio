note
	description: "[
		Object representing a parameter
		noticably missing is support for [in][out][opt] and default values
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_PARAM

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
	make,
	make_with_index

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_type: detachable CIL_TYPE)
		do
			make_with_index (a_name, a_type, -1)
		end

	make_with_index (a_name: STRING_32; a_type: detachable CIL_TYPE; a_index: INTEGER)
		do
			make_value (a_name, a_type)
			index := a_index
		ensure
			index_set: index = a_index
		end

feature -- Access		

	index: INTEGER_32
		-- Index of Argument.


feature --Change Element

	set_index (a_index: INTEGER_32)
			-- Set index of argument to `a_index`.
		do
			index := a_index
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string ("'")
			a_file.put_string (name)
			a_file.put_string ("'")
			Result := True
		end

	render (a_stream: FILE_STREAM; a_opcode: INTEGER; a_operand_type: INTEGER; a_byte: detachable SPECIAL [NATURAL_8]): NATURAL_32
		do
			to_implement("Add implementation")
		end

end
