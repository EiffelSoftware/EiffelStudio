-- Node for bit constant

class BIT_CONST_AS

inherit

	ATOMIC_AS
		redefine
			byte_node, type_check, value_i, format
		end

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

feature -- Type check and byte code

	type_check is
			-- Type check a bit constant
		local
			bit_type: BITS_A;
		do
			!!bit_type;
			bit_type.set_base_type (value.count);
				-- Update the type stack
			context.put (bit_type);
		end;

	byte_node: BIT_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

feature

	value_i: BIT_VALUE_I is
			-- Interface constant value
		do
			!!Result;
			Result.set_bit_val (value)
		end;


feature -- formatter

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.always_succeed;
			ctxt.put_string (value)
				-- add B if necessary. to be checked
		end;

end
