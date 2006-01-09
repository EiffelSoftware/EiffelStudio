indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUNDTRIP_DELETION_MODIFIER

inherit
	ROUNDTRIP_MODIFIER

create
	make

feature{NONE} -- Implementation

	make (start_pos, end_pos, a_index: INTEGER) is
			-- Initialize
		do
			set_start_position (start_pos)
			set_end_position (end_pos)
			set_index (a_index)
		end

feature -- Status setting

	modify (a_text: STRING) is
			-- Modify `text' and set `modified_index'.
		do
			modified_index := end_position + 1
		end

feature -- Status reporting

	within_region (a_pos: INTEGER): BOOLEAN is
			-- Is a position `a_pos' in region of this modifier?
		do
			Result := a_pos >= start_position and a_pos <= end_position
		end

	can_add (a_pos: INTEGER): BOOLEAN is
			-- Can some text be added at position `a_pos' due to current modifier?
		do
			Result := not (a_pos >= start_position and a_pos <= end_position)
		end

	can_del (start_pos, end_pos: INTEGER): BOOLEAN is
			--  Can region from `start_pos' to `end_pos' be removed due to current modifier?
		do
			Result := not (
				(start_pos <= start_position and end_pos >= start_position) or
				(start_pos <= end_position and end_pos >= end_position) or
				(start_pos >= start_position and end_pos <= end_position) or
				(start_pos <= start_position and end_pos >= end_position))
		end

end
