indexing
	description: 
		"EiffelVision menu box. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_IMP
	
inherit
	EV_MENU_I

	EV_MENU_ITEM_HOLDER_IMP

	WEL_MENU

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make_with_text (label: STRING) is
			-- Create an empty menu with `label' as label. 
		do
			make
			set_text (label)
		end	

feature -- Access

	text: STRING
			-- Label of the current menu

	parent_imp: EV_MENU_HOLDER_IMP
			-- EV parent of the current menu

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	menu: WEL_MENU is
			-- Wel menu used when the item is a sub-menu.
		do
			Result := Current
		end

	item_handler: EV_MENU_ITEM_HANDLER_IMP is
			-- The handler of the item.
		do
			if parent_imp /= Void then
				Result := parent_imp.item_handler
			else
				Result := Void
			end
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := not exists
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			if parent_imp /= Void then
				parent_imp.remove_menu (Current)
				parent_imp := Void
			end
			interface.remove_implementation
			interface := Void
			remove_children
			text := Void
			-- After, it will be collected
		end

feature -- Element change

	set_text (str:STRING) is
			-- Set `text' to `str'
		do
			text := str
			if item_handler /= Void then
				item_handler.update_menu
			end
		end

	set_parent (par: EV_MENU_HOLDER) is
			-- Make `par' the new parent of the item.
		do
			if parent_imp /= Void then
				parent_imp.remove_menu (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_menu (Current)
			end
		end

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
			-- Called only when it has a parent.
		do
			parent_imp.on_selection_changed (sitem)
		end

end -- class EV_MENU_IMP

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
