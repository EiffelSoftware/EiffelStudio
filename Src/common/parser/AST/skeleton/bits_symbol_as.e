indexing
	description: 
		"AST representation of bit symbols."
	date: "$Date$"
	revision: "$Revision $"

class
	BITS_SYMBOL_AS

inherit
	BASIC_TYPE
		rename
			initialize as initialize_basic_type
		redefine
			is_equivalent,
			process
		end

feature {AST_FACTORY} -- Initialization

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

	bits_symbol: ID_AS;
			-- Bits value

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
			!!Result.make (5 + bits_symbol.count);
			Result.append ("BIT ");
			Result.append (bits_symbol);
   		end

end -- class BITS_SYMBOL_AS
