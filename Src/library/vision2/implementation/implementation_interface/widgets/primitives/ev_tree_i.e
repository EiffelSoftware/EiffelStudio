indexing
	description:
		"EiffelVision Tree. Implemenation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_I

inherit
	EV_PRIMITIVE_I
	
	EV_TREE_ITEM_HOLDER_I

feature -- Access

	selected_item: EV_TREE_ITEM is
			-- Item which is currently selected.
		require
			exists: not destroyed
		deferred
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
			exists: not destroyed
		deferred
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item is selected.
		require
			exists: not destroyed
		deferred
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
		deferred
		end

end -- class EV_TREE_I

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
