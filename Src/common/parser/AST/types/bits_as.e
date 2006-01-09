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

	initialize (v: like bits_value; b_as: KEYWORD_AS) is
			-- Create a new BITS AST node.
		require
			v_not_void: v /= Void
		do
			bits_value := v
			bit_keyword := b_as
		ensure
			bits_value_set: bits_value = v
			bit_keyword_set: bit_keyword = b_as
		end
feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_as (Current)
		end

feature -- Roundtrip

	bit_keyword: KEYWORD_AS
		-- Keyword "bit" associated with this structure		

feature -- Attributes

	bits_value: INTEGER_AS
			-- Bits value

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := bits_value.complete_start_location (a_list)
			else
				Result := bit_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := bits_value.complete_end_location (a_list)
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
