indexing
    description: "Node for id. Version for Bench."
    date: "$Date$"
    revision: "$Revision$"

class ID_AS

inherit
	LEAF_AS
		undefine
			copy, out, is_equal
		end

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

create
	make, initialize

feature {NONE} -- Initialization

	initialize (s: STRING) is
			-- Create a new ID AST node made up
			-- of characters contained in `s'.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		local
			l_int: INTEGER
		do
			make (s.count)
			append (s)
				-- Force computation of `hash_code' so that it gets stored in AST.
			l_int := hash_code
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

feature {AST_EIFFEL} -- Output

	string_value: STRING is
		do
			Result := twin
		end

end -- class ID_AS
