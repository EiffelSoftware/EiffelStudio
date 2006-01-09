indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUNDTRIP_ADDITION_MODIFIER

inherit
	ROUNDTRIP_MODIFIER

create
	make

feature
	make (start_pos: INTEGER; a_index: INTEGER; a_text: STRING) is
			-- Initialize.
		do
			set_start_position (start_pos)
			set_end_position (start_pos)
			set_index (a_index)
			set_text (a_text)
		end


feature -- Status reporting

	within_region (a_pos: INTEGER): BOOLEAN is
			-- Is a position `a_pos' in region of this modifier?
		do
			Result := a_pos = start_position
		end

	can_add (a_pos: INTEGER): BOOLEAN is
			-- Can some text be added at position `a_pos' due to current modifier?
		do
			Result := a_pos /= start_position
		end

	can_del (start_pos, end_pos: INTEGER): BOOLEAN is
			--  Can region from `start_pos' to `end_pos' be removed due to current modifier?
		do
			Result := (start_pos >= start_position) or (end_pos < start_position)
		end

feature

	text: STRING assign set_text
			-- `Text' to be added.

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		do
			text := a_text.twin
		ensure
			text_set: text.is_equal (a_text)
		end

	modify (a_text: STRING) is
			-- Modify `a_text' and set `modified_index'.
		do
			a_text.append (text)
			modified_index := start_position
		end

invariant
	start_position_equal_to_end_position: start_position = end_position

end
