-- Node for integer constant

class INTEGER_AS

inherit

	ATOMIC_AS
		redefine
			is_integer, type_check, byte_node, value_i,
			make_integer, good_integer, format
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

	value_i: INT_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_int_val (value);
		end;

	type_check is
			-- Type check an integer type
		do
				-- Put onto the type stack an integer actual type
			context.put (Integer_type);
		end;

	byte_node: INT_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
			Result := True;
		end;

	make_integer: INT_VAL_B is
			-- Integer value
		do
			!!Result.make (value);
		end;

feature -- Formatter 

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.always_succeed;
			ctxt.put_string(value.out);
		end;
				

end
