indexing
	description: 
		"AST representation of a bit constant."
	date: "$Date$"
	revision: "$Revision$"

class
	BIT_CONST_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

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

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
		end

feature -- Output

	string_value: STRING is
		do
			create Result.make (0);
			Result.append (value)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_string (value)
--			ctxt.put_string ("B");
--		end

end -- class BIT_CONST_AS
