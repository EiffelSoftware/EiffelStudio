indexing
	description:
		" EiffelVision Toolbar button, a specific button that goes%
		% in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON

inherit
	EV_SIMPLE_ITEM
		redefine
			implementation,
			parent
		end

creation
	make,
	make_with_text,
	make_with_pixmap,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_TOOL_BAR) is
			-- Create the widget with `par' as parent.
		do
			!EV_TOOL_BAR_BUTTON_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: EV_TOOL_BAR; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		require
			valid_text: txt /= Void
		do
			!EV_TOOL_BAR_BUTTON_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

	make_with_pixmap (par: EV_TOOL_BAR; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		require
			valid_pixmap: is_valid (pix)
		do
			!EV_TOOL_BAR_BUTTON_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.set_pixmap (pix)
			set_parent (par)
		end

	make_with_index (par: EV_TOOL_BAR; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		require
			valid_parent: is_valid (par)
			valid_index: value >= 1
		do
			!EV_TOOL_BAR_BUTTON_IMP! implementation.make --_with_index (par, value)
			implementation.set_interface (Current)
			set_parent_with_index (par, index)
		end

	make_with_all (par: EV_TOOL_BAR; txt: STRING; pix: EV_PIXMAP; 
					value: INTEGER) is
			-- Create an item with `par' as parent and `txt' as
			-- text, `pix' as pixmap and `index' as index.
			-- Any of these attibute can be Void and `index' can
			-- be 0 if it is not a pertinent.
		require
			valid_text: txt /= Void
			index_implies_parent: value >= 1 implies is_valid (par)
		do
			!EV_TOOL_BAR_BUTTON_IMP! implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			if pixmap /= Void then
				implementation.set_pixmap (pix)
			end
			if value = 0 then
				set_parent (par)
			else
				set_parent_with_index (par, value)
			end
		end

feature -- Access

	parent: EV_TOOL_BAR is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

	index: INTEGER is
			-- Index of the button in the tool-bar.
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.index
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is the current button insensitive?
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			Result := implementation.is_insensitive
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
			-- Make the current button insensitive if `flag' and
			-- enable if `not flag'
		require
			exists: not destroyed
			has_parent: parent /= Void
		do
			implementation.set_insensitive (flag)
		end

feature -- Element change

	set_parent_with_index (par: EV_TOOL_BAR; value: INTEGER) is
			-- Make `par' the new parent of the widget and set
			-- the current button at `value'.
		require
			exists: not destroyed
			valid_index: value >= 1
		do
			implementation.set_parent_with_index (par, value)
		ensure
			parent_set: parent = par
			index_set: index = value
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_select_command (cmd, arg)
		end

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.add_button_press_command (mouse_button, cmd, arg)
		end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		require
			exists: not destroyed
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.add_button_release_command (mouse_button, cmd, arg)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		require
			exists: not destroyed
		do
			implementation.remove_select_commands			
		end

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		require
			exists: not destroyed
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.remove_button_press_commands (mouse_button)
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		require
			exists: not destroyed
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		do
			implementation.remove_button_release_commands (mouse_button)
		end

feature -- Implementation

	implementation: EV_TOOL_BAR_BUTTON_I
			-- Platform dependent access.

end -- class EV_TOOL_BAR_BUTTON

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
