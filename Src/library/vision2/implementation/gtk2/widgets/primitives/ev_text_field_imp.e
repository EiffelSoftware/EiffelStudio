indexing
	description: "EiffelVision text field. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_FIELD_IMP
	
inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end
	
	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			visual_widget,
			create_change_actions
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			visual_widget
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES}
				return_actions_internal
		redefine
			create_return_actions
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk entry.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0))
			entry_widget := feature {EV_GTK_EXTERNALS}.gtk_entry_new
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (entry_widget)
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_usize (entry_widget, 40, -1)
			--| Minimum sizes need to be similar on both platforms
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (c_object, entry_widget, False, False, 0)
			set_text ("")
		end

feature -- Access

	text: STRING is
			-- Text displayed in field.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make_from_pointer (feature {EV_GTK_EXTERNALS}.gtk_entry_get_text (entry_widget))
			Result := a_cs.string
		end

feature -- Status setting
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (a_text)
			feature {EV_GTK_EXTERNALS}.gtk_entry_set_text (entry_widget, a_cs.item)
		end

	append_text (txt: STRING) is
			-- Append `txt' to the end of the text.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (txt)
			feature {EV_GTK_EXTERNALS}.gtk_entry_append_text (entry_widget, a_cs.item)
		end
	
	prepend_text (txt: STRING) is
			-- Prepend `txt' to the end of the text.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (txt)
			feature {EV_GTK_EXTERNALS}.gtk_entry_prepend_text (entry_widget, a_cs.item)
		end
		
	set_capacity (len: INTEGER) is
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end
	
	capacity: INTEGER is
			-- Return the maximum number of characters that the
			-- user may enter.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_entry_struct_text_max_length (entry_widget)
		end

feature -- Status Report

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 1	
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_signal_connect (entry_widget, "activate", agent (App_implementation.gtk_marshal).text_field_return_intermediary (c_object), Void)
		end
		
feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable.
		do
			--| FIXME This should be removed when gtk1 imp is made obsolete
			Result := (create {EV_GTK_DEPENDENT_EXTERNALS}).gtk_editable_get_editable (entry_widget)
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		local
			a_start, a_end: INTEGER
		do
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		local
			a_start, a_end: INTEGER
			has_sel: BOOLEAN
		do
			has_sel := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
			Result := a_start
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		local
			a_start, a_end: INTEGER
			has_sel: BOOLEAN
		do
			has_sel := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_editable_get_selection_bounds (entry_widget, $a_start, $a_end)
			Result := a_end
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		do
			Result := App_implementation.clipboard.text
		end

feature -- status settings

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_set_editable (entry_widget, flag)
		end

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			internal_set_caret_position (pos)
		end

feature -- Basic operation

	insert_text (txt: STRING) is
			-- Insert `txt' at the current position.
		do
			insert_text_at_position (txt, caret_position)
		end

	insert_text_at_position (txt: STRING; a_pos: INTEGER) is
			-- Insert `txt' at the current position at position `a_pos'
		local
			a_cs: EV_GTK_C_STRING
			pos: INTEGER
		do
			pos := a_pos - 1
			create a_cs.make (txt)
			feature {EV_GTK_EXTERNALS}.gtk_editable_insert_text (
				entry_widget,
				a_cs.item,
				txt.count,
				$pos
			)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (highlight) the text between 
			-- 'start_pos' and 'end_pos'.
		do
			internal_set_caret_position (end_pos.max (start_pos) + 1)
			select_region_internal (start_pos, end_pos)
		end	

	select_region_internal (start_pos, end_pos: INTEGER) is
			-- Select region
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, start_pos.min (end_pos) - 1, end_pos.max (start_pos))
		end

	deselect_all is
			-- Unselect the current selection.
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_delete_selection (entry_widget)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_cut_clipboard (entry_widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_copy_clipboard (entry_widget)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			insert_text_at_position (clipboard_content, index)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	internal_set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			feature {EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_signal_connect (entry_widget, "changed", agent  (App_implementation.gtk_marshal).text_component_change_intermediary (c_object), Void)
		end

	stored_text: STRING
			-- Value of 'text' prior to a change action, used to compare
			-- between old and new text.

	on_change_actions is
			-- A change action has occurred.
		do
			if stored_text /= Void then
				if not text.is_equal (stored_text) then
						-- The text has actually changed
					stored_text := text
					change_actions_internal.call (Void)
				end
			else
				stored_text := text
				change_actions_internal.call (Void)
			end
		end
		
feature {NONE} -- Implementation

	entry_widget: POINTER
		-- A pointer on the text field
		
	visual_widget: POINTER is
			-- Pointer to the widget shown on screen.
		do
			Result := entry_widget
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD
			--Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	entry_widget_set: entry_widget /= NULL
	
end -- class EV_TEXT_FIELD_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

