indexing
	description: 
		"Undoable command that moves a label. %
		%Continuous move (for drag-and_drop,...).";
	date: "$Date$";
	revision: "$Revision $"

class MOVE_LABEL_U

inherit

	LABEL_MOVING_U

creation

	make

feature -- Initialization

	make (a_link: like link; on_left_side, reverse_capability: BOOLEAN; 
			r: REAL; from_h_nbr: INTEGER) is
		require
			visible: not label_hidden 

			has_link: a_link /= Void
			valid_r: r >= 0 and then r <= 1
		do
			set_watch_cursor;
			ratio := r
			link := a_link;
			reverse := reverse_capability;
			left_side := on_left_side;
			from_handle_nbr := from_h_nbr;
			record;
			redo;
			restore_cursor;

		ensure
			link_correctly_set:      link = a_link;
			reverse_correctly_set:   reverse = reverse_capability;
			
			link_side_set:  (not reverse) implies (link.is_left_position = on_left_side) 
			reverse_link_side_set: reverse implies (link.is_reverse_left_position = on_left_side) 

			link_from_ratio_set: (not reverse) implies (link.label.from_ratio = r) 
			reverse_link_fom_ratio_set: reverse implies (link.reverse_label.from_ratio = r) 

			link_from_handle_nbr_set: (not reverse) implies (link.label.from_handle_nbr = from_h_nbr)
			reverse_link_from_handle_nbr_set: reverse implies (link.reverse_label.from_handle_nbr = from_h_nbr)
		end 

feature -- Property

	name: STRING is
			-- Command name to be inserted into history list
		do
			if reverse then
				Result := "Move reverse label"
			else
				Result := "Move label"
			end
		end -- name

feature -- Setting

	redo is
			-- Move label
		do
			if reverse then
				move_reverse
			else
				move_not_reverse
			end;
			update 
		end;

feature {NONE} -- Implementation properties

	from_handle_nbr: INTEGER;
			-- From handle nbr for label

	ratio: REAL
			-- From ratio for label positioning
			--| 0 is at the beginning of the link, 1 at its end

feature {NONE} -- Implementation setting 

	move_not_reverse is 
			-- Move normal label.
		require
			not_reverse: not reverse
		local
			old_ratio: like ratio;
			old_left_side: like left_side;
			old_from_handle_nbr: like from_handle_nbr
		do
			-- Save old state of link:

			old_left_side := link.is_left_position;
			old_ratio := link.label.from_ratio;
			old_from_handle_nbr := link.label.from_handle_nbr;

			-- Move label:

			if left_side /= link.is_left_position then
				link.change_label_position
			end;
			link.label.set_from_ratio (ratio)
			link.label.set_from_handle_nbr (from_handle_nbr)

			-- Retrieve old state of link (for future undos):

			ratio := old_ratio;
			from_handle_nbr := old_from_handle_nbr;
			left_side := old_left_side;

		ensure 
			side_set: left_side = old link.is_left_position
			ratio_set: ratio = old link.label.from_ratio
			from_handle_nbr_set: from_handle_nbr = old link.label.from_handle_nbr
		end; 

	move_reverse is 
			-- Move reverse label.
		require
			reverse: reverse
		local
			old_ratio: like ratio;
			old_left_side: like left_side;
			old_from_handle_nbr: like from_handle_nbr
		do
			-- Save old state of link:

			old_ratio := link.reverse_label.from_ratio;
			old_from_handle_nbr := link.reverse_label.from_handle_nbr;
			old_left_side := link.is_reverse_left_position;

			-- Move label:

			if left_side /= link.is_reverse_left_position then
				link.change_reverse_label_position
			end;
			link.reverse_label.set_from_ratio (ratio)
			link.reverse_label.set_from_handle_nbr (from_handle_nbr)

			-- Retrieve old state of link (for future undos):

			ratio := old_ratio;
			from_handle_nbr := old_from_handle_nbr;
			left_side := old_left_side;

		ensure 
			side_set: left_side = old link.is_reverse_left_position 
			ratio_set: ratio = old link.reverse_label.from_ratio
			from_handle_nbr_set: from_handle_nbr = old link.reverse_label.from_handle_nbr
		end; 



end -- class MOVE_LABEL_U

