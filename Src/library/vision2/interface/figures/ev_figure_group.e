indexing
	description:
		"Group of EV_FIGURE's. If a figure is added to%
		%this group, it is removed from its previous group first."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "group, figure"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_GROUP

inherit
	EV_FIGURE
		redefine
			default_create,
			calculate_absolute_position,
			validate,
			invalidate,
			invalid_rectangle,
			update_rectangle,
			bounding_box
		end

	ARRAYED_LIST [EV_FIGURE]
		rename
			make as list_make
		export
			{NONE} put_i_th
		undefine
			is_equal,
			copy
		redefine
			append,
			force_i_th,
			replace,
			insert,
			prune_all,
			wipe_out,
			remove,
			merge_left,
			merge_right,
			make_from_array,
			default_create
		end

	EV_SINGLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_point
	
create {EV_FIGURE_GROUP}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create without point.
		do
			Precursor {EV_FIGURE}
			list_make (5)
		end

feature -- Status setting

	snap_to_grid is
			-- Move all move handles to most nearby point on the grid.
		require
			world_not_void: world /= Void
			grid_enabled: world.grid_enabled
		local
			g: EV_FIGURE_GROUP
		do
			from start until after loop
				g ?= item
				if g /= Void then
					g.snap_to_grid
				end
				forth
			end
		end

feature -- Status report

	invalid_rectangle: EV_RECTANGLE is
			-- Rectangle that needs erasing.
			-- `Void' if no change is made.
		local
			f: EV_FIGURE
			r: EV_RECTANGLE
		do
			from
				start
			until
				after
			loop
				f := item
				r := f.invalid_rectangle
				if r /= Void then
					if Result = Void then
						Result := r
					else
						Result.merge (r)
					end
				end
				forth
			end
		end

	update_rectangle: EV_RECTANGLE is
			-- Rectangle that needs redrawing.
			-- `Void' if no change is made.
		local
			f: EV_FIGURE
			r: EV_RECTANGLE
		do
			from
				start
			until
				after
			loop
				f := item
				r := f.update_rectangle
				if r /= Void then
					if Result = Void then
						Result := r
					else
						Result.merge (r)
					end
				end
				forth
			end
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			f: EV_FIGURE
			r: EV_RECTANGLE
		do
			create Result.make (points.first.x_abs, points.first.y_abs, 1, 1)
			from
				start
			until
				after
			loop
				f := item
				r := f.bounding_box
				if r /= Void then
					Result.merge (r)
				end
				forth
			end
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
			-- Always returns `False', but descendants can override
			-- it to improve efficiency.
		do
			Result := False
		end

feature -- Recomputation

	calculate_absolute_position is
			-- Recalculates all absolute positions inside this group.
		do
			Precursor {EV_FIGURE}
			from
				start
			until
				after
			loop
				item.calculate_absolute_position
				forth
			end
		end

	invalidate is
			-- Some property of `Current' has changed.
		do
			Precursor {EV_FIGURE}
			from start until after loop
				item.invalidate
				forth
			end
		end

	validate is
			-- Invalidate `Current'.
		do
			Precursor {EV_FIGURE}
			from start until after loop
				item.validate
				forth
			end
		end

feature -- List operations

	insert (fig: like item; i: INTEGER) is
			-- Add `fig' to the group.
		do
			Precursor {ARRAYED_LIST} (fig, i)
			fig.set_group (Current)
			full_redraw
		end

	force_i_th (fig: like item; i: INTEGER) is
			-- Add `fig' to the group.
		do
			Precursor {ARRAYED_LIST} (fig, i)
			fig.set_group (Current)
			full_redraw
		end

	replace (fig: like item) is
			-- Add `fig' to the group.
		do
			item.unreference_group
			Precursor {ARRAYED_LIST} (fig)
			fig.set_group (Current)
			full_redraw
		end

	remove is
			-- Remove `item' from figure.
		do
			item.unreference_group
			Precursor {ARRAYED_LIST}
			full_redraw
		end

	prune_all (fig: like item) is
			-- Remove `fig' from the group.
		do
			if has (fig) then
				fig.unreference_group
			end
			Precursor {ARRAYED_LIST} (fig)
			full_redraw
		end

	merge_left (other: ARRAYED_LIST [EV_FIGURE]) is
			-- Merge `other' into group before cursor.
			-- `other' will be empty afterwards.
		do
			change_group (other)
			Precursor {ARRAYED_LIST} (other)
			full_redraw
		end

	merge_right (other: ARRAYED_LIST [EV_FIGURE]) is
			-- Merge `other' into group after cursor.
			-- `other' will be empty afterwards.
		do
			change_group (other)
			Precursor {ARRAYED_LIST} (other)
			full_redraw
		end

	wipe_out is
			-- Unreference all groups.
		do
			from start until after loop
				item.unreference_group
				forth
			end
			Precursor {ARRAYED_LIST}
			full_redraw
		end
		
	append (s: SEQUENCE [EV_FIGURE]) is
			-- Append a copy of `s'.
		local
			l: like s
			l_cursor: CURSOR
		do
			if s = Current then
				l := s.twin
			else
				l := s
			end
			from
				l_cursor := cursor
				l.start
			until
				l.exhausted
			loop
				extend (l.item)
				l.forth
			end
			go_to (l_cursor)
		end
		
	make_from_array (a: ARRAY [EV_FIGURE]) is
			-- Create list from array `a'.
		local
			i: INTEGER
		do
			wipe_out
			from
				i := a.lower
			until
				i > a.upper
			loop
				extend (a.item (i))
				i := i + 1
			end
		end 

feature {NONE} -- Implementation

	change_group (other: ARRAYED_LIST [EV_FIGURE]) is
			-- Change group of all figures in `other' to Current.
			-- Used by `merge_left' and `merge_right'.
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > other.count
			loop
				other.i_th (n).set_group (Current)
				n := n + 1
			end
		end

	full_redraw is
			-- Request `invalid_rectangle' to be ignored.
		local
			w: EV_FIGURE_WORLD
		do
			w := world
			if w /= Void then
				w.full_redraw
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FIGURE_GROUP

