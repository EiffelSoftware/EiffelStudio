indexing
	description: "Representation of a BIT type."
	date: "$Date$"
	revision: "$Revision$"

class BITS_AS

inherit
	TYPE_AS
		redefine
			append_to
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (v: like bits_value; b_as: KEYWORD_AS) is
			-- Create a new BITS AST node.
		require
			v_not_void: v /= Void
		local
			vtbt: VTBT_SIMPLE
		do
			bits_value := v
			if (bits_value.integer_32_value <= 0) then
				create vtbt
				vtbt.set_class (System.current_class)
				vtbt.set_value (bits_value.integer_32_value)
				vtbt.set_location (bits_value.start_location)
				Error_handler.insert_error (vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
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

feature -- Type evaluation

	append_to (st: STRUCTURED_TEXT) is
		do
			actual_type.append_to (st)
		end

	actual_type: BITS_A is
			-- Actual bits type
		do
			create Result.make (bits_value.integer_32_value)
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
