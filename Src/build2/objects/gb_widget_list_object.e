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
			object, display_object, add_child_object
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
			box: EV_BOX
		do
			widget ?= an_object.object
			object.go_i_th (position)
			object.put_left (widget)
			if not an_object.expanded_in_box then
					-- Update expanded state of `an_object'.
				box ?= object
				if box /= Void then
					box.disable_item_expand (widget)
				end
			end
				-- Check we need to handle if display_object is a container.
			widget ?= an_object.display_object
			display_object.child.go_i_th (position)
			display_object.child.put_left (widget)
			if not an_object.expanded_in_box then
				 -- Update expanded state of `an_object'.
				box ?= display_object.child
				if box /= Void then
					box.disable_item_expand (widget)
				end
			end
			
			layout_item.go_i_th (position)
			layout_item.put_left (an_object.layout_item)			
			add_child (an_object, position)
		end

end -- class GB_WIDGET_LIST_OBJECT
