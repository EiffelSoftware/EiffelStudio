indexing

	description: "Description of a unique value.";
	date: "$Date$";
	revision: "$Revision$"

class UNIQUE_AS

inherit

	ATOMIC_AS
		redefine
			is_unique, simple_format
		end

feature -- Conveniences

	is_unique: BOOLEAN is
			-- Is the terminal a unique constant ?
		do
			Result := True;
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end; -- set

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Unique_keyword);
		end;

end -- class UNIQUE_AS
