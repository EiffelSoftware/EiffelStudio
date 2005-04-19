indexing
	description: "Representation of a BIT type."
	date: "$Date$"
	revision: "$Revision$"

class BITS_AS

inherit
	TYPE_AS

create
	initialize

feature {NONE} -- Initialization

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

	bits_value: INTEGER_AS
			-- Bits value

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := bits_value.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := bits_value.end_location
		end

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
			Result.append_integer (bits_value.integer_32_value)
		end

end -- class BITS_AS
