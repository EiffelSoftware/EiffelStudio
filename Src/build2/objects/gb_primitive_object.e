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

feature -- Basic operation

	build_drop_action_for_new_object is
			-- Set up drop actions to accept `an_object'.
		do
			-- Does nothing as a primitive may not have another object added
			-- as a child.
			-- When items are supported, then the code to check for validity of
			-- item must be here.
			
			-- We must actually clear the drop actions, as the last transport may have been
			-- a shift pick, so the drop actions will not be empty.
			display_object.drop_actions.wipe_out
			layout_item.drop_actions.wipe_out
		end
		
feature {NONE} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		do
			display_object ?= vision2_object_from_type (type)
			display_object.set_pebble_function (agent retrieve_pebble)
			display_object.pick_actions.force_extend (agent object_handler.set_up_drop_actions_for_all_objects)
			display_object.pick_actions.force_extend (agent create_shift_timer)
			display_object.pick_ended_actions.force_extend (agent destroy_shift_timer)
		end

end -- class GB_CONTAINER_OBJECT
