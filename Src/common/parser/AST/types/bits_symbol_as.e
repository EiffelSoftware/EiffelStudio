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

	initialize (s: like bits_symbol) is
			-- Create a new BITS_SYMBOL AST node.
		require
			s_not_void: s /= Void
		do
			bits_symbol := s
		ensure
			bits_symbol_set: bits_symbol = s
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_symbol_as (Current)
		end

feature -- Attributes

	bits_symbol: ID_AS
			-- Bits value

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := bits_symbol.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := bits_symbol.end_location
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
