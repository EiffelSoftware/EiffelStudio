indexing
	description: "Objects that represent an EiffelBuild menu bar."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_MENU_BAR_OBJECT

inherit
	GB_OBJECT
		redefine
			object, display_object, accepts_child, is_full
		end
		
	GB_PARENT_OBJECT
		
create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_MENU_BAR
		-- A representation of `Current' used
		-- in the display_window.
	
	display_object: EV_MENU_BAR
		-- A representation of `Current' used
		-- in the builder_window
		
	is_full: BOOLEAN is
			-- `Current' is never full.
			-- Always room for one more menu item.
		do
			Result := False
		end
		
		
feature {NONE} -- Implementation

	accepts_child (a_type: STRING): BOOLEAN is
			-- Does `Current' accept `an_object'. By default,
			-- widgets are accepted. Redefine in primitives
			-- that must hold items to allow insertion.
		local
			current_type: INTEGER
		do
			current_type := dynamic_type_from_string (a_type)
			if type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_string)) or
				type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_item_string)) then
				Result := True
			end
		end
		
feature {GB_OBJECT_HANDLER} -- Implementation
		
	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			menu_item: EV_MENU_ITEM
		do
			menu_item ?= an_object.object
			check
				object_is_a_menu_item: menu_item /= Void
			end
			object.go_i_th (position)
			object.put_left (menu_item)
			menu_item ?= an_object.display_object
			check
				display_object_is_a_menu_item: menu_item /= Void
			end
			display_object.go_i_th (position)
			display_object.put_left (menu_item)
			if not layout_item.has (an_object.layout_item) then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)			
			end
		end

end -- class GB_MENU_BAR_OBJECT
