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

-- Apparently not necessary because there is no wel_window
-- All the features of EV_TEXT_CONTAINER_I then need to be
-- implemented
--	EV_TEXT_CONTAINER_IMP
--		redefine
--			text,
--			set_text
--		end

creation

	make, make_with_text

feature {NONE} -- Initialization

	make (par: EV_MENU_ITEM_CONTAINER) is
		do
			menu ?= par.implementation
			check
				parent_not_void: menu /= Void
			end
		end

	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
		do
			menu ?= par.implementation
			check
				parent_not_void: menu /= Void
			end
			menu.set_name (txt)
		end

feature -- Event - command association
	
	add_activate_command (a_command: EV_COMMAND; 
			       the_arguments: EV_ARGUMENTS) is	
		do
			command := a_command
			arguments := the_arguments
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Access
	
	id: INTEGER
		-- Id of the item in the menu_item_container

	menu: EV_MENU_ITEM_CONTAINER_IMP
		-- Container that contains the current item
	
	command: EV_COMMAND
		-- Command that must be called when the menu is selected
		-- by the user.

	arguments: EV_ARGUMENTS
		-- Argument that goes with the command

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

	set_id (new_id: INTEGER) is
			-- Set `id' to `new_id'
		do
			id := new_id
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

	set_center_alignment is
			-- Set text alignment of current label to center.
		do
			check
                               not_yet_implemented: False
            end
		end

	set_right_alignment is
			-- Set text alignment of current label to right.
		do
			check
                                not_yet_implemented: False
                        end
		end

	set_left_alignment is
			-- Set text alignment of current label to left.
		do
			check
                                not_yet_implemented: False
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
