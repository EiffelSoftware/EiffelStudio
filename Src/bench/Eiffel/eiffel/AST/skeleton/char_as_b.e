-- Node for character constant

class CHAR_AS

inherit

	ATOMIC_AS
		redefine
			is_character, type_check, byte_node, value_i,
			good_character, make_character, format
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

	value_i: CHAR_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_char_val (value);
		end;

	type_check is
			-- Type check character
		do
			context.put (Character_type);
		end;

	byte_node: CHAR_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

	good_character: BOOLEAN is
			-- Is the current atomic a good character /
		do
			Result := True;
		end;

	make_character: CHAR_VAL_B is
			-- Character value
		do
		   !!Result.make (value);
		end;


	format (ctxt : FORMAT_CONTEXT) is
		do
			ctxt.always_succeed;
			ctxt.put_text_item (ti_Quote);
			ctxt.put_string (char_text (value));
			ctxt.put_text_item (ti_Quote)
		end;
end
