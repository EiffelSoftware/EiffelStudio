indexing
	description: "EiffelVision drawing:%
				% figure composed of a number of subfigures."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING

inherit
	EV_COMPOSITE_FIGURE
		rename
			merge as merge_right,
			remove as remove_fig,
			composite_mark as complexe_mark,
			composite_return as complexe_return
		redefine
			set_origin,
			set_no_origin,
			clip_draw
		end

	LINKED_LIST [FIGURE]
		rename
			extend as add
		redefine
			make,
			add,
			put_left,
			put_right,
			duplicate,
			merge_left,
			merge_right,
			put,
			put_i_th
		end

creation
	make, make_with_plane

feature {NONE} -- Initialization 

	make is
			-- Create a world as a figure with f as a figure 
			-- for visual modification notification
		do
			init_fig (Void)
			{LINKED_LIST} Precursor
			!! changes_box.make
			!! surround_box.make
			!! origin.make
		end

	make_with_plane (plane_number: INTEGER) is
		do
			max_plane := plane_number
			make_fig 
		end

feature -- Access

	origin: EV_POINT
			-- Origin of the figure

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		require else
			not_off: not off
			valid_sublist: n >= 0
		do
			Result := {LINKED_LIST} Precursor (n)
			Result.attach_drawing_imp_with_parent (Current, drawing)
			Result.set_origin (origin)
		end


feature -- Element change 

	add (v: like first) is
			-- Append `v' to list.
		do
			v.set_not_notify
			v.attach_drawing_imp_with_parent (Current, drawing)
			{LINKED_LIST} Precursor (v)
			v.set_notify
			v.recompute
			set_modified_with (v.surround_box)
		end

	put_left (v: like first) is
			-- Put item `v' to the left of cursor position.
			-- Do not move cursor.
		do
			v.set_not_notify
			v.attach_drawing_imp_with_parent (Current, drawing)
			{LINKED_LIST} Precursor (v)
			v.set_notify
			v.recompute
			set_modified_with (v.surround_box)
		end

	put_right (v: like first) is
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
		do
			v.set_not_notify
			v.attach_drawing_imp_with_parent (Current, drawing)
			{LINKED_LIST} Precursor (v)
			v.set_notify
			v.recompute
			set_modified_with (v.surround_box)
		end

	merge_left (other: like Current) is
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		do
			from
				other.start
			until
				other.off
			loop
				other.item.attach_drawing_imp_with_parent (Current, drawing)
				other.forth
			end
			{LINKED_LIST} Precursor (other)
			set_modified_with (other.surround_box)
		end

	merge_right (other: like Current) is
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		do
			from
				other.start
			until
				other.off
			loop
				other.item.attach_drawing_imp_with_parent (Current, drawing)
				other.forth
			end
			{LINKED_LIST} Precursor (other)
			set_modified_with (other.surround_box)
		end

	put (v: like first) is
			-- Put item `v' at cursor position.
		require else
			not_off: not off
		do
			v.attach_drawing_imp_with_parent (Current, drawing)
			{LINKED_LIST} Precursor (v)
			set_modified_with (v.surround_box)
		end

	put_i_th (v: like first; i: INTEGER) is
			-- Put item `v' at `i'-th position.
		do
			v.attach_drawing_imp_with_parent (Current, drawing)
			{LINKED_LIST} Precursor (v, i)
			set_modified_with (v.surround_box)
		end

	set_origin (p: like origin) is
			-- Set `origin' to `p'.
		do
			origin := p
		end

feature -- Removal

	remove_fig (fig: EV_FIGURE) is
			-- Search for 'fig' and remove it
		do
			complexe_mark
			start
			search (fig)
			if not off then
				remove
				set_modified_with (fig.surround_box)
			end
			complexe_return
		end

feature -- Output

	clip_draw (clip: EV_CLIP) is
			-- Draw in the 'clip' area
		do
			if modified then
				recompute
			end
			complexe_mark
			from
				start
			until
				off
			loop
				if item.surround_box.override (clip) then
					item.clip_draw (clip)
				end
				forth
			end
		end

feature {NONE} -- Access

	linked_list_cursor: CURSOR

feature {NONE} -- Element change

	set_no_origin is
			-- Erase definition of `origin'.
		do
			origin := Void
		end

feature {NONE} -- Cursor movement

	complexe_mark is
		do
			linked_list_cursor := cursor
		end

	complexe_return is
		do
			go_to (linked_list_cursor)
		end
		
end -- class EV_DRAWING

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

