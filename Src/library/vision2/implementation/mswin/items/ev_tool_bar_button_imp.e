--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision Toolbar button, mswindows implementation."
	note: " Menu-items have even ids and tool-bar buttons have%
		% odd ids because both use the on_wm_command."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			parent_imp,
			interface
		end

	EV_SIMPLE_ITEM_IMP
		undefine
			parent
		redefine
			set_text,
			set_pixmap,
			parent_imp,
			interface
		end

	EV_ID_IMP

	EV_PICK_AND_DROPABLE_IMP
		redefine
			interface
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the item.
		do
			base_make (an_interface)
			make_id
		end

	initialize is
			-- Do post creation initialization.
		do
			is_initialized := True
		end

	parent_imp: EV_TOOL_BAR_IMP
		-- The parent of `Current'.

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

       set_parent (par: like parent) is
                       -- Make `par' the new parent of the widget.
                       -- `par' can be Void then the parent is the screen.
               do
				if par /= Void then
					parent_imp ?= par.implementation
	                      parent_imp.auto_size
				else
					parent_imp := Void
				end
               end

feature -- Status report

	type: INTEGER is
			-- Type of the button.
			-- Numeric value which the tool_bar_can use to
			-- Identify the button type. Avoids reverse
			-- assignment to identify actual type.
		do
			Result := 1
		end

	is_sensitive: BOOLEAN is
			-- Is the current button insensitive?
		do
			Result := parent_imp.button_enabled (id)
		end

feature -- Status setting

	enable_sensitive is
			 -- Enable button.
		do
			parent_imp.enable_button (id)
		end

	disable_sensitive is
			 -- Disable button.
		do
			parent_imp.disable_button (id)
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
				parent_imp.auto_size
			end
		end

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
			-- We need to destroy the dc that comes with it,
			-- because a bitmap can be linked to only one dc
			-- at a time.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (pix)
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				add_command (Cmd_button_one_press, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_press, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_press, cmd, arg)
			end
		end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		do
			inspect mouse_button
			when 1 then
				add_command (Cmd_button_one_release, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_release, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_release, cmd, arg)
			end
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		do
			remove_command (Cmd_item_activate)			
		end	

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_press)
			when 2 then
				remove_command (Cmd_button_two_press)
			when 3 then
				remove_command (Cmd_button_three_press)
			end
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_release)
			when 2 then
				remove_command (Cmd_button_two_release)
			when 3 then
				remove_command (Cmd_button_three_release)
			end
		end

feature {EV_INTERNAL_TOOL_BAR_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			Result := parent_imp
		end

	set_capture is
			-- Grab user input.
		do
			parent_imp.set_capture
		end

	release_capture is
			-- Release user input.
		do
			parent_imp.release_capture
		end

feature {EV_ANY_I} -- Interface

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_IMP

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
--| Revision 1.10  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.10  2000/02/05 02:10:50  brendel
--| Removed feature `destroyed'.
--|
--| Revision 1.9.6.9  2000/02/04 19:24:04  brendel
--| Removed feature `id' since it is now defined in EV_ID_IMP.
--|
--| Revision 1.9.6.8  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.7  2000/01/27 01:10:56  rogers
--| renamed is_insensitive to is_sensitive, and replaced set_insensitive with enable_sensitive and disable_sensitive.
--|
--| Revision 1.9.6.6  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.9.6.5  2000/01/20 20:33:47  rogers
--| Added a better explanation of type.
--|
--| Revision 1.9.6.4  2000/01/20 17:04:48  rogers
--| In make, base make now is passed an_interface, and initialize is implemented.
--|
--| Revision 1.9.6.3  1999/12/22 18:21:15  rogers
--| Removed undefinition of pixmap_size_ok, as it is no longer inherited at all.
--|
--| Revision 1.9.6.2  1999/12/17 17:30:28  rogers
--| Altered to fit in with the review branch. Make takes an interface. Now inherits from EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.9.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
