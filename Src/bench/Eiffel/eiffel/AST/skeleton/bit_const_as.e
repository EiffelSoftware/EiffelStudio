indexing

	description: "Node for bit constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class BIT_CONST_AS

inherit
	ATOMIC_AS
		redefine
			byte_node, type_check, value_i, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (b: ID_AS) is
			-- Create a new BIT_CONSTANT AST node with
			-- with bit sequence contained in `b'.
		require
			b_not_void: b /= Void
		do
			value := b
		ensure
			value_set: value = b
		end

feature -- Attributes

	value: ID_AS
			-- Bit value (sequence of 0 and 1)

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
		end

feature -- Type check and byte code

	type_check is
			-- Type check a bit constant
		local
			bit_type: BITS_A
		do
			create bit_type.make (value.count)
				-- Update the type stack
			context.put (bit_type)
		end

	byte_node: BIT_CONST_B is
			-- Associated byte code
		do
			!! Result
			Result.set_value (value)
		end

feature

	value_i: BIT_VALUE_I is
			-- Interface constant value
		do
			!! Result
			Result.set_bit_val (value)
		end

feature -- Output

	string_value: STRING is
		do
			create Result.make (value.count)
			Result.append (value)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_string (value)
			ctxt.put_string ("B")
		end

end -- class BIT_CONST_AS
