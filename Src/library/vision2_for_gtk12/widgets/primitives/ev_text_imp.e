indexing

	description: 
		"EiffelVision text area, gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			visual_widget,
			set_background_color,
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
			-- Create a gtk label.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL))
			entry_widget := gtk_text_new (NULL, NULL)
			{EV_GTK_EXTERNALS}.gtk_widget_show (entry_widget)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, entry_widget)
			gtk_text_set_editable (entry_widget, True)
			enable_word_wrapping
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := {EV_GTK_EXTERNALS}.gtk_editable_get_chars (entry_widget, 0, -1)
			create Result.make_from_c (p)
			{EV_GTK_EXTERNALS}.g_free (p)
		end

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		local
			line_begin_pos, line_end_pos: INTEGER
			counter : INTEGER
			p: POINTER
		do
			from
				counter := 1
				line_begin_pos := 1
				line_end_pos := 1
			until
				counter = i
			loop
				line_begin_pos := text.index_of ('%N', line_begin_pos)
				counter := counter + 1
				line_begin_pos := line_begin_pos + 1
			end

			-- We do not substract 1 to `line_end_pos' because of 
			-- GTK function `gtk_editable_get_chars'.
			line_end_pos := text.index_of ('%N', line_begin_pos)

			if (line_end_pos = 0) and then (counter = line_count) then
				-- the required line is the last line and there
				-- is no return at the end of it.
				line_end_pos := text.count + 1
				-- The `+ 1' is due to GTK function `gtk_editable_get_chars'. 
			end

			p := {EV_GTK_EXTERNALS}.gtk_editable_get_chars (entry_widget, line_begin_pos - 1, line_end_pos - 1)
			create Result.make_from_c (p)
			{EV_GTK_EXTERNALS}.g_free (p)
		end

	line_number_from_position (i: INTEGER): INTEGER is
			-- Line containing caret position `i'.
		do
			--| Added for gtk2 implementation
		end

feature -- Status report

	line_count: INTEGER is
			-- Number of lines present in widget.
		local
			temp_text: STRING
		do
			Result := {EV_GTK_EXTERNALS}.gtk_adjustment_struct_upper (vertical_adjustment_struct).rounded // line_height
			temp_text := text
			if temp_text /= Void then
				Result := Result.max (temp_text.occurrences ('%N') + 1)
				-- This is in case scroll bar has not been set
			end
		end

	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		local
			p: POINTER
			temp_string: STRING
		do
			if is_displayed then
				Result := (gtk_text_struct_cursor_pos_y (entry_widget) + gtk_text_struct_first_onscreen_ver_pixel (entry_widget)) // line_height
			else
				p := {EV_GTK_EXTERNALS}.gtk_editable_get_chars (entry_widget, 0, gtk_text_get_point (entry_widget))
				create temp_string.make_from_c (p)
				{EV_GTK_EXTERNALS}.g_free (p)
				Result := temp_string.occurrences ('%N') + 1
			end
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		do
			Result := gtk_text_get_point (entry_widget) + 1
		end

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		local
			pos : INTEGER
			count: INTEGER
			start: INTEGER
		do
			if (i = 1) then
				Result := 1
			else
				from
					count := 1
					pos := 1
					start := 1
				until
					count = i
				loop
					-- Look for the ith 'Return' in the string.
					-- Return is symbolized by '%N'
					pos := text.index_of ('%N', start)
					count := count + 1
					start := pos + 1
				end
				Result := pos + 1
			end
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		do
			if valid_line_index (i + 1) then
				Result := first_position_from_line_number (i + 1) - 1
			else
				Result := text.count
			end
		end

feature -- Status setting
		
	set_background_color (a_color: EV_COLOR) is
			-- Set background color of present
		do
			Precursor {EV_TEXT_COMPONENT_IMP} (a_color)
			-- We need to set the font again due to bug in GtkText widget.
			set_font (font)
		end

	internal_set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			gtk_text_set_point (entry_widget, pos - 1)
			{EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end
		
	insert_text_at_position (txt: STRING; a_position: INTEGER) is
		local
			a_cs: EV_GTK_C_STRING
			temp_caret_pos: INTEGER
		do
			temp_caret_pos := caret_position
			gtk_text_set_point (entry_widget, a_position - 1)
			a_cs := txt
			gtk_text_insert (entry_widget, NULL, NULL, NULL, a_cs.item, -1)
			internal_set_caret_position (temp_caret_pos)
		end
	
	insert_text (txt: STRING) is
		do
			insert_text_at_position (txt, caret_position)
		end
	
	set_text (txt: STRING) is
		do
			{EV_GTK_EXTERNALS}.gtk_editable_delete_text (entry_widget, 0, -1)
			insert_text (txt)
		end
	
	append_text (txt: STRING) is
			-- Append `txt' to `text'.
		do
			insert_text_at_position (txt, text_length + 1)
		end
	
	prepend_text (txt: STRING) is
			-- Prepend 'txt' to `text'.
		do
			insert_text_at_position (txt, 1)
		end
	
	delete_text (start, finish: INTEGER) is
			-- Delete the text between `start' and `finish' index
			-- both sides include.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_delete_text (entry_widget, start + 1, finish + 1)
		end

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- `thawed out' using `thaw'.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		do
			gtk_text_freeze (entry_widget)
		end

	thaw is
			-- Thaw a frozen widget.
		do
			gtk_text_thaw (entry_widget)
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		do
			insert_text ("%N")
		end

	scroll_to_line (i: INTEGER) is
		do
			freeze
			{EV_GTK_EXTERNALS}.gtk_adjustment_set_value (vertical_adjustment_struct, (i - 1) * line_height)
			thaw
		end

	enable_word_wrapping is
			-- Set 'has_word_wrapping' to True.
		do
			has_word_wrapping := True
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (c_object,
				{EV_GTK_EXTERNALS}.GTK_POLICY_NEVER_ENUM,
				{EV_GTK_EXTERNALS}.GTK_POLICY_ALWAYS_ENUM)
			gtk_text_set_line_wrap (entry_widget, 1)
			gtk_text_set_word_wrap (entry_widget, 1)
		end

	disable_word_wrapping is
			-- Set 'has_word_wrapping' to False.
		do
			has_word_wrapping := False
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (c_object,
				{EV_GTK_EXTERNALS}.GTK_POLICY_ALWAYS_ENUM,
				{EV_GTK_EXTERNALS}.GTK_POLICY_ALWAYS_ENUM)
			gtk_text_set_line_wrap (entry_widget, 0)
		end
		
	has_word_wrapping: BOOLEAN
			-- Does 'Current' have word wrapping enabled?

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

	vertical_adjustment_struct: POINTER is
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_range_struct_adjustment ({EV_GTK_EXTERNALS}.gtk_scrolled_window_struct_vscrollbar (c_object))
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

	entry_widget: POINTER
		-- Pointer to the gtk text editable.
		
	visual_widget: POINTER is
			-- Pointer to widget shown on screen.
		do
			Result := entry_widget
		end
		
