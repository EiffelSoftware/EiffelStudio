indexing

	description: "Node for bit constant.";
	date: "$Date$";
	revision: "$Revision$"

class BIT_CONST_AS

inherit

	ATOMIC_AS
		redefine
			simple_format
		end;

feature -- Attributes

	value: ID_AS;
			-- Bit value (sequence of 0 and 1)

feature -- Initialization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		ensure then
			value_exists: not (value = Void or else value.empty);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_string (value)
			ctxt.put_string ("B");
		end;

end -- class BIT_CONST_AS
