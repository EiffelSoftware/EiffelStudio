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

create
	initialize

feature {NONE} -- Initialization

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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bit_const_as (Current)
		end

feature -- Attributes

	value: ID_AS
			-- Bit value (sequence of 0 and 1)

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := value.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := value.end_location
		end

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
			create Result
			Result.set_value (value)
		end

feature

	value_i: BIT_VALUE_I is
			-- Interface constant value
		do
			create Result.make (value)
		end

feature -- Output

	string_value: STRING is
		do
			create Result.make (value.count)
			Result.append (value)
		end

invariant
	value_not_void: value /= Void

end -- class BIT_CONST_AS
