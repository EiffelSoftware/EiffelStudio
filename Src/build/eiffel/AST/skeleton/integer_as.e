-- Node for integer constant

class INTEGER_AS

inherit

	ATOMIC_AS
		redefine
			is_integer, good_integer, simple_format
		end

feature -- Attributes

	value: INTEGER;
			-- Integer value

feature -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_int_arg (0);
		end

feature -- Conveniences

	is_integer: BOOLEAN is
			-- Is it an integer value ?
		do
			Result := True;
		end;

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
			Result := True;
		end;

feature -- Formatter 

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.always_succeed;
			ctxt.put_string(value.out);
		end;

end
