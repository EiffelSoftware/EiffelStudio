-- Node for real constant

class REAL_AS

inherit

	ATOMIC_AS
		redefine
			simple_format
		end

feature -- Attribute

	value: STRING;
			-- Real value

feature -- Initilization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		end;

feature -- Formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do	
			ctxt.always_succeed;
			ctxt.put_string(value);
		end;
		

end
