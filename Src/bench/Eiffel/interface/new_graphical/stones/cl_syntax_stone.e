indexing
	description: 
		"Class syntax stone."
	date: "$Date$"
	revision: "$Revision $"

class
	CL_SYNTAX_STONE

inherit
	SYNTAX_STONE
		rename
			make as old_make
		undefine
			stone_cursor,
			x_stone_cursor,
			header,
			stone_signature,
			history_name,
			synchronized_stone,
			is_storable
		redefine
			same_as,
			is_valid
		end
		
	CLASSC_STONE
		rename
			make as cl_make,
			file_name as class_file_name
		undefine
			help_text
		redefine
			same_as,
			is_valid
		select
			class_file_name
		end

create
	make

feature {NONE} -- Initialization

	make (a_syntax_message: SYNTAX_MESSAGE; c: CLASS_C) is
		do
			syntax_message := a_syntax_message
			cl_make (c)
		end

feature -- Properties

	same_as (other: STONE): BOOLEAN is
			-- Is `Current' identical to `other'?
		do
			Result := Precursor {SYNTAX_STONE} (other) and then
				Precursor {CLASSC_STONE} (other)
		end
	
	is_valid: BOOLEAN is
			-- Is `Current' meaningful?
		do
			Result := Precursor {SYNTAX_STONE} and then Precursor {CLASSC_STONE}
		end

end -- class CL_SYNTAX_STONE
