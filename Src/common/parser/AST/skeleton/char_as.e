indexing

	description: 
		"AST representation of character constant.";
	date: "$Date$";
	revision: "$Revision$"

class CHAR_AS

inherit

	ATOMIC_AS
		redefine
			is_character, good_character, is_equivalent
		end;
	CHARACTER_ROUTINES

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_char_arg (0);
		end;

feature -- Properties

	value: CHARACTER;
			-- Character value

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

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Output

	string_value: STRING is
		do
			Result := char_text (value)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstiture text.
		do
			ctxt.put_text_item_without_tabs (ti_Quote);
			ctxt.put_string (char_text (value));
			ctxt.put_text_item_without_tabs (ti_Quote)
		end;

end -- class CHAR_AS
