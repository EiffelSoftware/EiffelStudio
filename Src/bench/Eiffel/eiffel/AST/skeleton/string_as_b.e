-- Node for string constants

class STRING_AS

inherit

	COMPARABLE;
	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, format
		end;
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

feature -- Type check and byte code

	value_i: STRING_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_str_val (value);
		end;

	type_check is
			-- Type check a string constant
		do
				-- Update the type stack
			context.put (String_type);
		end;

	String_type: CL_TYPE_A is
			-- Actual string type
		once
			Result := System.string_class.compiled_class.actual_type;
		end;

	byte_node: STRING_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

feature -- formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			value_area: SPECIAL [CHARACTER];
			i, value_count: INTEGER;
		do
			ctxt.put_text_item (ti_Double_quote);
			from
				value_area := value.area;
				value_count := value.count
			until
				i >= value_count
			loop
				ctxt.put_string (char_text (value_area.item (i)));
				i := i + 1
			end;
			ctxt.put_text_item (ti_Double_quote);
			ctxt.always_succeed;
		end;

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := value_i.str_val < other.value_i.str_val 
		end;

	set_value (s: STRING) is
		do
			value := s;
		end;



end
