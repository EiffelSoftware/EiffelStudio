indexing

	description: 
		"AST representation of a real constant.";
	date: "$Date$";
	revision: "$Revision$"

class REAL_AS

inherit

	ATOMIC_AS

feature {NONE} -- Initilization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		end;

feature -- Properties

	value: STRING;
			-- Real value

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string (value);
		end;

	string_value: STRING is
		do
			Result := clone (value)
		end

end -- class REAL_AS
