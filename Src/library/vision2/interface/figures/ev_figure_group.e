indexing
	description: "Group of EV_FIGURE's. If a figure is added to%
		%this group, it is removed from its previous group first."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_GROUP

inherit
	EV_FIGURE
		redefine
			default_create,
			calculate_absolute_position,
			invalidate_absolute_position,
			out
		select
			default_out
		end

	LINKED_LIST [EV_FIGURE]
		rename
			make as list_make,
			out as list_out
		redefine
			new_cell,
			merge_left,
			merge_right,
			cleanup_after_remove,
			default_create
		end

create
	default_create,
	make_with_point

feature {NONE} -- Initialization

	default_create is
			-- Create without point.
		do
			{EV_FIGURE} Precursor
			list_make
		end

	make_with_point (pos: EV_RELATIVE_POINT) is
			-- Make on point `pos'.
		require
			pos_exists: pos /= Void
		do
			default_create
			set_point (pos)
		end

feature -- Access

	point_count: INTEGER is
			-- Groups have one point.
		once
			Result := 1
		end

feature -- Status setting

	set_point (pos: EV_RELATIVE_POINT) is
			-- Set `point' to `pos'.
		require
			pos_exists: pos /= Void
			all_figures_relative_to (pos)
		do
			set_point_by_index (1, pos)
		end

feature -- Status report

	point: EV_RELATIVE_POINT is
			-- The relative point of this figure group.
		do
			Result := get_point_by_index (1)
		end

feature -- Standard output

	out: STRING is
			-- Write a textual representation of the group to
			-- the standard output.
		do
			from
				Result := "Group: " + point.out + "%N"
				start
			until
				after
			loop
				Result.append (item.out)
				forth
			end			
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			--| We want the projector to take care of this.
			--| If a figure in this group is on (x, y) then there
			--| will be an event triggered for this group as well.
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

	invalidate_absolute_position is
			-- Invalidates the absolute positions of figures.
		do
			Precursor
			from
				start
			until
				after
			loop
				item.invalidate_absolute_position
				forth
			end
		end

feature -- List operations

	new_cell (fig: like item): like first_element is
			-- Add `fig' to the group. Remove from its group
			-- first if it is not Void.
		require else
			fig_exists: fig /= Void
			fig_relative_to_point: fig.relative_to (point)
		do
			if fig.group /= Void then
				fig.group.prune (fig)
			end
			Result := Precursor (fig)
			set_relative_to_point (fig)
			fig.set_group (Current)
		end

	cleanup_after_remove (cell: LINKABLE [EV_FIGURE]) is
			-- Remove group from figure.
		do
			cell.item.unreference_group
		ensure then
			fig_not_has_group: cell.item.group = Void
		end

	merge_left (other: like Current) is
			-- Merge `other' into group before cursor.
			-- `other' will be empty afterwards.
			--| FIXME VB Not yet tested.
		require else
			all_figures_in_other_relative_to_group_point:
				other.all_figures_relative_to (point)
		do
			change_group (other)
			Precursor (other)
		end

	merge_right (other: like Current) is
			-- Merge `other' into group after cursor.
			-- `other' will be empty afterwards.
			--| FIXME VB Not yet tested.
		require else
			all_figures_in_other_relative_to_group_point:
				other.all_figures_relative_to (point)
		do
			change_group (other)
			Precursor (other)
		end

feature {NONE} -- Implementation

	change_group (other: like Current) is
			-- Change the group of all figures in `other; to Current.
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

	set_relative_to_point (fig: EV_FIGURE) is
			-- Change the origin of all points of `fig' if they are Void.
			--| FIXME Maybe go up in the origins and find the Void reference
			--| somewhere: this will mess up, but maybe something else.
			--| This function could be called intuitive I guess.
		require
			fig_exists: fig /= Void
		do
			from
				fig.points.start
			until
				fig.points.after
			loop
				if fig.points.item.origin = Void then
					fig.points.item.set_origin (point)
				end
				fig.points.forth
			end
		end
		
feature -- Assertion

	all_figures_relative_to (pos: EV_RELATIVE_POINT): BOOLEAN is
			-- Do all figures move relative to `pos'?
		local
			n: INTEGER
		do
			from
				n := 1
				Result := True
			until
				not Result or else n > count
			loop
				if not i_th (n).relative_to (pos) then
					Result := False
				end
				n := n + 1
			end
		end

invariant
	all_figures_relative_to_point: all_figures_relative_to (point)

end -- class EV_FIGURE_GROUP
