indexing

	description: "Node for character constant.";
	date: "$Date$";
	revision: "$Revision$"

class CHAR_AS

inherit

	ATOMIC_AS
		redefine
			is_character, good_character, simple_format
		end;
	CHARACTER_ROUTINES

feature -- Attributes

	value: CHARACTER;
			-- Character value

feature -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_char_arg (0);
		end;

feature -- Conveniences

	is_character: BOOLEAN is
			-- Is the current value a character value ?
		do
			Result := True;
		end;

	good_character: BOOLEAN is
			-- Is the current atomic a good character?
		do
			Result := True;
		end;

feature -- Simple formatting

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstiture text.
		do
			ctxt.put_text_item (ti_Quote);
			ctxt.put_string (char_text (value));
			ctxt.put_text_item (ti_Quote)
		end;

end -- class CHAR_AS
