indexing
	description:
		" EiffelVision Toolbar button, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_BUTTON_I

inherit
	EV_SIMPLE_ITEM_I
		redefine
			top_parent_imp,
			pixmap_size_ok
		end

	EV_PND_SOURCE_I

	EV_PND_TARGET_I

feature -- Access

	parent_imp: EV_TOOL_BAR_IMP is
			-- Parent implementation
		deferred
		end

	top_parent_imp: EV_TOOL_BAR_IMP is
			-- Top item holder containing the current item.
		do
			Result ?= {EV_SIMPLE_ITEM_I} Precursor
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is the current button insensitive?
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
			-- Make the current button insensitive if `flag' and
			-- enable if `not flag'
		require
			exists: not destroyed
			has_parent: parent_imp /= Void
		deferred
		ensure
			state_set: is_insensitive = flag
		end

feature -- Assertions

	pixmap_size_ok (pix: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container. No limits
		do
			Result := True
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

end -- class EV_TOOL_BAR_BUTTON_I

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
