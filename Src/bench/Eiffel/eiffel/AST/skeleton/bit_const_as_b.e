indexing

	description: "Node for bit constant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class BIT_CONST_AS_B

inherit

	BIT_CONST_AS
		redefine
			value
		end;

	ATOMIC_AS_B
		undefine
			simple_format, string_value
		redefine
			byte_node, type_check, value_i, format
		end

feature -- Attributes

	value: ID_AS_B;
			-- Bit value (sequence of 0 and 1)

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

	format (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.always_succeed;
			ctxt.put_string (value)
			ctxt.put_string ("B");
		end;

end -- class BIT_CONST_AS_B
