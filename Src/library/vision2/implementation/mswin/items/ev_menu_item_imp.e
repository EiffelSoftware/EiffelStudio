--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
		redefine
			interface
		end
		
	EV_SIMPLE_ITEM_IMP
		undefine
			parent
		redefine
			set_text,
			interface
		end

	EV_ID_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget with `par' as parent.
		do
			base_make (an_interface)
			--set_text ("")
			make_id
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	menu: WEL_MENU
			-- Wel menu used when the item is a sub-menu.

feature -- Status report

	is_sensitive: BOOLEAN is
		do
			--Result := not parent_imp.internal_insensitive (Current)
		end

	is_insensitive: BOOLEAN is
			-- Is current menu_item insensitive ?
		do
		--	Result := parent_imp.internal_insensitive (Current)
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- We use it only when the grand parent is an option button.
		local
			menu_imp: EV_MENU_IMP
			option: EV_OPTION_BUTTON
			mitem: EV_MENU_ITEM
		do
			menu_imp ?= parent_imp
			if menu_imp /= Void then
				option ?= menu_imp.parent_imp
				if option /= Void then
					mitem ?= interface
					Result := mitem.is_equal (option.selected_item)
				end
			end
		end

feature -- Status setting

	enable_sensitive is
   			-- Set current item sensitive.
		do
			--parent_imp.internal_set_insensitive (Current, False)
   		end

	disable_sensitive is
   			-- Set current item insensitive.
		do
			--parent_imp.internal_set_insensitive (Current, True)
   		end

	set_selected (flag: BOOLEAN) is
   			-- Set current item as the selected one.
			-- We use it only when the grand parent is an option button.
   		do
			--parent_imp.on_selection_changed (Current)
   		end

feature -- Element change

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
				if par /= Void then
					parent_imp ?= par.implementation
				else
					parent_imp := Void
				end
               end

	set_text (txt: STRING) is
			-- Set `text' to `txt'.
		do
			text := clone (txt)
		--	{EV_SIMPLE_ITEM_IMP} Precursor (txt)
		--	if parent_imp /= Void then
		--		parent_imp.menu.modify_string (txt, id)
		--		item_handler.update_menu
		--	end
		end

	add_item (an_item: EV_MENU_ITEM_IMP) is
			-- Add `an_item' into container.
		do
			-- First, we transform the item into a menu.
		--	if menu = Void then
		--		!! menu.make
		--		if parent_imp /= Void then
		--			parent_imp.internal_delete_item (Current)
		--			parent_imp.internal_insert_menu (Current)
		--		end
		--	end

			-- Then we normaly add the item.
		--	extend (an_item.interface)
-- FIXME was like this:	{EV_MENU_ITEM_HOLDER_IMP} Precursor (an_item)
		end

	remove_separator (sep_imp: EV_MENU_SEPARATOR_IMP) is
			-- Remove `sep_imp' from the menu.
		do
			-- First, we call the precursor
		--	{EV_MENU_ITEM_HOLDER_IMP} Precursor (sep_imp)

			-- If there is no more children, it becomes a normal item.
		--	if ev_children = Void then
		--		if parent_imp /= Void then
		--			parent_imp.internal_delete_item (Current)
		--			parent_imp.internal_insert_item (Current)
		--		end
		--		menu := Void
		--	end
		end

feature {EV_MENU_ITEM_HANDLER_IMP} -- WEL Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
			--| FIXME execute_command (Cmd_item_activate, Void)
		--	parent_imp.on_selection_changed (Current)
		end

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'.
		do
		--	parent_imp.on_selection_changed (sitem)
		end

feature {NONE} -- Implementation

	parent_imp: EV_MENU_ITEM_LIST_IMP

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_ITEM

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.8  2000/02/05 02:08:06  brendel
--| Cleanup.
--| Events need to be implemented!
--|
--| Revision 1.24.6.7  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.24.6.6  2000/02/03 17:19:05  brendel
--| Implemented *sensitive features.
--|
--| Revision 1.24.6.5  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.4  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.24.6.3  1999/12/22 19:29:51  rogers
--| pixmap_size_ok is no longer undefined, as this feature no longer exists.
--|
--| Revision 1.24.6.2  1999/12/17 17:34:39  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
