indexing
	description: "EiffelVision2 Toolbar button, a specific button that goes in a tool-bar."
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
			set_insensitive,
			set_text,
			parent,
			make_with_text
		redefine
			initialize
		end

	EV_BUTTON_IMP
		rename
			parent_set as widget_parent_set,
			parent_imp as widget_parent_imp,
			set_parent as widget_set_parent
		undefine
			initialize,
			has_parent,
			pixmap_size_ok
		redefine
			set_text,
			create_pixmap_place
		select
			remove_double_click_commands,
			add_double_click_command	
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	initialize is
			-- Creation of vbox for pixmap and caption.
		do
			box := gtk_vbox_new (False, 5)
			gtk_widget_show (box)
			gtk_container_add (GTK_CONTAINER (widget), box)
		end

	set_text (txt: STRING) is
			-- Set the caption of the tool bar button to txt.
			-- Aligns pixmap to the middle of the button.
		do
			{EV_BUTTON_IMP} Precursor (txt)
			if pixmap_widget /= default_pointer then
				gtk_misc_set_alignment (gtk_misc (pixmap_widget), 0.5, 0.5)
				gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 1.0)
			end
		end

	create_pixmap_place (pix_imp: EV_PIXMAP_IMP) is
		do
			-- Redfinition needed to align pixmap in centre of button.
			{EV_BUTTON_IMP} Precursor (pix_imp)
			if pixmap_widget /= default_pointer then
				gtk_misc_set_alignment (gtk_misc (pixmap_widget), 0.5, 0.5)
			end
			if label_widget /= default_pointer then
				gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 1.0)
			end
		end

feature -- Access

	index: INTEGER is
			-- Index of the button in the tool-bar.
		do
			Result := parent_imp.ev_children.index_of (Current, 1)
		end

feature -- Element Change

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
			-- Before to remove the widget from the
			-- container, we increment the number of
			-- reference on the object otherwise gtk
			-- destroyed the object. And after having
			-- added the object to another container,
			-- we remove this supplementary reference.
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
			parent_imp.insert_item (Current, pos)
		end

feature -- Status report

	is_insensitive: BOOLEAN is
			-- Is the current button insensitive?
		do
			Result := insensitive
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		do
			add_command (widget, "clicked", cmd, arg, default_pointer)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		do
			remove_commands (widget, clicked_id)
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
--!---------------------------------------------------------------
