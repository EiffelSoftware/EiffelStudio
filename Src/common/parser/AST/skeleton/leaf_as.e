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
		redefine
			text
		end

	LOCATION_AS
		rename
			make as make_with_location
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := Current
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := Current
		end

feature -- Roundtrip

	text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of this token, which is stored in `a_list'
		require else
			a_list_can_be_void: a_list = Void
		do
			Result := a_list.i_th (index).text (Void)
		end

	index: INTEGER
			-- Index in `match_list', a structure to store all tokens (including breaks and comments).

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
