indexing
	description: "EiffelVision2 Toolbar button, a specific button that goes in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			parent_imp
		end

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
			initialize,
			parent_imp
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
			make,
			create_pixmap_place
		select
			remove_double_click_commands,
			add_double_click_command	
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- create the tool bar button.
			-- Redefined because the interface does not
			-- call `widget_make' where we connect `destroy_signal_callback'
			-- to `destroy' event.
		do
			{EV_BUTTON_IMP} Precursor
			initialize_object_handling
			gtk_button_set_relief (widget, GTK_RELIEF_NONE)
		end

	initialize is
			-- Creation of vbox for pixmap and caption.
		do
			box := gtk_vbox_new (False, 5)
			gtk_widget_show (box)
			gtk_container_add (GTK_CONTAINER (widget), box)
		end

feature -- Access

	index: INTEGER is
			-- Index of the button in the tool-bar.
		do
			Result := parent_imp.ev_children.index_of (Current, 1)
		end

	parent_imp: EV_TOOL_BAR_IMP

feature -- Element Change

	set_index (pos: INTEGER) is
			-- Make `pos' the new index of the item in the
			-- list.
		do
			parent_imp.insert_item (Current, pos)
		end

	set_text (txt: STRING) is
			-- Set the caption of the tool bar button to txt.
			-- Aligns pixmap to the middle of the button.
		do
			{EV_BUTTON_IMP} Precursor (txt)
			if pixmap_widget /= default_pointer then
				gtk_misc_set_alignment (gtk_misc (pixmap_widget), 0.5, 0)
				gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 0.45)
			end
		end

	create_pixmap_place (pix_imp: EV_PIXMAP_IMP) is
		do
			-- Redefinition needed to align pixmap in centre of button.
			{EV_BUTTON_IMP} Precursor (pix_imp)
			if pixmap_widget /= default_pointer then
				gtk_misc_set_alignment (gtk_misc (pixmap_widget), 0.5, 0)
			end
			if label_widget /= default_pointer then
				gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 0.45)
			end
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

feature -- External

	gtk_button_set_relief (but: POINTER; style: INTEGER) is
		external
			"C (GtkButton *, gint) | <gtk/gtk.h>"
		end

	GTK_RELIEF_NONE: INTEGER is 2
		-- Style used for no edges around buttons.

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
