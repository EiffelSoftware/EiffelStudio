indexing

	description: 
		"Undoable command that switches the label position %
		%from one side of the link to the other (for toggle).";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_LABEL_POSITION_U

inherit

	LABEL_MOVING_U

creation

	make

feature -- Initialization

	make (a_link: like link; on_left_side: BOOLEAN;
					reverse_capability: BOOLEAN) is
			-- Move link's label on the opposite side
		require
			has_link: a_link /= Void
		do
			set_watch_cursor;
			link := a_link;
			reverse := reverse_capability;
			left_side := on_left_side;
			record;
			redo;
			restore_cursor;
		ensure
			link_set:      link = a_link;
			reverse_set:   reverse = reverse_capability;
			left_side_set: left_side = on_left_side;
			link_side_set:  (not reverse) implies (link.is_left_position = on_left_side) 
			reverse_link_side_set: reverse implies (link.is_reverse_left_position = on_left_side) 
		end

feature -- Property

	name: STRING is
		do
			if reverse then
				if left_side then
					Result := "Move reverse label on left side"
				else
					Result := "Move reverse label on right side"
				end
			else
				if left_side then
					Result := "Move label on left side"
				else
					Result := "Move label on right side"
				end
			end
		end -- name

feature -- Update

	redo is
			-- Change the side of label
		do
			if reverse then
				link.change_reverse_label_position
			else
				link.change_label_position
			end;
			update
		end


end -- class CHANGE_LABEL_POSITION_U
