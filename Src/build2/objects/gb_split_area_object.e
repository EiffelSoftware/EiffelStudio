indexing
	description: "A GB_OBJECT representing an EV_SPLIT_AREA"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SPLIT_AREA_OBJECT

inherit
	GB_CONTAINER_OBJECT
		redefine
			object,
			add_child_object,
			build_drop_action_for_new_object,
			display_object
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_SPLIT_AREA
		-- The vision2 object that `Current' represents.
		-- This is used in the display window.
	
	display_object: GB_SPLIT_AREA_DISPLAY_OBJECT
		-- The representation of `object' used in `build_window'.
		-- This is used in the builder window.

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			widget: EV_WIDGET
			widget2: EV_WIDGET
		do
			widget ?= an_object.object
			check
				object_not_void: widget /= Void
			end
			widget2 ?= an_object.display_object
			check
				display_object_not_void: widget2 /= Void
			end
			
				-- We need to put in the first position if
				-- there is currently a second position.
			if position = 1 or (position = 2 and object.second /=  Void) then
				object.set_first (widget)
				display_object.child.set_first (widget2)
				if not layout_item.has (an_object.layout_item) then
					layout_item.go_i_th (1)
					layout_item.put_left (an_object.layout_item)
				end
			else
				object.set_second (widget)
				display_object.child.set_second (widget2)
				if not layout_item.has (an_object.layout_item) then
					layout_item.go_i_th (2)
					layout_item.put_left (an_object.layout_item)
				end
			end	
		end
		
feature {NONE} -- Implementation

	build_drop_action_for_new_object is
			-- Set up drop actions to accept `an_object' if permissible.
		do
			display_object.drop_actions.wipe_out
			layout_item.drop_actions.wipe_out
			if object.count < 2 then
				display_object.drop_actions.extend (agent add_new_object (?))
				display_object.drop_actions.extend (agent add_new_component (?))
				layout_item.drop_actions.extend (agent add_new_object (?))
				layout_item.drop_actions.extend (agent add_new_component (?))
					-- We must add a veto pebble function which stops us dropping
					-- an object on one of its children.
				display_object.drop_actions.set_veto_pebble_function (agent override_drop_on_child (?))
				layout_item.drop_actions.set_veto_pebble_function (agent override_drop_on_child (?))
			end
		end

end -- class GB_SPLIT_AREA_OBJECT