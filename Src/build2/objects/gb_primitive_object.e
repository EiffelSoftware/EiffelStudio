indexing
	description: "GB_OBJECT representing an EV_PRIMITIVE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PRIMITIVE_OBJECT

inherit
	GB_OBJECT
		redefine
			object, display_object
		end

create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_PRIMITIVE
	
	display_object: EV_PICK_AND_DROPABLE
		
feature {NONE} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		do
			display_object ?= vision2_object_from_type (type)
			display_object.set_pebble_function (agent retrieve_pebble)
			display_object.drop_actions.extend (agent add_new_component_wrapper (?))
			--display_object.drop_actions.extend (agent add_new_component_in_parent_shift_wrapper (?))
			display_object.drop_actions.extend (agent add_new_object_wrapper (?))
			--display_object.drop_actions.extend (agent add_new_object_in_parent_shift_wrapper (?))
			display_object.drop_actions.set_veto_pebble_function (agent can_add_child (?))
		end

end -- class GB_CONTAINER_OBJECT
