indexing

	description: 
		"EiffelVision menu_item, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_I
	
inherit
	EV_SIMPLE_ITEM_I
		redefine
			parent,
			pixmap_size_ok
		end

	EV_MENU_ITEM_HOLDER_I

feature -- Access

	parent: EV_MENU_ITEM_HOLDER is
			-- The parent of the Current widget
			-- Can be void.
		do
			Result ?= {EV_SIMPLE_ITEM_I} Precursor
		end

	top_parent_imp: EV_MENU_ITEM_HOLDER_IMP is
			-- Top item holder containing the current item.
		local
			itm: EV_MENU_ITEM_IMP
		do
			itm ?= parent_imp
			if itm = Void then
				Result ?= parent_imp
			else
				Result := itm.top_parent_imp
			end
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is current widget insensitive?
		require
			exists: not destroyed
   		deferred
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- We use it only when the grand parent is an option button.
		require
			exists: not destroyed
   		deferred
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
   			-- Set current item in insensitive mode if
   			-- `flag'. 
		require
			exists: not destroyed
   		deferred
   		ensure
   			state_set: is_insensitive = flag
 		end

	set_selected (flag: BOOLEAN) is
   			-- Set current item as the selected one.
			-- We use it only when the grand parent is an option button.
		require
			exists: not destroyed
			valid_grand_parent: grand_parent_is_option_button
 		deferred
 		ensure
   			state_set: is_selected = flag
   		end

feature -- Assertion

	grand_parent_is_option_button: BOOLEAN is
			-- Is true if the grand parent is an option button.
			-- False otherwise.
		deferred
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		require
			exists: not destroyed
		deferred			
		end	

feature {NONE} -- Implementation

	pixmap_size_ok (pix: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := (pix.width <= 16) and (pix.height <= 16)
		end

end -- class EV_MENU_ITEM_I

--!----------------------------------------------------------------
--! EiffelVision library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
