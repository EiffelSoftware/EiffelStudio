indexing
    description: "Node for id."
    date: "$Date$"
    revision: "$Revision$"

class
	ID_AS

inherit
	ATOMIC_AS
		undefine
			copy, out, is_equal
		redefine
			is_id,
			is_equivalent
		end

	STRING
		rename
			set as string_set,
			is_integer as string_is_integer
		end

creation
	make, initialize

feature {AST_FACTORY} -- Initialization

	initialize (s: STRING) is
			-- Create a new ID AST node made up
			-- of characters contained in `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			make (s.count)
			append_string (s)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_id_as (Current)
		end

feature -- Properties

	is_id: BOOLEAN is True
			-- Is the current atomic node an id ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_equal (other)
		end

feature {FEAT_NAME_ID_AS, ROUTINE_AS} -- Conveniences

	load (s: STRING) is
		do
			wipe_out
			append (s)
		end

feature -- {AST_EIFFEL, AST_VISITOR} -- Output

--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_string (Current)
--		end

	string_value: STRING is
		do
			Result := clone (Current)
		end

end -- class ID_AS