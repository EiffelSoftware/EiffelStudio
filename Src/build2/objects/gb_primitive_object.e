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
		-- The vision2 object that `Current' represents.
	
	display_object: EV_PICK_AND_DROPABLE
		-- The representation of `object' used in `build_window'.
		
feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			list: EV_ITEM_LIST [EV_ITEM]
			item: EV_ITEM
		do
			list ?= object
			item ?= an_object.object
			list.go_i_th (position)
			list.put_left (item)
				-- Check we need to handle if display_object is a container.
			list ?= display_object
			item ?= an_object.display_object
			list.go_i_th (position)
			list.put_left (item)
			if not layout_item.has (an_object.layout_item) then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)			
			end
			add_child (an_object, position)
		end

end -- class GB_CONTAINER_OBJECT
