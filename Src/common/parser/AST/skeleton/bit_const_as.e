indexing
	description: "Node for bit constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class BIT_CONST_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
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

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := value.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := value.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
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
