indexing

	description: "Abstract description for formal generic type.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAL_AS

inherit

	TYPE
		rename
			position as text_position
		redefine
			simple_format
		end;
	BASIC_ROUTINES
		export
			{NONE}
				all
		end;

feature

	position: INTEGER;
			-- Position of the formal parameter in the declaration
			-- array

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			position := yacc_int_arg (0);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (ctxt.formal_name (position))
		end;

feature

	dump: STRING is
		do
			!!Result.make (12);
			Result.append ("Generic #");
			Result.append_integer (position);
		end;

end -- class FORMAL_AS
