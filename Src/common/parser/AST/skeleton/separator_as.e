indexing
	description: "Abstract description of one or more Eiffel separators"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEPARATOR_AS

inherit
	LEAF_AS
		redefine
			text
		end

create
	make, make_with_data

feature -- Initialization

	make (a_scn: EIFFEL_SCANNER) is
			-- Create an separator object using information included in `a_scn'.
		require
			a_scn_not_void: a_scn /= Void
		do
			set_internal_text (a_scn.text)
			make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	make_with_data (a_text: STRING; l, c, p, s: INTEGER) is
			-- Create an separator object with `a_text' as literal text of separators in source code.
			-- `l', `c', `p', `s' are positions. See `make_with_location' for more information.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			set_internal_text (a_text.string)
			make_with_location (l, c, p, s)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
		do
		end

	text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of this token
		do
			Result := internal_text
		end

feature -- Visitor

	process (v: AST_VISITOR) is
		do
			v.process_separator_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
		do
			Result := is_equal (other)
		end

feature{NONE} -- Implementation

	set_internal_text (s: STRING) is
			-- Set `internal_text' with `s'.
		do
			internal_text := s
		ensure
			internal_text_set: internal_text = s
		end

	internal_text: STRING
			-- Literal string

end
