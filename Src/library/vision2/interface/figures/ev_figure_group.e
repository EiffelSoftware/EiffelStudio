indexing
	description:
		"Group of EV_FIGURE's. If a figure is added to%
		%this group, it is removed from its previous group first."
	status: "See notice at end of class"
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
			force_i_th,
			replace,
			insert,
			prune_all,
			wipe_out,
			remove,
			merge_left,
			merge_right,
			default_create
		end

	EV_SINGLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_point

feature {NONE} -- Initialization

	default_create is
			-- Create without point.
		do
			Precursor {EV_FIGURE}
			list_make (5)
		end

feature -- Status setting

	snap_to_grid is
			-- Move all move handles the most nearby point on the grid.
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
			-- Is the point on (`x', `y') on this figure?
			-- Always returns `False', but descendants can override
			-- it to improve efficiency.
		do
			Result := False
		end

feature -- Recomputation

	calculate_absolute_position is
			-- Recalculates all absolute positions inside this group.
		do
			Precursor
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
			Precursor
			from start until after loop
				item.invalidate
				forth
			end
		end

	validate is
			-- Invalidate `Current'.
		do
			Precursor
			from start until after loop
				item.validate
				forth
			end
		end

feature -- List operations

	insert (fig: like item; i: INTEGER) is
			-- Add `fig' to the group.
		do
			Precursor (fig, i)
			fig.set_group (Current)
			full_redraw
		end

	force_i_th (fig: like item; i: INTEGER) is
			-- Add `fig' to the group.
		do
			Precursor (fig, i)
			fig.set_group (Current)
			full_redraw
		end

	replace (fig: like item) is
			-- Add `fig' to the group.
		do
			item.unreference_group
			Precursor (fig)
			fig.set_group (Current)
			full_redraw
		end

	remove is
			-- Remove `item' from figure.
		do
			item.unreference_group
			Precursor
			full_redraw
		end

	prune_all (fig: like item) is
			-- Remove `fig' from the group.
		do
			if has (fig) then
				fig.unreference_group
			end
			Precursor (fig)
			full_redraw
		end

	merge_left (other: like Current) is
			-- Merge `other' into group before cursor.
			-- `other' will be empty afterwards.
		do
			change_group (other)
			Precursor (other)
			full_redraw
		end

	merge_right (other: like Current) is
			-- Merge `other' into group after cursor.
			-- `other' will be empty afterwards.
		do
			change_group (other)
			Precursor (other)
			full_redraw
		end

	wipe_out is
			-- Unreference all groups.
		do
			from start until after loop
				item.unreference_group
				forth
			end
			Precursor
			full_redraw
		end

feature {NONE} -- Implementation

	change_group (other: like Current) is
			-- Change the group of all figures in `other' to Current.
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

end -- class EV_FIGURE_GROUP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
