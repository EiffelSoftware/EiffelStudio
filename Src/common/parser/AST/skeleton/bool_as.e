-- Node for boolean constant

class BOOL_AS

inherit

	ATOMIC_AS
		redefine
			type_check, byte_node, value_i, format
		end

feature -- Attributes

	value: BOOLEAN;
			-- Integer value

feature -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_bool_arg (0);
		end;

feature -- Type check

	value_i: BOOL_VALUE_I is
		do
			!!Result;
			Result.set_bool_val (value);
		end;

	type_check is
			-- Type chek a boolean type
		do
			context.put (Boolean_type);
		end;

	byte_node: BOOL_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

feature -- formatter

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.always_succeed;
			if value then
				ctxt.put_keyword ("true")

			else
				ctxt.put_keyword ("false")
			end
		end;

end
