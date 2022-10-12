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
			il_src_dump
		end

create
	make

feature {NONE}-- Initialization

	make (a_name: STRING_32; a_type: detachable CIL_TYPE)
		do
			make_value(a_name, a_type)
			uses := 0
			index := -1
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
			-- Increment uses of a variable..
		do
			uses := uses + 1
		ensure
			uses_incremented: old uses + 1 = uses
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			-- TODO to be implemented.
		end

end
