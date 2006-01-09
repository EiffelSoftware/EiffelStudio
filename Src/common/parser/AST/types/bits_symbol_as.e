indexing
	description: "AST representation of bit symbols."
	date: "$Date$"
	revision: "$Revision$"

class BITS_SYMBOL_AS

inherit
	TYPE_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (s: like bits_symbol; b_as: KEYWORD_AS) is
			-- Create a new BITS_SYMBOL AST node.
		require
			s_not_void: s /= Void
		do
			bits_symbol := s
			bit_keyword := b_as
		ensure
			bits_symbol_set: bits_symbol = s
			bit_keyword_set: bit_keyword = b_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_symbol_as (Current)
		end

feature -- Roundtrip

	bit_keyword: KEYWORD_AS
		-- Keyword "bit" associated with this structure


feature -- Attributes

	bits_symbol: ID_AS
			-- Bits value

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := bits_symbol.complete_start_location (a_list)
			else
				Result := bit_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := bits_symbol.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_symbol, other.bits_symbol)
		end

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			create Result.make (5 + bits_symbol.count)
			Result.append ("BIT ")
			Result.append (bits_symbol)
   		end

invariant
	bits_symbol_not_void: bits_symbol /= Void

end -- class BITS_SYMBOL_AS