feature {NONE} -- Externals

	gtk_text_new (a_hadj: POINTER; a_vadj: POINTER): POINTER is
			-- GtkWidget* gtk_text_new             (GtkAdjustment *hadj,
			--                                   GtkAdjustment *vadj);
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <gtk/gtk.h>"
		end

	gtk_text_set_editable (a_text: POINTER; a_editable: BOOLEAN) is
			-- void       gtk_text_set_editable    (GtkText       *text,
			-- 				     gboolean       editable);
		external
			"C (GtkText*, gboolean) | <gtk/gtk.h>"
		end
		
	gtk_text_struct_cursor_pos_y (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkText): EIF_INTEGER"
		alias
			"cursor_pos_y"
		end
		
	gtk_text_struct_first_onscreen_ver_pixel (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkText): EIF_INTEGER"
		alias
			"first_onscreen_ver_pixel"
		end
		
	gtk_text_get_point (a_text: POINTER): INTEGER is
			-- guint      gtk_text_get_point       (GtkText       *text);
		external
			"C (GtkText*): guint | <gtk/gtk.h>"
		end
		
	gtk_text_insert (a_text: POINTER; a_font: POINTER; a_fore: POINTER; a_back: POINTER; a_chars: POINTER; a_length: INTEGER) is
			-- void       gtk_text_insert          (GtkText       *text,
			-- 				     GdkFont       *font,
			-- 				     GdkColor      *fore,
			-- 				     GdkColor      *back,
			-- 				     const char    *chars,
			-- 				     gint           length);
		external
			"C (GtkText*, GdkFont*, GdkColor*, GdkColor*, char*, gint) | <gtk/gtk.h>"
		end
		
	gtk_text_set_point (a_text: POINTER; a_index: INTEGER) is
			-- void       gtk_text_set_point       (GtkText       *text,
			-- 				     guint          index);
		external
			"C (GtkText*, guint) | <gtk/gtk.h>"
		end
		
	gtk_text_freeze (a_text: POINTER) is
			-- void       gtk_text_freeze          (GtkText       *text);
		external
			"C (GtkText*) | <gtk/gtk.h>"
		end
		
	gtk_text_thaw (a_text: POINTER) is
			-- void       gtk_text_thaw            (GtkText       *text);
		external
			"C (GtkText*) | <gtk/gtk.h>"
		end
		
	gtk_text_set_word_wrap (a_text: POINTER; word_wrap: INTEGER) is
		external
			"C (GtkText*, gint) | <gtk/gtk.h>"
		end

	gtk_text_set_line_wrap (a_text: POINTER; word_wrap: INTEGER) is
		external
			"C (GtkText*, gint) | <gtk/gtk.h>"
		end		

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT
	
	
feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable.
		do
			--| FIXME This should be removed when gtk1 imp is made obsolete
			Result := (create {EV_GTK_DEPENDENT_EXTERNALS}).gtk_editable_get_editable (entry_widget)
		end

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_editable_get_position (entry_widget) + 1
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget) /= 
				{EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget)
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		local
			a_start: INTEGER
		do
			a_start := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget)
			Result := a_start.min ({EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget)) + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		local
			a_start: INTEGER
		do
			a_start := {EV_GTK_EXTERNALS}.gtk_editable_struct_selection_start (entry_widget)
			Result := a_start.max ({EV_GTK_EXTERNALS}.gtk_editable_struct_selection_end (entry_widget))
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
			{EV_GTK_EXTERNALS}.gtk_editable_set_editable (entry_widget, flag)
		end

	set_position (pos: INTEGER) is
			-- Set current insertion position.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_set_position (entry_widget, pos - 1)
		end

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			internal_set_caret_position (pos)
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (highlight) the text between 
			-- 'start_pos' and 'end_pos'.
		do
			internal_set_caret_position (end_pos.max (start_pos) + 1)
			select_region_internal (start_pos, end_pos)
			internal_timeout_imp ?= (create {EV_TIMEOUT}).implementation
			internal_timeout_imp.interface.actions.extend 
				(agent select_region_internal (start_pos, end_pos))
			internal_timeout_imp.set_interval_kamikaze (0)
		end	

	select_region_internal (start_pos, end_pos: INTEGER) is
			-- Select region
		do
			{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, start_pos.min (end_pos) - 1, end_pos.max (start_pos))
		end

	deselect_all is
			-- Unselect the current selection.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_delete_selection (entry_widget)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_cut_clipboard (entry_widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			{EV_GTK_EXTERNALS}.gtk_editable_copy_clipboard (entry_widget)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := position
			set_position (index)
			insert_text (clipboard_content)
			set_position (pos)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_signal_connect (entry_widget, "changed", agent (App_implementation.gtk_marshal).text_component_change_intermediary (c_object), Void)
		end

	internal_timeout_imp: EV_TIMEOUT_IMP
			-- Timeout to call 'select_region

	stored_text: STRING
			-- Value of 'text' prior to a change action, used to compare
			-- between old and new text.

	in_change_action: BOOLEAN
			-- Is Current being changed?

	toggle_in_change_action (a_flag: BOOLEAN) is
			-- Set 'in_change_action' to 'a_flag'
		do
			in_change_action := a_flag
		end

	on_change_actions is
			-- A change action has occurred.
		do
			toggle_in_change_action (True)
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
			toggle_in_change_action (False)
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TEXT_IMP

