indexing
	description: "Objects that represent a Vision2 container inheriting EV_WIDGET_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_LIST_OBJECT

inherit
	GB_CONTAINER_OBJECT
		redefine
			object,display_object, add_child_object
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_WIDGET_LIST
		-- Vision2 object referenced by `Current'.
		-- This is used in the display window.
	
	display_object: GB_WIDGET_LIST_DISPLAY_OBJECT
		-- The display object used to represent `object'.
		-- This is used in the builder window.

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			widget: EV_WIDGET
		do
			widget ?= an_object.object
			check
				object_is_a_widget: widget /= Void
			end
			object.go_i_th (position)
			object.put_left (widget)
				-- Check we need to handle if display_object is a container.
			widget ?= an_object.display_object
			check
				display_object_is_a_widget: widget /= Void
			end
			display_object.child.go_i_th (position)
			display_object.child.put_left (widget)
			if not layout_item.has (an_object.layout_item) then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)			
			end
		end

end -- class GB_WIDGET_LIST_OBJECT
