indexing
	description: "GB_OBJECT representing an EV_TREE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TREE_OBJECT

inherit
	GB_PRIMITIVE_OBJECT
		redefine
			object, display_object, accepts_child, is_full
		end
		
	GB_PARENT_OBJECT

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_TREE
		-- The vision2 object that `Current' represents.
	
	display_object: EV_TREE
		-- The representation of `object' used in `build_window'.
	
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := False
		end
	
feature {GB_TYPE_SELECTOR_ITEM} -- Implementation

	accepts_child (a_type: STRING): BOOLEAN is
			-- Does current accept new objects of
			-- type `a_type'?
		local
			current_type: INTEGER
		do
			current_type := dynamic_type_from_string (a_type)
			if type_conforms_to (current_type, dynamic_type_from_string ("EV_TREE_ITEM")) then
				Result := True
			end
		end
		
feature {GB_OBJECT_HANDLER} -- Implementation
		
	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			tree_item: EV_TREE_ITEM
		do
			tree_item ?= an_object.object
			check
				object_is_a_tree_item: tree_item /= Void
			end
			object.go_i_th (position)
			object.put_left (tree_item)
			tree_item ?= an_object.display_object
			check
				display_object_is_a_tree_item: tree_item /= Void
			end
			display_object.go_i_th (position)
			display_object.put_left (tree_item)
			if not layout_item.has (an_object.layout_item) then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)			
			end
		end

end -- class GB_TREE_OBJECT