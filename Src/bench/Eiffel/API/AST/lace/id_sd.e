indexing
	description: "Node for ID.";
	date: "$Date$";
	revision: "$Revision$"

class ID_SD

inherit
	AST_LACE
		undefine
			copy, out, is_equal
		end

	STRING
		rename
			adapt as string_adapt,
			set as string_set
		end

create
	make, initialize

feature {LACE_AST_FACTORY} -- Initialization

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

feature -- Status

	is_string: BOOLEAN
			-- Is Current a representation of a manifest string and
			-- not of an identifer.

feature {LACE_AST_FACTORY} -- Access

	set_is_string is
			-- Set `is_string' to `True'.
		require
			not_is_string: not is_string
		do
			is_string := True
		ensure
			is_string_set: is_string
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			Result := clone (Current)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := is_equal (other)
		end

feature -- Save 

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			if is_string then
				st.putchar ('"')
			end
			st.putstring (Current)
			if is_string then
				st.putchar ('"')
			end
		end

end -- class ID_SD
