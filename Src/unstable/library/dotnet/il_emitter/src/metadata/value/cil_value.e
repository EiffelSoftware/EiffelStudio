note
	description: "[
		Object representing a value
		A value, typically to be used as an operand.
		Various other classes derive from this to make specific types of operand values.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_VALUE

create
	make

feature {NONE} --Initialization

	make (a_name: STRING_32; a_type: detachable CIL_TYPE)
		do
			name := a_name
			type := a_type
		end

feature -- Access

	name: STRING_32

	type: detachable CIL_TYPE
		-- type of value.
		-- TODO check if it's better to use NULL pattern.

feature -- Change Element

	set_name (a_name: STRING_32)
			-- Set name.
		do
			name := a_name
		end

	set_type (a_type: CIL_TYPE)
			-- Set type of value.
		do
			type := a_type
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			-- used for types
			if attached type as l_type then
				Result := l_type.il_src_dump (a_file)
			end
			Result := True
		end
end
