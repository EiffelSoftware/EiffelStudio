indexing
	description: "Object that represents a component which can be put into {ES_GRID_LIST_ITEM}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRID_LIST_ITEM_COMPONENT

feature -- Access

	parent: ES_GRID_LIST_ITEM
			-- Parent grid item of Current component

	required_width: INTEGER is
			-- Required width in pixel of Current component
		deferred
		end

	required_height: INTEGER is
			-- Required height in pixel of Current component
		deferred
		end

	last_pebble: ANY
			-- Last pebble returned from `on_pick'

feature -- Actions

	on_pick (a_x, a_y: INTEGER) is
			-- Action to be performed when pick occurs at position (`a_x', `a_y') relative to top-left corner of current item
		deferred
		end

	on_pick_ended is
			-- Action to be performed when pick-and-drop process ended
		deferred
		end

feature -- Status report

	is_parented: BOOLEAN is
			-- Has Current component been parented to a grid list item?
		do
			Result := parent /= Void
		end

	is_displayable: BOOLEAN is
			-- Can Current component been displayed
		do
			Result := is_parented and then parent.is_parented
		end

feature{ES_GRID_LIST_ITEM} -- Setting/Parenting

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature{ES_GRID_LIST_ITEM} -- Drawing

	display (a_drawable: EV_DRAWABLE; a_x, a_y: INTEGER; a_max_width, a_max_height: INTEGER) is
			-- Draw Current component in `a_drawable' starting from (`a_x', `a_y').
			-- The maximum width and height in pixel for Current is `a_max_width' and `a_max_height' respectively.
		require
			displayable: is_displayable
			a_drawable_attached: a_drawable /= Void
		deferred
		end

feature{NONE} -- Setting

	set_last_pebble (a_pebble: like last_pebble) is
			-- Set `last_pebble' with `a_pebble'.
		do
			last_pebble := a_pebble
		ensure
			last_pebble_set: last_pebble = a_pebble
		end

end
