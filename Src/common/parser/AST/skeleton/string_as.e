indexing

	description: "Node for string constants.";
	date: "$Date$";
	revision: "$Revision$"

class STRING_AS

inherit

	COMPARABLE
		undefine
			is_equal
		end;
	ATOMIC_AS;
	CHARACTER_ROUTINES

feature -- Attributes

	value: STRING;
			-- Integer value

feature -- Initilization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		ensure then
			value_exists: value /= Void;
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Double_quote);
			ctxt.put_string (eiffel_string (value));
			ctxt.put_text_item_without_tabs (ti_Double_quote);
		end;

feature 

	infix "<" (other: like Current): BOOLEAN is
		do
			--Result := value_i.str_val < other.value_i.str_val 
		end;

	set_value (s: STRING) is
		do
			value := s;
		end;

end -- class STRING_AS
