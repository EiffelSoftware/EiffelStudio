indexing
	description:
		" EiffelVision Toolbar button, a specific button that goes%
		% in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I

	EV_SIMPLE_ITEM_IMP
		redefine
			pixmap_size_ok
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
		end

	make_with_text (par: EV_TOOL_BAR; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
		end

	make_with_pixmap (par: EV_TOOL_BAR; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
		end

	make_with_index (par: EV_TOOL_BAR; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		do
		end

	make_with_all (par: EV_TOOL_BAR; txt: STRING; pix: EV_PIXMAP; 
					value: INTEGER) is
			-- Create an item with `par' as parent and `txt' as
			-- text, `pix' as pixmap and `index' as index.
			-- Any of these attibute can be Void and `index' can
			-- be 0 if it is not a pertinent.
		do
		end

feature -- Access

	parent: EV_TOOL_BAR is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

	index: INTEGER is
			-- Index of the button in the tool-bar.
		do
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is the current button insensitive?
		do
		end

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
			-- Make the current button insensitive if `flag' and
			-- enable if `not flag'
		do
		end

feature -- Element change

	set_parent_with_index (par: EV_TOOL_BAR; value: INTEGER) is
			-- Make `par' the new parent of the widget and set
			-- the current button at `value'.
		do
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		do
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		do
		end


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
