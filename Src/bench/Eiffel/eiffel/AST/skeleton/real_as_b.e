-- Node for real constant

class REAL_AS

inherit

	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, format
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

feature -- Type check and byte code

	value_i: REAL_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_real_val (value);
		end;

	type_check is
			-- Type check a real type
		do
			context.put (Real_type);
		end;

	byte_node: REAL_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do	
			ctxt.always_succeed;
			ctxt.put_string(value);
		end;
		

end
