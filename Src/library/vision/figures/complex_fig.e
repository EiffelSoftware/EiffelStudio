indexing

	description: 
		"Figure made of a number of subfigures. %
		%A COMPLEX_FIG is both a figure and a list of figures"; 
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	COMPLEX_FIG

inherit
	
	COMPOSITE_FIG	
		rename
			merge as merge_right,
			remove as remove_fig,
			composite_mark as complexe_mark,
			composite_return as complexe_return
		undefine
			copy, is_equal
		redefine
			set_origin,
			set_no_origin,
			clip_draw	
		end;

	LINKED_LIST [FIGURE]
		rename
			extend as list_add,
			put_left as list_put_left,
			put_right as list_put_right,
			duplicate as list_duplicate,
			merge_left as list_merge_left,
			merge_right as list_merge_right,
			put as list_put,
			put_i_th as list_put_i_th,
			make as linked_list_make
		end;

	LINKED_LIST [FIGURE]
		rename
			make as linked_list_make,
			extend as add
		redefine
			put_i_th, 
			put, 
			merge_right, 
			merge_left, 
			duplicate, 
			put_right, 
			put_left,
			add
		select
			put_i_th, 
			put, 
			merge_right, 
			merge_left, 
			duplicate, 
			put_right, 
			put_left,
			add
		end

creation

	make_fig, make_fig_with_plane

feature -- Initialization 

	make is
		do
			notify_make;
			linked_list_make;
			!! changes_box.make;
			!! surround_box.make;
			!! origin
		ensure
			is_empty
		end;

	make_fig is
			-- Create a world as a figure with f as a figure 
			-- for visual modification notification
		do
			init_fig (Void);
			make;
		end;

	make_fig_with_plane (plane_number: INTEGER) is
		do
			max_plane := plane_number;
			make_fig 
		end;

feature -- Access

	origin: COORD_XY_FIG;
			-- Origin of the figure

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		require else
			not_off: not off;
			valid_sublist: n >= 0
		do
			Result := list_duplicate (n);
			Result.attach_drawing_imp_with_parent (Current, drawing);
			Result.set_origin (origin)
		end;


feature -- Element change 

	add (v: like first) is
			-- Append `v' to list.
		do
			v.set_conf_not_notify;
			v.attach_drawing_imp_with_parent (Current, drawing);
			list_add (v);
			v.set_conf_notify;
			v.conf_recompute;	
			set_conf_modified_with (v.surround_box)
		end;

	put_left (v: like first) is
			-- Put item `v' to the left of cursor position.
			-- Do not move cursor.
		do
			v.set_conf_not_notify;
			v.attach_drawing_imp_with_parent (Current, drawing);
			list_put_left (v);
			v.set_conf_notify;
			v.conf_recompute;
			set_conf_modified_with (v.surround_box)
		end;

	put_right (v: like first) is
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
		do
			v.set_conf_not_notify;
			v.attach_drawing_imp_with_parent (Current, drawing);
			list_put_right (v);
			v.set_conf_notify;
			v.conf_recompute;
			set_conf_modified_with (v.surround_box)
		end;

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
				other.item.attach_drawing_imp_with_parent (Current, drawing);
				other.forth
			end;
			list_merge_left (other);
			set_conf_modified_with (other.surround_box)
		end;

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
				other.item.attach_drawing_imp_with_parent (Current, drawing);
				other.forth
			end;
			list_merge_right (other);
			set_conf_modified_with (other.surround_box)
		end;

	put (v: like first) is
			-- Put item `v' at cursor position.
		require else
			not_off: not off
		do
			v.attach_drawing_imp_with_parent (Current, drawing);
			list_put (v);
			set_conf_modified_with (v.surround_box)
		end;

	put_i_th (v: like first; i: INTEGER) is
			-- Put item `v' at `i'-th position.
		do
			v.attach_drawing_imp_with_parent (Current, drawing);
			list_put_i_th (v, i);
			set_conf_modified_with (v.surround_box)
		end;

	set_origin (p: like origin) is
			-- Set `origin' to `p'.
		do
			origin := p
		end;

feature -- Removal

	remove_fig (fig: FIGURE) is
			-- Search for 'fig' and remove it
		do
			complexe_mark;
			start;
			search (fig);
			if not off then
				remove;
				set_conf_modified_with (fig.surround_box)
			end;
			complexe_return
		end;

feature -- Output

	clip_draw (clip: CLIP) is
			-- Draw in the 'clip' area
		do
			if conf_modified then
				conf_recompute
			end;
			complexe_mark;
			from
				start
			until
				off
			loop
				if item.surround_box.override (clip) then
					item.clip_draw (clip)
				end;
				forth
			end
		end;

feature {NONE} -- Access

	linked_list_cursor: CURSOR;

feature {NONE} -- Element change

	set_no_origin is
			-- Erase definition of `origin'.
		do
			origin := Void
		end;

feature {NONE} -- Cursor movement

	complexe_mark is
		do
			linked_list_cursor := cursor
		end;

	complexe_return is
		do
			go_to (linked_list_cursor)
		end;
		
end -- class COMPLEX_FIG

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

