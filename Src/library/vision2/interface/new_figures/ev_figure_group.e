indexing
	description: "Group of EV_FIGURE's. If a figure is added to%
		%this group, it is removed from its previous group first."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_GROUP

inherit
	EV_FIGURE
		rename
			set_point as fig_set_point
		redefine
			default_create,
			calculate_absolute_position,
			invalidate_absolute_position,
			print_status,
			print_prefixed
		end

	LINKED_LIST [EV_FIGURE]
		rename
			make as list_make
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
			fig_set_point (1, pos)
		end

feature -- Status report

	point: EV_RELATIVE_POINT is
			-- The relative point of this figure group.
		do
			Result := get_point (1)
		end

feature -- Convenience

	get_relative_point (new_x, new_y: INTEGER): EV_RELATIVE_POINT is
			-- get a point relative to this group's point.
		do
			Result := point.get_relative_point (new_x, new_y)
		end

feature -- Standard output

	print_status is
			-- Write a textual representation of the group to
			-- the standard output.
		do
			print_prefixed ("")
		end

	print_prefixed (pref: STRING) is
			-- Write a textual representation of the group to
			-- the standard output, every line prefixed by `pref'.
		do
			from
				io.put_string (pref + "Group: ")
				point.print_status
				io.new_line
				start
			until
				after
			loop
				item.print_prefixed (pref + "  ")
				forth
			end			
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

feature {NONE} -- Implementation

	new_cell (fig: like item): like first_element is
			-- Add `fig' to the group. Remove from its group
			-- first if it is not Void.
		require else
			fig_exists: fig /= Void
			fig_relative_to_point: fig.relative_to (point)
		do
			-- Remove from old group, if any.
			if fig.group /= Void then
				fig.group.search (fig)
				fig.group.remove
			end
			Result := Precursor (fig)

			--| FIXME Set points??? Somehow?
			--| If figure's point's origins are Void set them to point?
			--| In that case, remove precondition...?

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
