indexing
	description: "Leaf for Eiffel syntax node."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LEAF_AS

inherit
	AST_EIFFEL
		undefine
			number_of_breakpoint_slots
		end

	LOCATION_AS
		rename
			make as make_with_location
		end

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := Current
		end

	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := Current
		end

feature -- Roundtrip

	text: STRING
			-- Literal text of this token

	index: INTEGER
			-- Index in `match_list', a structure to store all tokens (including breaks and comments).

	set_shared_text (a_scn: EIFFEL_SCANNER) is
			-- Set `text' with `a_scn'.text.
			-- This facility will be used later, but for now, it is the same as `set_text'.
		require
			a_scn_not_void: a_scn /= Void
		do
			set_text (a_scn.text)
		end

	set_text (a_text: like text) is
			-- Set `text' with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			text := a_text
		ensure
			text_set: text = a_text
		end

	set_index (i: INTEGER) is
			-- Set `index' with `i'.
		require
			i_not_negative: i >= 0
		do
			index := i
		ensure
			index_set: index = i
		end

end
