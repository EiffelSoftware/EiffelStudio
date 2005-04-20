indexing
	description: "AST representation of bit symbols."
	date: "$Date$"
	revision: "$Revision$"

class BITS_SYMBOL_AS

inherit
	TYPE_AS
		redefine
			append_to
		end

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

feature

	actual_type: BITS_A is
			-- Actual bits type
		do
				-- FIXME: Most probably, we need to fix it in the Eiffel grammar in
				-- order to avoid the following declaration:
				--   class TEST [g->ARRAY [BIT toto]]
				-- In that case only, we can't allow `BIT toto' however we can allow
				-- `BIT x' where x is a number.
				--
				-- For now, since we cannot prevent the user to use
				-- a BIT type within the declaration of a GENERIC CONSTRAINT we have to
				-- create something, even if it is wrong, to emphasize, we cannot
				-- set `bit_count' to `-1', because of a precondition of `BITS_A.make',
				-- so we set it to 1.
				-- But that's ok, since the result will never been used except for 
				-- displaying an error.
			create Result.make (1)
		end

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("BIT ")
			st.add_string (bits_symbol)
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
