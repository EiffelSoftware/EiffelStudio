indexing
	description: "Ancestor of all figures."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FIGURE

feature -- Access

	group: EV_FIGURE_GROUP
			-- The group this figure belongs to.
			-- Void means this figure is not in a group.

feature -- Recomputation

	calculate_absolute_position is
			-- Recalculate abs. coords. of any position this figure may have.
			-- Not if absolute_position_valid is already True.
		deferred
		end

	invalidate_absolute_position is
			-- Invalidates the absolute positions of figures.
			-- Not if no positioner installed and position not changed.
			-- This is the way to let positioners be called again.
		deferred
		end

feature {EV_FIGURE_GROUP} -- Implementation

	set_group (new_group: EV_FIGURE_GROUP) is
			-- Set the figure-group of this figure to `new_group'.
		require
			not_group_exists: group = Void
			new_group_exists: new_group /= Void
		do
			group := new_group
		ensure
			group_assigned: group = new_group
		end

	remove_from_group is
			-- Remove the reference to the group, since the figure has been removed from it.
		require
			group_exists: group /= Void
		do
			group := Void
		ensure
			not_group_exists: group = Void
		end

end -- class EV_FIGURE
