indexing
	description: "Group of EV_FIGURE's. Behaves as a linked-list and updates the%
		%group property of the added/removed figure. Adds conditions that you%
		%cannot add a figure that is already in a group."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_GROUP

inherit
	EV_FIGURE
		redefine
			default_create
		end

	LINKED_LIST [EV_FIGURE]
		rename
			make as list_make
		export {NONE}
			merge_left,
			merge_right
		redefine
			new_cell,
			cleanup_after_remove,
			default_create
		end

create
	default_create,
	make

feature -- Initialization

	default_create is
		do
			Precursor
			create position
			list_make
		end

	make (p: EV_FIGURE_POSITION) is
			-- Make on position `p'.
		do
			default_create
			set_position (p)
		end

feature -- Access

	position: EV_FIGURE_POSITION
			-- The groups' origin. Every in the group must 
			-- have this position as origin (direct or indirect)

feature -- Status setting

	set_position (p: EV_FIGURE_POSITION) is
			-- Set `position' to `p'.
		require
			p_exists: p /= Void
		do
			position := p
		ensure
			position_assigned: position = p
		end

feature -- Recomputation

	calculate_absolute_position is
			-- Recalculates all absolute positions inside this group.
		do
			position.calculate_absolute_position
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
			-- Not if no positioner installed or position not changed.
		do
			position.invalidate_absolute_position
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
			-- Add `fig' to the group.
		require else
			fig_exists: fig /= Void
			fig_not_has_group: fig.group = Void
		do
			Result := Precursor (fig)
			fig.set_group (Current)
		end

	cleanup_after_remove (cell: LINKABLE [EV_FIGURE]) is
			-- Remove group from figure.
		do
			cell.item.remove_from_group
		ensure then
			fig_not_has_group: cell.item.group = Void
		end

invariant
	position_exists: position /= Void

	--| FIXME Do we restrict all children in the group that they
	--| must have position as (indirect) origin????

	--| Seems too restrictive but might make some sense.

end -- class EV_FIGURE_GROUP
