indexing
	description: "Object that represents a modifier to roundtrip-parsed class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUNDTRIP_MODIFIER

inherit
	COMPARABLE

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := start_position < other.start_position or
		 			((start_position = other.start_position) and (index < other.index))
		end

feature -- Status reporting

	start_position: INTEGER assign set_start_position
			-- Start position of this modifier

	end_position: INTEGER
			-- End position of this modifier

	within_region (a_pos: INTEGER): BOOLEAN is
			-- Is a position `a_pos' in region of this modifier?
		require
			a_pos_non_negative: a_pos >=0
		deferred
		end

	can_add (a_pos: INTEGER): BOOLEAN is
			-- Can some text be added at position `a_pos' due to current modifier?
		require
			position_valid: a_pos > 0
		deferred
		end

	can_del (start_pos, end_pos: INTEGER): BOOLEAN is
			--  Can region from `start_pos' to `end_pos' be removed due to current modifier?
		require
			position_valid: start_pos > 0 and start_pos <= end_pos
		deferred
		end

feature -- Status setting

	set_start_position (pos: INTEGER) is
			-- Set `start_position' with `pos'.
		do
			start_position := pos
		ensure
			start_position_set: start_position = pos
		end

	set_end_position (pos: INTEGER) is
			-- Set `end_position' with `pos'.
		do
			end_position := pos
		ensure
			end_position_set: end_position = pos
		end

	set_index (a_index: INTEGER) is
			-- Set `index' with `a_index'.
		do
			index := a_index
		ensure
			index_set: index = a_index
		end

feature -- Modification

	modify (a_text: STRING) is
			-- Modify `text' and set `modified_index'.
		deferred
		end

	index: INTEGER
			-- This is the `index'-th modification

	modified_index: INTEGER
			-- Last modified index
end
