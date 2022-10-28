note
	description: "Object Representing an special kind of Class: Enum"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_ENUM

inherit

	CIL_CLASS
		rename
			make as make_class
		redefine
			il_src_dump
		end
	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	make (a_name: STRING_32; a_flags: CIL_QUALIFIERS; a_size: CIL_VALUE_SIZE)
		do
			value_size := a_size
			make_class (a_name, create {CIL_QUALIFIERS}.make_with_flags (a_flags.flags | {CIL_QUALIFIERS_ENUM}.value), -1, -1)
		ensure
			value_size_set: value_size = a_size
		end

feature -- Access

	value_size: CIL_VALUE_SIZE

feature -- Element change

	add_value (a_name: STRING_32; a_value: INTEGER_64)
			-- Add an enumeration, give it a name and a value
			-- This creates the Field definition for the enumerated value
		do
			to_implement ("Add implemenation ")
		end

feature -- Output

	il_src_dump (a_stream: FILE_STREAM): BOOLEAN
		do
			il_src_dump_class_header (a_stream)
			a_stream.put_string (" {")
			a_stream.put_new_line
			a_stream.flush
			to_implement ("Finish Implementation")
		end

end
