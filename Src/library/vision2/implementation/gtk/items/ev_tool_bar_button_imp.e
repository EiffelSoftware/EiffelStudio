indexing
	description:
		" EiffelVision2 Toolbar button, a specific button that goes%
		% in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I

	EV_SIMPLE_ITEM_IMP
		undefine
			pixmap_size_ok,
			set_foreground_color,
			set_background_color,
			create_pixmap_place,
			set_insensitive
		redefine
			make_with_text
		end

	EV_BUTTON_IMP
		rename
			parent_set as widget_parent_set,
			parent_imp as widget_parent_imp,
			set_parent as widget_set_parent
		undefine
			has_parent,
			pixmap_size_ok
		select
			remove_double_click_commands,
			add_double_click_command	
		end

creation
	make,
	make_with_text,
	make_with_pixmap,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make_with_pixmap (pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			make
			set_pixmap (pix)
		end

	make_with_index (value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		do
		end

	make_with_all (txt: STRING; pix: EV_PIXMAP; value: INTEGER) is
			-- Create an item with `par' as parent and `txt' as
			-- text, `pix' as pixmap and `index' as index.
			-- Any of these attibute can be Void and `index' can
			-- be 0 if it is not a pertinent.
		do
		end


feature -- Access

	
	index: INTEGER is
			-- Index of the button in the tool-bar.
		do
		end

feature -- Element change

	set_parent (par: EV_TOOL_BAR) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				check
					parent_not_void: parent_imp /= Void
				end
				parent_imp.add_item (Current)
				show
				gtk_object_unref (widget)
			end
		end

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item in the
			-- list.
		do
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is the current button insensitive?
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

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
