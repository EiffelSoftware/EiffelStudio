indexing
	description: 
		"AST representation of BIT types."
	date: "$Date$"
	revision: "$Revision $"

class
	BITS_AS

inherit
	BASIC_TYPE
		rename
			initialize as initialize_basic_type
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (v: like bits_value) is
			-- Create a new BITS AST node.
		require
			v_not_void: v /= Void
		do
			bits_value := v
		ensure
			bits_value_set: bits_value = v
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_as (Current)
		end

feature -- Attributes

	bits_value: INTEGER_CONSTANT
			-- Bits value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_value, other.bits_value)
		end

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			create Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (bits_value.value)
		end

end -- class BITS_AS
