indexing

	description: 
		"EiffelVision menu item. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_MENU_ITEM_IMP
	
inherit

	EV_MENU_ITEM_I

	EV_ITEM_IMP
		export {EV_MENU_ITEM_CONTAINER_IMP}
			id,
			set_id
		end

creation

	make, make_with_text

feature {NONE} -- Initialization

	make (par: EV_MENU_ITEM_CONTAINER) is
			-- Create and add a menu_item with an empty label.
		do
			menu ?= par.implementation
			check
				parent_not_void: menu /= Void
			end
			menu.set_name ("")
		end

	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create and add a menu_item with `txt' as label.
		do
			menu ?= par.implementation
			check
				parent_not_void: menu /= Void
			end
			menu.set_name (txt)
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Access
	
	menu: EV_MENU_ITEM_CONTAINER_IMP
		-- Container that contains the current item

feature -- Status report

	text: STRING is
			-- Current label of the menu item
		do
			Result := menu.id_string (id)
		end

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the menu.
		do
			Result := not menu.item_exists (id)
		end

	insensitive: BOOLEAN is
			-- Is current menu_item insensitive ?
		do
			Result := not menu.item_enabled (id)
		end

feature -- Status setting

	destroy is
			-- Destroy the current item.
		do
			menu.remove_item (id)
		end

	set_menu (new_menu: EV_MENU_ITEM_CONTAINER_IMP) is
			-- Set `menu' to `new_menu'
		do
			menu := new_menu
		end

	set_insensitive (flag: BOOLEAN) is
   			-- Set current item in insensitive mode if
   			-- `flag'.
		do
			if flag then
				menu.disable_item (id)
			else
				menu.enable_item (id)
			end
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Element change

	set_text (str: STRING) is
			-- Set `text' to `str'
		do
			menu.modify_string (str, id)
		end

end -- class EV_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
