indexing
	description:
		"Graphical representations of items that %N%
		%can be linked with each other, without %N%
		%commitment to any notation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LINKABLE_FIGURE

inherit
	DIAGRAM_COMPONENT
		undefine
			is_equal
		end

feature -- Access
	
	name: STRING
			-- Item name.

	broken_name: STRING
			-- Item name, word wrapped.

	cluster_figure: CLUSTER_FIGURE is
			-- Cluster `Current' belongs to.
		do
		end

	ancestor_figures: LINKED_LIST [INHERITANCE_FIGURE]
			-- Links to ancestors.

	descendant_figures: LINKED_LIST [INHERITANCE_FIGURE]
			-- Links to descendants.

	client_figures: LINKED_LIST [CLIENT_SUPPLIER_FIGURE]
			-- Links to clients.

	supplier_figures: LINKED_LIST [CLIENT_SUPPLIER_FIGURE]
			-- Links to suppliers.

	all_descendants: LINKED_LIST [LINKABLE_FIGURE] is
			-- All figures that (in)directly inherit from
			-- `Current' and are in the diagram.
			-- Used to detect circular inheritance.
		local
			d: LINKED_LIST [INHERITANCE_FIGURE]
			sd: LINKED_LIST [LINKABLE_FIGURE]
		do
			d := descendant_figures
			create Result.make
			from
				d.start
			until
				d.after
			loop
				Result.extend (d.item.descendant)
				sd := d.item.descendant.all_descendants
				from sd.start until sd.after loop
					Result.extend (sd.item)
					sd.forth
				end
				d.forth
			end
		end

feature -- Status report

	left: INTEGER is
			-- Absolute left position.
		deferred
		end

	top: INTEGER is
			-- Absolute top position.
		deferred
		end

	right: INTEGER is
			-- Absolute right position.
		deferred
		end

	bottom: INTEGER is
			-- Absolute bottom position.
		deferred
		end

	x_position: INTEGER is
			-- Absolute center x coordinate.
		deferred
		end

	y_position: INTEGER is
			-- Absolute center y coordinate.
		deferred
		end

	width: INTEGER is
			-- Horizontal size.
		deferred
		end

	height: INTEGER is
			-- Vertical size.
		deferred
		end

feature -- Element change

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			a_name_not_void: a_name /= Void
			-- a_name in uppercase
		do
			name := a_name
		ensure
			assigned: name.is_equal (a_name)
		end

	change_origin (new_origin: EV_RELATIVE_POINT) is
   			-- Set the point this figure is relative to.
   			-- Do not change absolute coordinates.
		require
			new_origin_not_void: new_origin /= Void
		deferred
		end

	remove_from_diagram (exclude_needed: BOOLEAN) is
			-- Remove `Current' from its diagram, exclude it if `exclude_needed'.
		deferred
		end

	put_back_on_diagram (d: CONTEXT_DIAGRAM) is
			-- Put `Current' back on `d'.
		require
			diagram_not_void: d /= Void
		deferred
		end

	update_edge_point (p: EV_RELATIVE_POINT; angle: REAL) is
			-- Move `p', which is relative to `Current', to a point on the
			-- edge where the outline intersects a line from the center point
			-- in direction `angle'.
		require
			p_not_void: p /= Void
			p_relative_to_current: p.origin = point
		deferred
		end

	update is
			-- `Current' has just been moved/resized.
		deferred
		end

	update_and_project is 
			-- Call `update' and a projection of world `Current' is in.
		do
			update
			if world /= Void then
				world.context_editor.projector.project
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := (other.name.is_equal (name))
		end

end -- class LINKABLE_FIGURE
