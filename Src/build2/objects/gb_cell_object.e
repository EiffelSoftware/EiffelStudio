indexing
	description: "A GB_OBJECT representing an EV_CELL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CELL_OBJECT
	
inherit
	GB_OBJECT
		redefine
			object, display_object, is_full
		end

	GB_ACCESSIBLE
	
create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_CELL
		-- The vision2 object that `Current' represents.
		-- This is used in the display window.
	
	display_object: GB_CELL_DISPLAY_OBJECT
		-- The representation of `object' used in `build_window'.
		-- This is used in the builder window.
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := object.full
		end

feature -- Basic operations
		
	add_child_object (an_object: GB_OBJECT) is
			-- Add `an_object' to `Current'.
		require
			object_empty: object.is_empty
			correct_type: type_conforms_to (dynamic_type (an_object), dynamic_type_from_string ("GB_PRIMITIVE_OBJECT")) or
				type_conforms_to (dynamic_type (an_object), dynamic_type_from_string ("GB_CELL_OBJECT")) or
				type_conforms_to (dynamic_type (an_object), dynamic_type_from_string ("GB_CONTAINER_OBJECT"))
		local
			widget: EV_WIDGET
		do
			widget ?= an_object.object
			check
				object_is_a_widget: widget /= Void
			end
			object.extend (widget)
			widget ?= an_object.display_object
			check
				display_object_is_a_widget: widget /= Void
			end
			display_object.child.extend (widget)
			if not layout_item.has (an_object.layout_item) then
				layout_item.extend (an_object.layout_item)
			end
		ensure
			object_not_empty: not object.is_empty
		end
		
		
feature {NONE} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		local
			container: EV_CONTAINER
		do
			--|FIXME for now, actually use a cell
			if type.is_equal (Ev_titled_window_string) then
				create display_object.make_as_root_window (builder_window)
			else
				container ?= vision2_object_from_type (type)
				check
					container_not_void: container /= Void
				end
				create display_object.make_with_name_and_child (type, container)
				display_object.set_pebble_function (agent retrieve_pebble)
				display_object.child.set_pebble_function (agent retrieve_pebble)
				display_object.drop_actions.extend (agent add_new_object_shift_wrapper (?))
				display_object.drop_actions.extend (agent add_new_component_shift_wrapper (?))
				display_object.drop_actions.extend (agent add_new_component_in_parent_shift_wrapper (?))
				display_object.drop_actions.extend (agent add_new_object_in_parent_shift_wrapper (?))
				display_object.drop_actions.set_veto_pebble_function (agent can_add_child (?))
				display_object.child.drop_actions.set_veto_pebble_function (agent can_add_child (?))
			end
		end

end -- class GB_CELL_OBJECT
