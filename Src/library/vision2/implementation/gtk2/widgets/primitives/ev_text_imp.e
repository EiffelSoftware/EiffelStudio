indexing

	description: 
		"EiffelVision text area, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TEXT_IMP
	
inherit
	EV_TEXT_I
		redefine
			interface
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			insert_text,
			initialize,
			create_change_actions
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			visual_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk text view.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_new)
			text_buffer := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_get_buffer (c_object)
		end
		
	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Hook up the change actions for the text widget
		do
			Result := Precursor {EV_TEXT_COMPONENT_IMP}
			real_signal_connect (text_buffer, "changed", agent (App_implementation.gtk_marshal).text_component_change_intermediary (c_object), Void)
		end
		
	initialize is
			-- 
		do
			enable_word_wrapping
			set_editable (True)
			Precursor {EV_TEXT_COMPONENT_IMP}
		end
		
feature -- Access
		
	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		do
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is the text editable by the user?

	has_selection: BOOLEAN is
			-- Does `Current' have a selection?
		do
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		do
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		do
		end

feature -- Status setting
	
	set_editable (flag: BOOLEAN) is
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		do
			is_editable := flag
			--| FIXME IEK Implement rest of me.
		end

	set_caret_position (pos: INTEGER) is
			-- set current insertion position
		do
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make a minimum of `nb' of the widest character visible
			-- on one line.
		do
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		do
		end	

	deselect_all is
			-- Unselect the current selection.
		do
		end

	delete_selection is
			-- Delete the current selection.
		do
		end

	cut_selection is
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		do
		end

	copy_selection is
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		do
		end

	paste (index: INTEGER) is
			-- Insert the contents of the clipboard 
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing. 
		do
		end		

feature -- Access

	text: STRING is
		local
			a_start_iter, a_end_iter: EV_GTK_TEXT_ITER_STRUCT
			temp_text: POINTER
		do
			create a_start_iter.make
			create a_end_iter.make
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_bounds (text_buffer, a_start_iter.item, a_end_iter.item)
			temp_text := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_text (text_buffer, a_start_iter.item, a_end_iter.item, False)
			create Result.make_from_c (temp_text)
		end

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		local
		do
		end

feature -- Status report

	line_count: INTEGER is
			-- Number of lines present in widget.
		local
		do
		end

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		do
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		do
		end

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		local
		do
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		local
		do
		end
		
	has_word_wrapping: BOOLEAN
			-- Does `Current' have word wrapping enabled?

feature -- Status setting
	
	insert_text (txt: STRING) is
		local
			a_gs: GEL_STRING
		do
			create a_gs.make (text)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_set_text (text_buffer, a_gs.item, -1)
		end
	
	set_text (a_text: STRING) is
		local
			a_gs: GEL_STRING
		do
			create a_gs.make (a_text)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_set_text (text_buffer, a_gs.item, -1)
		end
	
	append_text (a_text: STRING) is
			-- Append `txt' to `text'.
		local
		do
		end
	
	prepend_text (a_text: STRING) is
			-- Prepend 'txt' to `text'.
		local
		do
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
		end

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- `thawed out' using `thaw'.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
		end

	thaw is
			-- Thaw a frozen widget.
		do
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		do
			insert_text ("%N")
		end

	scroll_to_line (i: INTEGER) is
		do
		end
		
	enable_word_wrapping is
			-- 
		do
			-- Make sure only vertical scrollbar is showing
			has_word_wrapping := True
		end
		
	disable_word_wrapping is
			--
		do
			-- Make sure both scrollbars are showing
			has_word_wrapping := False
		end

feature -- Assertions

	last_line_not_empty: BOOLEAN is
			-- Has the line at least one character?
		local
			temp_text: STRING
		do
			temp_text := text
			Result := not ((temp_text @ temp_text.count) = '%N')
		end
		
feature {NONE} -- Implementation

	on_change_actions is
			-- The text within the widget has changed.
		do
			change_actions_internal.call (App_implementation.gtk_marshal.Empty_tuple)
		end

	line_height: INTEGER is
			-- Height of the text lines in the widget.
		do
			if private_font /= Void then
				Result := private_font.ascent + private_font.descent
			else
				Result := App_implementation.Default_font_ascent + App_implementation.Default_font_descent
			end
		end

	text_buffer: POINTER
		-- Pointer to the gtk text editable.

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT

end -- class EV_TEXT_IMP

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

