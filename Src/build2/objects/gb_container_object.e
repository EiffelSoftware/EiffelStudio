indexing
	description: "GB_OBJECT representing an EV_CONTAINER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CONTAINER_OBJECT

inherit
	GB_OBJECT
		redefine
			object, display_object, is_full
		end
		
	GB_PARENT_OBJECT

create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_CONTAINER
		-- A representation of `Current' used
		-- in the display_window.
	
	display_object: GB_DISPLAY_OBJECT
		-- A representation of `Current' used
		-- in the builder_window

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
			-- This is redefined in descendents as insertion at position `position'
			-- is different for each type of container.
		require
			position_valid: not type_conforms_to (dynamic_type (Current), dynamic_type_from_string ("GB_SPLIT_AREA_OBJECT")) implies position >=1 and position <= object.count + 1
		do
		ensure
			one_item_added_to_object: object.count = old object.count + 1
			one_item_added_to_display_object: display_object.child.count = old display_object.child.count + 1
			one_item_added_to_layout_item: not old layout_item.has (an_object.layout_item) implies layout_item.count = old layout_item.count + 1
		end
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := object.full
		end

feature {NONE} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		local
			widget: EV_CONTAINER
		do
			widget ?= vision2_object_from_type (type)
			check
				widget_not_void: widget /= Void
			end
			create display_object.make_with_name_and_child (type, widget)
			display_object.set_pebble_function (agent retrieve_pebble)
			display_object.child.set_pebble_function (agent retrieve_pebble)
			display_object.drop_actions.extend (agent add_new_object_wrapper (?))
			display_object.drop_actions.extend (agent add_new_component_wrapper (?))
			display_object.child.drop_actions.extend (agent add_new_object_wrapper (?))
			display_object.child.drop_actions.extend (agent add_new_component_wrapper (?))
			display_object.drop_actions.set_veto_pebble_function (agent can_add_child (?))
			display_object.child.drop_actions.set_veto_pebble_function (agent can_add_child (?))
		end

end -- class GB_CONTAINER_OBJECT
