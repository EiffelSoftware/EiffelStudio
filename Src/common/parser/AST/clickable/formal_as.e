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
		local
			id_as: ID_AS
		do
			id_as := ctxt.ast.generics.i_th (position).formal_name
			id_as.to_upper
			ctxt.put_string (id_as)
		end;

feature

	dump: STRING is
		do
			!!Result.make (12);
			Result.append ("Generic #");
			Result.append_integer (position);
		end;

end -- class FORMAL_AS
