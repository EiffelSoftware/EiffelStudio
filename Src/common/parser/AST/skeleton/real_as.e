indexing

	description: "Node for real constant.";
	date: "$Date$";
	revision: "$Revision$"

class REAL_AS

inherit

	ATOMIC_AS
		redefine
			simple_format
		end;

feature -- Attribute

	value: STRING;
			-- Real value

feature -- Initilization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string(value);
		end;

end -- class REAL_AS
