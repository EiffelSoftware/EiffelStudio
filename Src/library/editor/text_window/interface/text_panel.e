indexing
	description: "[
		Editable: no
		Scroll bars: yes
		Cursor: no
		Keyboard: no
		Mouse: no
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL

inherit
	TEXT_PANEL_IMP
		rename
			file_name as const_file_name,
			initialized_cell as constants_initialized_cell
		redefine
			default_create
		end

	TEXT_OBSERVER
		undefine
			copy,
			is_equal,
			default_create
		redefine
			on_text_loaded,
			on_text_block_loaded,
			on_text_fully_loaded
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
		undefine
			copy,
			is_equal,
			default_create
		end

	DOCUMENT_TYPE_MANAGER
		undefine
			copy,
			is_equal,
			default_create
		end

	SHARED_EDITOR_DATA
		undefine
			copy,
			is_equal,
			default_create
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Initialization

	default_create is
			-- Default creation
		do
			create widget
			initialize
			is_initialized := True
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_parent: EV_HORIZONTAL_BOX
		do
				-- First display the first line...
			first_line_displayed := 1
			line_numbers_enabled := True
			panel_manager.add_panel (Current)
			initialize_editor_context
			text_displayed := new_text_displayed
			set_current_document_class (default_document_class)
			editor_width := buffered_drawable_width
			main_vbox.set_background_color (editor_preferences.normal_background_color)
			inner_hbox.set_background_color (editor_preferences.normal_background_color)

				-- Create the margin and associate it with `margin_container'.
			create margin.make_with_panel (Current)
			l_parent ?= margin_container.parent
			check l_parent_not_void: l_parent /= Void end
			l_parent.prune (margin_container)
			margin_container := margin.margin_viewport
			l_parent.put_front (margin_container)
			l_parent.disable_item_expand (margin_container)

			editor_drawing_area.set_minimum_size (buffered_drawable_width, buffered_drawable_height)

				-- Viewport Events
			editor_drawing_area.expose_actions.extend (agent on_repaint)
			editor_drawing_area.resize_actions.extend (agent on_size)
			editor_drawing_area.mouse_wheel_actions.extend (agent on_mouse_wheel)
			editor_drawing_area.focus_in_actions.extend (agent on_focus)
			editor_viewport.resize_actions.extend (agent on_viewport_size)

				-- Scrollbar Events		
			vertical_scrollbar.change_actions.extend (agent on_vertical_scroll)
			horizontal_scrollbar.change_actions.extend (agent on_horizontal_scroll)
			scroll_cell.set_minimum_size (vertical_scrollbar.width, vertical_scrollbar.width)
			update_scroll_agent := agent update_scrollbars_display
			last_vertical_scroll_bar_value := 1

				-- Set up the screen.
			buffered_line.set_background_color (editor_preferences.normal_background_color)

				-- Ensure line numbers are displayed
			refresh_line_number_agent := agent refresh_line_number_display
			editor_preferences.show_line_numbers_preference.change_actions.extend (refresh_line_number_agent)
			refresh_line_number_display
		end

	initialize_editor_context is
			-- Here initialize editor contextual settings.  For example, set location of cursor
			-- pixmaps.
		do
		end

feature -- Access

	is_initialized: BOOLEAN
			-- Is current text panel properly initialized? I.e. ready for use.

	new_text_displayed: like text_displayed is
			-- New instance of `text_displayed' for Current.
		do
			create Result.make
			Result.add_lines_observer (Current)
			Result.add_edition_observer (Current)
			Result.set_first_read_block_size (number_of_lines_in_block)
		ensure
			new_text_not_void: Result /= Void
		end

	text: STRING is
			-- Image of the text being displayed.
		do
			if text_displayed.is_empty then
				create Result.make (0)
			else
				Result := text_displayed.text
			end
		end

	text_displayed: TEXT
			-- Text currently displayed on the screen.

	file_name: FILE_NAME
			-- Name of the currently opened file, if any.

	size_of_file_when_loaded: INTEGER
			-- Number of bytes in current file when it was loaded.

	date_of_file_when_loaded: INTEGER
			-- Date of current file when it was loaded.

	margin: MARGIN_WIDGET
			-- Margin.

	first_line_displayed: INTEGER
			-- First line currently displayed on the screen.

	flip_count: INTEGER
			-- How many times has the `editor_viewport' been flipped?

	is_checking_modifications: BOOLEAN
			-- Are document modifications being checked?

	cursors: EDITOR_CURSORS
			-- Editor cursors

	icons: EDITOR_ICONS
			-- Editor icons

	is_offset_valid: BOOLEAN is
			-- If viewport offset vaild?
		do
			Result := editor_viewport.y_offset >= 0
		end

feature -- Status Setting

	set_cursors (a_cursors: like cursors) is
			-- Sets `cursors' with `a_cursors'
		require
			a_cursors_not_void: a_cursors /= Void
		do
			cursors := a_cursors
		ensure
			cursors_set: cursors = a_cursors
		end

	set_icons (a_icons: like icons) is
			-- Sets `icons' with `a_icons'
		require
			a_icons_not_void: a_icons /= Void
		do
			icons := a_icons
		ensure
			icons_set: icons = a_icons
		end

	set_text (a_text: like text_displayed; a_filename: STRING) is
			-- Set `text_displayed' to `text'.  If text is associated to a file store then
			-- `a_filename' should be that file.
		require
			text_not_void: a_text /= Void
		do
				-- Here we make sure observers of `text_displayed' also observers the new text.
			a_text.edition_observer_list.append (text_displayed.edition_observer_list)
			a_text.selection_observer_list.append (text_displayed.selection_observer_list)
			a_text.lines_observer_list.append (text_displayed.lines_observer_list)
			a_text.cursor_observer_list.append (text_displayed.cursor_observer_list)

			text_displayed := a_text
			create file_name.make_from_string (a_filename)
		end

	display_line_with_context (l_number: INTEGER) is
			-- display line number `l_number' in the editor
			-- center display on this line if it is not yet displayed
			-- scroll otherwise.
		require
			line_number_is_valid: 0 < l_number and then l_number <= number_of_lines
			text_loaded: text_is_fully_loaded
		local
			fld: INTEGER
		do
			if text_displayed.number_of_lines > number_of_lines_displayed then
				if first_line_displayed <= l_number - 2 and then l_number + 3 < (first_line_displayed + number_of_lines_displayed) then
					if number_of_lines_displayed <= 4 then
						fld := l_number - (number_of_lines_displayed // 2)
						set_first_line_displayed (fld.max (1).min (maximum_top_line_index), True)
					end
				else
					fld := l_number - (number_of_lines_displayed // 2)
					set_first_line_displayed (fld.max (1).min (maximum_top_line_index), True)
				end
			end
		end

	setup_editor (first_line_to_display: INTEGER) is
			-- Update `Current' to display at line `first_line_to_display' on current text.
		local
			l_line: INTEGER
		do
			if vertical_scrollbar.value_range.has (first_line_to_display) then
				l_line := first_line_to_display
			else
				l_line := 1
			end
			first_line_displayed := l_line

				-- Setup the scroll bars.
			vertical_scrollbar.enable_sensitive
			update_vertical_scrollbar
			update_horizontal_scrollbar
			update_width
			set_editor_width (editor_width)
			update_horizontal_scrollbar
			refresh_now
			margin.setup_margin
		end

	on_focus is
			-- Editor received focus
		local

		do
			editor_drawing_area.focus_in_actions.block

			if not is_checking_modifications and file_loaded then
				check_document_modifications_and_reload
			end

			editor_drawing_area.focus_in_actions.resume
		end

feature -- Query

	file_loaded: BOOLEAN is
			-- Has a file been loaded into the text panel?
		do
			Result := file_name /= Void and then not file_name.is_empty
		end

	editor_x: INTEGER is
			-- editor_viewport absolute position.
		do
			Result := editor_viewport.screen_x
		end

	editor_y: INTEGER is
			-- editor_viewport absolute position.
		do
			Result := editor_viewport.screen_y
		end

	has_focus: BOOLEAN is
			-- Does the text panel have focus?
		do
			Result := editor_drawing_area.has_focus
		end

	has_margin: BOOLEAN is
			-- Should margin be displayed?
		do
			Result := line_numbers_enabled and line_numbers_visible
		end

	is_empty: BOOLEAN is
			-- Is the text panel blank?
		do
			Result := text_displayed /= Void and then text_displayed.is_empty
		end

	text_is_fully_loaded: BOOLEAN is
			-- Is current text still being loaded?
		do
			Result := text_displayed /= Void and then text_displayed.reading_text_finished
		end

	line_numbers_visible: BOOLEAN is
			-- Are line numbers currently visible
		do
			Result := editor_preferences.show_line_numbers
		end

	view_invisible_symbols: BOOLEAN
			-- Are the spaces, the tabulations and the end_of_line characters visible?			

	is_unix_file: BOOLEAN
			-- Is current file a unix file? (i.e. is "%N" line separator?)	

	is_in_editor_panel (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Is point at absolute coordinates (`a_screen_x', `a_screeny') in the editor?
		do
			Result :=
						a_screen_x > editor_x
							and then
						a_screen_x < editor_x + editor_drawing_area.width
							and then
						a_screen_y > editor_y
							and then
						a_screen_y < editor_y + editor_drawing_area.height
		end

	number_of_lines: INTEGER is
		do
			Result := text_displayed.number_of_lines
		end

	number_of_lines_displayed: INTEGER is
			-- Number of lines currently displayed on the screen.	
		do
			Result := viewable_height // line_height
		end

	number_of_lines_displayed_from_text: INTEGER is
			-- Number of lines currently displayed on the screen, excluding the white space visible below the actual text.	
		do
			Result := number_of_lines_displayed
			if (first_line_displayed + Result) > text_displayed.number_of_lines then
				Result := text_displayed.number_of_lines - first_line_displayed + 1
			end
		end

	left_margin_width: INTEGER is
			-- Width of left margin
		do
			Result := editor_preferences.left_margin_width
			if Result < 1 then
				Result := default_left_margin_width
			end
		end

	changed: BOOLEAN is
			-- Has the content of the editor changed since it was
			-- loaded or saved?
		do
			Result := text_displayed /= Void and then text_displayed.is_modified
		end

	line_numbers_enabled: BOOLEAN
			-- Is it permitted to show line numbers in Current?

feature -- Pick and Drop

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions performed when user drops a stone on the text_area.
		do
			Result := editor_drawing_area.drop_actions
		end

feature -- File Properties

	date_when_checked: INTEGER
			-- Date of the open file when checked for the latest time

	file_date_already_checked: BOOLEAN
			-- Has the date of the file already been checked?

	file_is_up_to_date: BOOLEAN is
			-- Is the open file up to date?
		local
			retried: BOOLEAN
		do
			if not retried then
				if file_loaded and file_exists then
					Result := date_of_file_when_loaded = file_date_ticks and
						size_of_file_when_loaded = file_size
				end
				file_date_already_checked := True
			else
					-- If a failure occur, we are not up to date.
				Result := False
			end
		rescue
			retried := True
			retry
		end

	set_reference_window (a_window: like reference_window) is
			-- Set reference window
		do
			internal_reference_window := a_window
		end

feature -- Status setting

	refresh_line_number_display is
	        -- Refresh line number display in Current and update display
		do
			if has_margin then
				margin_container.show
			else
				margin_container.hide
			end
			refresh_now
	   	ensure
			widget_displayed: has_margin = margin_container.is_show_requested
	   	end

	enable_line_numbers is
			-- Enable line numbers
		do
			line_numbers_enabled := True
			refresh_line_number_display
		ensure
			line_numbers_enabled: line_numbers_enabled = True
		end

	disable_line_numbers is
			-- Disable line numbers
		do
			line_numbers_enabled := False
			refresh_line_number_display
		ensure
			line_numbers_disabled: line_numbers_enabled = False
		end

	toggle_view_invisible_symbols is
			-- Toggle `view_invisible_symbols'.
		do
			view_invisible_symbols := not view_invisible_symbols
			refresh_now
		ensure
			view_invisible_symbols_set: view_invisible_symbols = not old view_invisible_symbols
		end

	set_focus is
			-- Give the focus to the editor area.
		do
			if is_initialized and then not editor_drawing_area.is_destroyed and then editor_drawing_area.is_displayed and then editor_drawing_area.is_sensitive then
				if reference_window /= Void then
					if reference_window.has_focus then
						editor_drawing_area.set_focus
					end
				else
					editor_drawing_area.set_focus
				end
			else
				internal_focus_requested := True
			end
		end

feature -- Basic Operations

	refresh is
			-- Update display.
		do
			in_scroll := True
			editor_drawing_area.redraw
			margin.refresh
		end

	refresh_now is
			-- Update display without waiting for next idle
		do
			refresh
			margin.margin_area.flush
			editor_drawing_area.flush
			in_scroll := False
		end

	clear_window is
			-- Wipe out the text area.
		do
			reset
			update_vertical_scrollbar
			update_horizontal_scrollbar
			refresh_now
		end

	reset is
			-- Reinitialize `Current' so that it can receive a new content.
		do
				-- First abort our previous actions.
			text_displayed.reset_text
			editor_width := 100
			set_offset (0)
			first_line_displayed := 1
			vertical_scrollbar.set_value (1)
		end

	redraw_current_screen is
			-- Redraw the current screen. Do not scroll or move the cursor, just redraw.
		do
			set_first_line_displayed (first_line_displayed, True)
		end

	load_file (a_filename: STRING) is
			-- Load contents of `a_filename'
		require
			filename_not_void: a_filename /= Void
		local
			l_file: RAW_FILE
			l_doc_type: STRING
			l_date: like date_of_file_when_loaded
			l_size: like size_of_file_when_loaded
		do
			editor_drawing_area.disable_sensitive
				-- Check the document type of the file to load.
			l_doc_type := a_filename.substring (a_filename.last_index_of ('.', a_filename.count) + 1, a_filename.count)
			if l_doc_type /= Void and then known_document_type (l_doc_type) then
				set_current_document_class (get_class_from_type (l_doc_type))
			else
				set_current_document_class (default_document_class)
			end

			create l_file.make (a_filename)
			if l_file.exists then
				l_file.open_read
					-- Record date when opening the file since if the file
					-- has changed after the close operation we won't read it again.
				l_date := l_file.date
				l_size := l_file.count
				if l_file.is_empty then
					load_text ("")
				else
					l_file.read_stream (l_file.count)
					load_text (l_file.last_string)
				end
				l_file.close
			else
				load_text ("File: " + a_filename + "%Ndoes not exist.")
			end
			create file_name.make_from_string (a_filename)
			date_of_file_when_loaded := l_date
			size_of_file_when_loaded := l_size
		end

	load_text (s: STRING) is
			-- Display `s'.	
		local
			l_line: INTEGER
		do
				-- Reset the editor state
			reset

			is_unix_file :=	s.substring_index ("%R%N", 1) = 0
			if not is_unix_file then
				s.replace_substring_all ("%R%N", "%N")
			end

			file_loading_setup

				-- Read and parse the file.
			text_displayed.set_first_read_block_size (number_of_lines_in_block)
			text_displayed.load_string (s)

				-- Setup the editor to load first page and display proper first line.
			if first_line_displayed > 0 and then first_line_displayed <= number_of_lines then
				l_line := first_line_displayed
			else
				l_line := 1
			end
			setup_editor (l_line)
		end

	on_font_changed is
			-- Recompute token information for for loaded text.
		local
			l_line_index: INTEGER
		do
				-- Recompute token information for for loaded text.
			from
				l_line_index := 1
			until
				l_line_index > text_displayed.number_of_lines
			loop
				text_displayed.update_line (l_line_index)
				l_line_index := l_line_index + 1
			end

			buffered_line.set_size (buffered_line.width, line_height)
			update_horizontal_scrollbar
			update_vertical_scrollbar
			margin.on_font_changed
			redraw_current_screen
		end

	check_document_modifications_and_reload is
			-- Check document modifications and reload as necessary.
		require
			not_is_checking_modifications: not is_checking_modifications
			file_loaded: file_loaded
		local
			dialog: EV_INFORMATION_DIALOG
			button_labels: ARRAY [STRING]
			actions: ARRAY [PROCEDURE [ANY, TUPLE]]
		do
			is_checking_modifications := True

			if not file_exists then
				reload
			elseif not file_is_up_to_date then
				if changed or not editor_preferences.automatic_update then
						-- File has not changed in panel and is not up to date.  However, user does want auto-update so prompt for reload.
					create dialog.make_with_text ("This file has been modified by another editor.")
					create button_labels.make (1, 2)
					create actions.make (1, 2)
					button_labels.put ("Reload", 1)
					actions.put (agent reload, 1)
					button_labels.put ("Continue anyway", 2)
					actions.put (agent continue_editing, 2)
					dialog.set_buttons_and_actions (button_labels, actions)
					dialog.set_default_push_button (dialog.button (button_labels @ 1))
					dialog.set_default_cancel_button (dialog.button (button_labels @ 2))
					dialog.set_title ("External edition")
					dialog.show_modal_to_window (reference_window)
				elseif editor_preferences.automatic_update and not changed then
					reload
				end
			end

			is_checking_modifications := False
		ensure
			is_checking_modifications_is_false: is_checking_modifications = False
		end

feature -- Graphical interface

	pointer_style: EV_POINTER_STYLE is
			-- Pointer style over the text.
		do
			Result := editor_drawing_area.pointer_style
		end

	font: EV_FONT is
			-- Font used to display the text
		do
			Result := editor_preferences.font
		end

	line_height: INTEGER is
			-- Height of lines in pixels.
		do
			Result := editor_preferences.line_height
		end

	reference_window: EV_WINDOW is
			-- Window which error dialogs will be shown relative to.  Void if not set using `set_reference_window'.
		do
			Result := internal_reference_window
		end

	show_warning_message (a_message: STRING_GENERAL) is
			-- show `a_message' in a dialog window		
		local
			wd: EV_WARNING_DIALOG
		do
			create wd.make_with_text (a_message)
			wd.pointer_button_release_actions.force_extend (agent wd.destroy)
			wd.key_press_actions.force_extend (agent wd.destroy)
			wd.show_modal_to_window (reference_window)
		end

feature {MARGIN_WIDGET} -- Private properties of the text window

	offset: INTEGER is
			-- Horizontal offset of the display.
		do
			Result := editor_viewport.x_offset
		end

	number_of_lines_in_block: INTEGER is
			-- Default number of lines read when loading a text in editor.
		do
			Result := 4 * number_of_lines_displayed
		ensure
			number_of_lines_computed_non_negative: Result >= 0
		end

	editor_width: INTEGER
			-- Width of the text. (i.e. minimum width of the panel
			-- for which no scroll bar is needed)

	maximum_top_line_index: INTEGER is
			-- Number of the last possible line that can be displayed
			-- at the top of the editor window.
		do
			Result := (text_displayed.number_of_lines - (number_of_lines_displayed // 2)).max (1)
		end

	show_vertical_scrollbar: BOOLEAN is
			-- Is it necessary to show the vertical scroll bar ?
		do
			Result := text_displayed /= Void and then (text_displayed.number_of_lines > number_of_lines_displayed // 2)
		end

	horizontal_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update horizontal
			-- scroll bar display ?

	vertical_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update vertical
			-- scroll bar display ?

	display_margin: BOOLEAN
			-- Should margin be displayed?	

feature -- Status Setting

	set_editor_width (a_width: INTEGER) is
			-- If `a_width' is greater than `editor_width', assign `a_width' to `editor_width'
			-- update display if necessary.
		local
			l_old_width: INTEGER
		do
			l_old_width := editor_width
			editor_width := a_width.max (editor_width)
			if editor_width > l_old_width then
				editor_drawing_area.redraw_rectangle (0, editor_viewport.y_offset, viewable_width, viewable_height)
				update_horizontal_scrollbar
			end
		end

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN) is
			-- Assign `fld' to `first_line_displayed'.
		require
			fld_large_enough: fld > 0
			fld_small_enough: fld <= text_displayed.number_of_lines.max (1)
			fld_in_range: vertical_scrollbar.value_range.has (fld)
		do
			first_line_displayed := fld
			vertical_scrollbar.set_value (fld)
		end

	set_offset (an_offset: INTEGER) is
			-- Assign `an_offset' to `offset' and update scrollbar if necessary.
		do
			editor_viewport.set_x_offset (an_offset)
			if horizontal_scrollbar.is_show_requested then
				check
					offset_within_bounds: horizontal_scrollbar.value_range.has (an_offset)
				end
				horizontal_scrollbar.set_value (offset.min (horizontal_scrollbar.value_range.upper))
			end
		end

feature {NONE} -- Scroll bars Management

	update_horizontal_scrollbar is
			-- Update horizontal scrollbar value range and show it or
			-- hide it if it is not needed.
		local
			w: INTEGER
		do
			w := editor_viewport.width
			if editor_width > w and w > 0 and then not is_empty then
				horizontal_scrollbar.value_range.resize_exactly (0, editor_width - w)
				horizontal_scrollbar.set_leap (w)
				if horizontal_scrollbar.is_show_requested then
					if not platform_is_windows then
						horizontal_scrollbar_needs_updating := False
					end
				else
					horizontal_scrollbar.show
					horizontal_scrollbar_needs_updating := True
					ev_application.add_idle_action (update_scroll_agent)
				end
			elseif horizontal_scrollbar.is_show_requested then
				horizontal_scrollbar.value_range.resize_exactly (0, 1)
				horizontal_scrollbar.set_leap (1)
				horizontal_scrollbar.hide
				horizontal_scrollbar_needs_updating := True
				set_offset (0)
				ev_application.add_idle_action (update_scroll_agent)
			elseif horizontal_scrollbar_needs_updating and then not platform_is_windows then
				horizontal_scrollbar_needs_updating := False
			else
				horizontal_scrollbar_needs_updating := True
			end
			update_scroll_cell
		end

	update_vertical_scrollbar is
			-- Update vertical scrollbar value range.
			-- Show it or hide it depending on what is appropriate.
		local
			nol: INTEGER
		do
			if not in_resize then
				in_resize := True

				if show_vertical_scrollbar then
					nol := text_displayed.number_of_lines
					vertical_scrollbar.value_range.resize_exactly (1, maximum_top_line_index)
					if first_line_displayed > maximum_top_line_index then
						vertical_scrollbar.set_value (maximum_top_line_index)
					else
						vertical_scrollbar.set_value (first_line_displayed)
					end
					vertical_scrollbar.set_leap (number_of_lines_displayed.max (1))
					if scroll_vbox.is_show_requested then
						if not platform_is_windows then
							vertical_scrollbar_needs_updating := False
						end
					else
						scroll_vbox.show
						vertical_scrollbar_needs_updating := True
						ev_application.add_idle_action (update_scroll_agent)
					end
				elseif scroll_vbox.is_show_requested then
					scroll_vbox.hide
					vertical_scrollbar_needs_updating := True
					ev_application.add_idle_action (update_scroll_agent)
				elseif vertical_scrollbar_needs_updating and then not platform_is_windows then
					vertical_scrollbar_needs_updating := False
				else
					vertical_scrollbar_needs_updating := True
				end
				update_scroll_cell
				in_resize := False
			end
		end

	update_scroll_cell is
			-- Hide or show scroll bar depending on what is appropriate.
		do
			if vertical_scrollbar.is_show_requested and then horizontal_scrollbar.is_show_requested then
				scroll_cell.show
			else
				scroll_cell.hide
			end
		end

	update_scrollbars_display is
			-- Ensure scrollbars are correctly hidden.
		do
			if horizontal_scrollbar_needs_updating then
				horizontal_scrollbar_needs_updating := False
				if platform_is_windows then
					if horizontal_scrollbar.is_show_requested then
						horizontal_scrollbar.show
					else
						horizontal_scrollbar.hide
						scroll_cell.show
						scroll_cell.hide
					end
				else
					if horizontal_scrollbar.is_show_requested then
						horizontal_scrollbar.hide
						horizontal_scrollbar.show
						scroll_cell.hide
						scroll_cell.show
					else
						horizontal_scrollbar.show
						horizontal_scrollbar.hide
						scroll_cell.show
						scroll_cell.hide
					end
				end
			end
			if vertical_scrollbar_needs_updating then
				vertical_scrollbar_needs_updating := False
				if platform_is_windows then
					if scroll_vbox.is_show_requested then
						scroll_vbox.show
					else
						scroll_vbox.hide
					end
				else
					if scroll_vbox.is_show_requested then
						scroll_vbox.hide
						scroll_vbox.show
					else
						scroll_vbox.show
						scroll_vbox.hide
					end
				end
			end
			ev_application.remove_idle_action (update_scroll_agent)
		end

	update_width is
			-- Update `editor_width'
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i = number_of_lines
			loop
				editor_width := editor_width.max (text_displayed.line (i).width)
				i := i + 1
			end
		end

	on_vertical_scroll (vscroll_pos: INTEGER) is
 			-- Process vertical scroll event. `vertical_scrollbar.value' has changed.
 		local
 			l_bottom_line_y,
 			l_top_line_y,
 			l_diff,
 			view_y_offset,
 			l_line_height,
 			l_buff_height: INTEGER
 		do
 			in_scroll := True
 			l_diff := vscroll_pos - last_vertical_scroll_bar_value
 			first_line_displayed := (vscroll_pos.min (text_displayed.number_of_lines)).max (1)
 			view_y_offset := editor_viewport.y_offset
 			l_line_height := line_height
 			l_buff_height := buffered_drawable_height

 			if l_diff < 0 then
 					-- Scroll up
 				l_top_line_y := vscroll_pos * l_line_height -- pixel y offset of NEW vertical scrollbar value 				
 				if (view_y_offset + (l_diff * l_line_height)) < 0 then
 						-- The newly anticipated y_offset (taking into account where we are moving to) is
 						-- above the drawing area, so flip to the bottom
 					editor_viewport.set_y_offset (l_buff_height - viewable_height - ((l_buff_height - viewable_height) \\ l_line_height))
 					flip_count := flip_count - 1
					margin.synch_with_panel
 					refresh_now
 				else
 					editor_viewport.set_y_offset (view_y_offset + (l_diff * l_line_height))
 					check
 						not_negative: editor_viewport.y_offset >= 0
 					end
					margin.synch_with_panel
 				end
 			elseif l_diff > 0 then
 					-- Scroll down
 				l_bottom_line_y := viewable_height + view_y_offset + (l_diff * l_line_height)
 				if l_bottom_line_y > l_buff_height then
 					editor_viewport.set_y_offset (0)
 					flip_count := flip_count + 1
					margin.synch_with_panel
 					refresh_now
 				else
 					editor_viewport.set_y_offset (view_y_offset + (l_diff * l_line_height))
					margin.synch_with_panel
 				end
 			end
			last_vertical_scroll_bar_value := vscroll_pos

			check
 				not_too_high: editor_viewport.y_offset >= 0
 				not_too_low: (editor_viewport.y_offset + viewable_height) <= buffered_drawable_height
 			end
 		end

 	on_horizontal_scroll (scroll_pos: INTEGER) is
 			-- Process horizontal scroll event. `horizontal_scrollbar.value' has changed.
 		do
 			in_scroll := True
			set_offset (scroll_pos)
			buffered_line.set_size ((viewable_width + offset).max (buffered_line.width), line_height)
		end

	on_mouse_wheel (delta: INTEGER) is
			-- Mouse wheel has been moved `delta' units, adjust `Current' accordingly.
		local
			l_offset: INTEGER
		do
			if delta > 0 then
				l_offset := (1).max (
					first_line_displayed - scrolling_quantum * delta)
			else
				l_offset := (maximum_top_line_index).min (
					first_line_displayed - scrolling_quantum * delta)
			end
			if vertical_scrollbar.value_range.has (l_offset) then
				set_first_line_displayed (l_offset, True)
			end
		end

	scrolling_quantum: INTEGER is
			-- Number of lines to scroll per mouse wheel scroll increment.
		do
			if editor_preferences.mouse_wheel_scroll_full_page then
				Result := number_of_lines_displayed - common_line_count
			else
				Result := editor_preferences.mouse_wheel_scroll_size
			end
		end

	in_scroll: BOOLEAN
			-- Are we in a scroll operation?

feature {NONE} -- Display functions

	on_repaint (x, y, a_width, a_height: INTEGER) is
			-- Repaint the part of the panel between in the viewable area between
			-- (`x', `y') and (`x' + `a_width', `y' + `a_height').
			--| Actually, rectangle defined by (0, y) -> (editor_drawing_area.width, y + height) is redrawn.
		do
			on_paint := True
			if a_width /= 0 and a_height /= 0 then
				update_area (x, y, a_width, y + a_height, x, not in_scroll)
			end
			on_paint := False
		end

	on_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER) is
			-- Refresh the panel after it has been resized (and moved) to new coordinates (`a_x', `a_y') and
			-- new size (`a_width', `a_height').
			--| Note: This feature is called during the creation of the window
		do
			update_vertical_scrollbar
			update_horizontal_scrollbar
		end

	on_viewport_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER) is
			-- Viewport was resized.
		local
			l_int_v: INTEGER
		do
			if is_initialized then
					-- Do not ever make the buffered line smaller, only larger.
				if (a_width + offset) > buffered_line.width then
					buffered_line.set_size (a_width + offset, line_height)
				end
				update_vertical_scrollbar
				update_horizontal_scrollbar
				update_viewport_after_resize
				last_viewport_height := a_height
				l_int_v := vertical_scrollbar.value
				set_first_line_displayed (first_line_displayed.min (maximum_top_line_index), False)
				if l_int_v = vertical_scrollbar.value then
						-- Even though the scrollbar value has not changed, its size has
						-- changed and we need to update the viewport offset.
						-- Not doing so would mess up scrolling if you are at the end of the
						-- text and make the editor bigger, then content will be messed up when
						-- you scroll up with the mousewheel.
					on_vertical_scroll (first_line_displayed.min (maximum_top_line_index))
				end
			end
		end

	last_viewport_height: INTEGER

	update_viewport_after_resize is
			--
		do
			if editor_viewport.y_offset + viewable_height > buffered_drawable_height then
					-- The viewport needs to be moved up because it is too low down to display
				editor_viewport.set_y_offset (editor_viewport.y_offset - (editor_viewport.height - last_viewport_height))
				margin.margin_viewport.set_y_offset (editor_viewport.y_offset)
			end
		end

	update_area (x_pos, top, a_width, bottom: INTEGER; x: INTEGER; buffered: BOOLEAN) is
 			-- Update drawing area between `top' and `bottom' and `x' and `a_width'.  If `buffered' then draw to `buffered_line'
 			-- before drawing to screen, otherwise draw straight to screen.
 		require
 			range_valid: bottom >= top
 			on_paint: on_paint
 		local
 			first_line_to_draw,
 			last_line_to_draw,
 			y_offset,
 			view_y_offset: INTEGER
 		do
 			view_y_offset := editor_viewport.y_offset

 				-- Draw all lines
 			first_line_to_draw := (first_line_displayed + (top - view_y_offset) // line_height).max (1)
 			last_line_to_draw := ((first_line_displayed + (bottom - view_y_offset) // line_height).min (text_displayed.number_of_lines))

			check
				not_too_many_lines: (bottom = top) implies first_line_to_draw = last_line_to_draw
				lines_valid: first_line_to_draw <= last_line_to_draw or last_line_to_draw = text_displayed.number_of_lines
			end

			if text_displayed.number_of_lines > 0 then
				if first_line_to_draw > last_line_to_draw then
					update_lines (last_line_to_draw, last_line_to_draw, x_pos, a_width, buffered)
				else
					update_lines (first_line_to_draw, last_line_to_draw, x_pos, a_width, buffered)
				end
			end

 			if last_line_to_draw = text_displayed.number_of_lines or text_displayed.number_of_lines = 0 then
	 				-- The file is too small for the screen, so we fill in the last portion of the screen.
	 			y_offset := editor_viewport.y_offset + (((last_line_to_draw + 1) - first_line_displayed) * line_height)
	 			if (editor_viewport.y_offset + viewable_height) > y_offset then
					editor_drawing_area.set_background_color (editor_preferences.normal_background_color)
					debug ("editor")
						draw_flash (x_pos, y_offset, viewable_width, (editor_viewport.y_offset + viewable_height) - y_offset, False)
					end
					editor_drawing_area.clear_rectangle (x_pos, y_offset, viewable_width, (editor_viewport.y_offset + viewable_height) - y_offset)
				end
 			end
 			in_scroll := False
 		end

	update_lines (first, last, start_pos, end_pos: INTEGER; buffered: BOOLEAN) is
			-- Draw the lines `first' to `'last' between `start_pos' and `end_pos'.
		require
			lines_valid: first <= last
			first_line_valid: first >= 1 and first <= number_of_lines
			last_line_valid: last >= 1
			on_paint: on_paint
		local
 			curr_line,
 			y_offset: INTEGER
 			l_text: TEXT
		do
			updating_line := True
			l_text := text_displayed
			if not l_text.is_empty then
				l_text.go_i_th (first)

				if buffered then
					buffered_line.set_background_color (editor_preferences.normal_background_color)
				end

				from
	 				curr_line := first
	 			until
	 				curr_line > last or else l_text.after
	 			loop
	 				y_offset := editor_viewport.y_offset + ((curr_line - first_line_displayed) * line_height)

					if buffered then
	 		--			draw_line_to_buffered_line (curr_line, l_text.current_line)
			--			draw_buffered_line_to_screen (0, y_offset)
					else
						draw_line_to_screen (start_pos, end_pos, y_offset, l_text.current_line)
					end
	 				curr_line := curr_line + 1
					y_offset := y_offset + line_height
	 				l_text.forth
	 			end
			end

 			updating_line := False
		end

	invalidate_block (first, last: INTEGER; flush_screen: BOOLEAN) is
			-- Update the lines from `first' to `last'.  If `buffered' then draw to `buffered_line'
 			-- before drawing to screen, otherwise draw straight to screen.
		require
			lines_valid: first <= last
			first_line_valid: first >= 1
			last_line_valie: last >= 1
		local
 			y_pos,
 			l_line_height: INTEGER
		do
			l_line_height := line_height
			y_pos := (first - first_line_displayed) * l_line_height
			editor_drawing_area.redraw_rectangle (0, editor_viewport.y_offset + y_pos, buffered_line.width, (last - first + 1) * l_line_height)
			if flush_screen then
				editor_drawing_area.flush
			end
		end

	draw_buffered_line_to_screen (start_pos, end_pos, x, y: INTEGER) is
			-- Draw to the screen the data in `buffered_line' between `start_pos' x-coordinate and `end_pos' x-coordinate.
			-- Draw to y position `y' in the drawing area and x position `x'.
		require
			on_paint: on_paint
		do
			debug ("editor")
				draw_flash (x, y, end_pos - start_pos, line_height, True)
			end
			editor_drawing_area.draw_sub_pixmap (x, y, buffered_line, create {EV_RECTANGLE}.make (start_pos, 0, end_pos - start_pos, line_height))
			draw_margin (y)
		end

	draw_line_to_screen (start_pos, end_pos, y: INTEGER; a_line: EDITOR_LINE) is
			-- Draw to the screen the tokens in the line that are between `start_pos' and `end_pos'.
			-- Draw to y position `y' in the drawing area and draw from x position `start_pos + left_margin_width' in the
			-- drawing area.
		require
			on_paint: on_paint
		local
			curr_token: EDITOR_TOKEN
			da: EV_DRAWING_AREA
			redraw_token: BOOLEAN
			token_start_pos,
			token_end_position: INTEGER
			eol_token: EDITOR_TOKEN_EOL
		do
			from
				if offset < left_margin_width then
					draw_margin (y)
				end
				a_line.start
				da := editor_drawing_area
				curr_token := a_line.item
				da.set_background_color (editor_preferences.normal_background_color)
			until
				a_line.after or else curr_token = a_line.eol_token or else token_start_pos > editor_width
			loop
				token_start_pos := curr_token.position
				token_end_position := token_start_pos + curr_token.width
				redraw_token := not curr_token.is_margin_token and then
					(
						(token_start_pos >= start_pos and token_start_pos <= end_pos) or
						(token_end_position >= start_pos and token_end_position <= end_pos) or
						(token_start_pos <= start_pos and token_end_position >= end_pos)
					)
				if redraw_token then
					curr_token.display_with_offset (token_start_pos + left_margin_width, y, da, Current)
				end
				a_line.forth
				curr_token := a_line.item
			end
			if curr_token = a_line.eol_token and then view_invisible_symbols then
				eol_token ?= curr_token
				eol_token.display_with_offset (curr_token.position + left_margin_width, y, da, Current)
			end
		end

 	draw_margin (y: INTEGER) is
 			-- Draw the left margin space (not the line margin)
 		do
 			debug ("editor")
				draw_flash (0, y, left_margin_width, line_height, False)
			end
			editor_drawing_area.set_background_color (editor_preferences.normal_background_color)
			editor_drawing_area.clear_rectangle (0, y, left_margin_width, line_height)
 		end

 	draw_flash (x, y, width, height: INTEGER; buffered: BOOLEAN) is
 			--
 		do
 			if buffered then
 				editor_drawing_area.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (200, 20, 20))
 			else
 				editor_drawing_area.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (20, 20, 200))
 			end
 			editor_drawing_area.clear_rectangle (x, y, 1000, height)
 			ev_application.sleep (50)
 			editor_drawing_area.set_background_color (editor_preferences.normal_background_color)
 		end

 	draw_line_to_buffered_line (xline: INTEGER; a_line: EDITOR_LINE) is
			-- Draw onto the buffered line the tokens in `a_line'.
		require
			text_is_not_empty: not text_displayed.is_empty
			on_paint: on_paint
 		local
 			curr_token	: EDITOR_TOKEN
 			curr_y		: INTEGER
 		do
   			curr_y := (xline - first_line_displayed) * line_height
  			from
				a_line.start
				curr_token := a_line.item
				buffered_line.clear
 			until
 				a_line.after or else curr_token = a_line.eol_token or else curr_token.position > editor_width
 			loop
					-- Normally Display the token.
				if not curr_token.is_margin_token then
					curr_token.display (0, buffered_line, Current)
				end

					-- Prepare next iteration
				a_line.forth
				curr_token := a_line.item
			end
		end

	invalidate_line (line_number: INTEGER; draw_immediately: BOOLEAN) is
			-- Set the line `line_number' to be redrawn.
			-- Redraw immediately if `flush' is set.
		local
			y_pos: INTEGER
			l_line_height: INTEGER
		do
			l_line_height := line_height
			y_pos := (line_number - first_line_displayed )* l_line_height

			editor_drawing_area.redraw_rectangle (0, editor_viewport.y_offset + y_pos, buffered_line.width, l_line_height)
			if draw_immediately then
				editor_drawing_area.flush
			end

			-- The code below uses a direct call to the expose actions.  It was done because something on GTK was broken without it,
			-- but I cannot remember what that was.  So if GTK has issues using this instead of the code above will fix it, but a better
			-- solution is going to be needed because the code below is a hack.

			--			if draw_immediately then
			--				editor_drawing_area.expose_actions.call ([0, editor_viewport.y_offset + y_pos, buffered_line.width, line_height])
			--			else
			--				editor_drawing_area.redraw_rectangle (0, editor_viewport.y_offset + y_pos, buffered_line.width, line_height)
			--			end
		end

feature {NONE} -- Text loading

	reload is
			-- Reload the opened file from disk.
		do
			if file_name /= Void and then not file_name.is_empty then
				load_file (file_name.string)
			end
		end

	on_text_loaded is
			-- Finish the panel setup as the entire text has been loaded.
		do
			editor_width := 0
			from
				text_displayed.start
			until
				text_displayed.after
			loop
				editor_width := editor_width.max (text_displayed.current_line.width)
				text_displayed.forth
			end
			editor_width := editor_width + left_margin_width + margin.width
			set_editor_width (editor_width)
			vertical_scrollbar.enable_sensitive
			update_vertical_scrollbar
			update_horizontal_scrollbar
			editor_drawing_area.enable_sensitive
			refresh
		end

	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Update scroll bar as a new block of text as been loaded.
		do
			update_vertical_scrollbar
		end

	on_text_fully_loaded is
			-- Text has been fully loaded
		do
			if internal_focus_requested then
				set_focus
				internal_focus_requested := False
			end
		end

	file_loading_setup is
			-- Setup before file loading
		do
		end

feature {MARGIN} -- Implementation

	in_resize: BOOLEAN
			-- Are we a call to on_resize that was not triggered by the function itself.

	update_scroll_agent: PROCEDURE [like Current, TUPLE]
			-- Agent for scrollbar display updates.

	platform_is_windows: BOOLEAN is
			-- Is windows the current platform?
		once
			Result := (create {PLATFORM}).is_windows
		end

	updating_line: BOOLEAN
			-- Is buffered line currently being updated?

	default_left_margin_width: INTEGER is 10
			-- Default width of left margin

	internal_reference_window: like reference_window
			-- Window which error dialogs will be shown relative to.		

	right_buffer_width: INTEGER is 50

feature {NONE} -- Implementation

	refresh_line_number_agent: PROCEDURE [ANY, TUPLE]
			-- Agent called when `show_line_numbers' preferences is changed.

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
				-- Cannot use current anymore.
			is_initialized := False

			ev_application.remove_idle_action (update_scroll_agent)

				-- Remove `refresh_line_number_agent' from `change_actions' for `show_line_numbers'.
			editor_preferences.show_line_numbers_preference.change_actions.prune_all (refresh_line_number_agent)
			refresh_line_number_agent := Void

				-- Reset scrolling agent.
			update_scroll_agent := Void

			if editor_drawing_area /= Void then
				editor_drawing_area.destroy
				editor_drawing_area := Void
			end
			if margin /= Void then
				margin.destroy
				margin := Void
			end
			if scroll_cell /= Void then
				scroll_cell.destroy
				scroll_cell := Void
			end
			if horizontal_scrollbar /= Void then
				horizontal_scrollbar.destroy
				horizontal_scrollbar := Void
			end
			if vertical_scrollbar /= Void then
				vertical_scrollbar.destroy
				vertical_scrollbar := Void
			end
			if text_displayed /= Void then
				text_displayed.recycle
				text_displayed := Void
			end
			if editor_viewport /= Void then
				editor_viewport.destroy
				editor_viewport := Void
			end
			panel_manager.remove_panel (Current)
		ensure
			not_initialized: not is_initialized
		end

feature -- Implementation

	buffered_line: EV_PIXMAP is
			-- Buffer large enough to hold line information.
		once
			create Result.make_with_size (1, line_height)
		end

	buffered_drawable_width: INTEGER is 15000

	buffered_drawable_height: INTEGER is 15000
		-- Default size of `drawable' used for scrolling purposes.
		--| This value used to be 32000 but on gtk post 2.10.6 there seems to be some sort of 'fix' that gives odd results
		--| with the line number code that means that they do not get displayed correctly

	last_vertical_scroll_bar_value: INTEGER
		-- Last value of `vertical_scroll_bar' used within `vertical_scroll_bar_changed'. See
		-- comment of `last_horizontal_scroll_bar_value' for details of it's use.

	viewable_width: INTEGER is
			-- Width of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars.
		do
			Result := editor_viewport.width
		end

	viewable_height: INTEGER is
			-- Height of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars and/or header if shown.
		do
			Result := editor_viewport.height
		end

	on_paint: BOOLEAN

	internal_focus_requested: BOOLEAN
		-- Should give focus after text has been fully loaded?

	common_line_count: INTEGER is
			-- Number of lines in common when performing a page down/page up operation.
		do
			Result := editor_preferences.scrolling_common_line_count
		end

	file_date_ticks: INTEGER is
			-- Retrieve file last modified date in the number of ticks
		require
			file_loaded: file_loaded
			file_exists: file_exists
		local
			l_file: RAW_FILE
		do
			create l_file.make (file_name.string)
			Result := l_file.date
		end

	file_size: INTEGER is
			-- Retrieve file count
		require
			file_loaded: file_loaded
			file_exists: file_exists
		local
			l_file: RAW_FILE
		do
			create l_file.make (file_name.string)
			Result := l_file.count
		end

	file_exists: BOOLEAN is
			-- Retrieve file last modified date in the number of ticks
		require
			file_loaded: file_loaded
		local
			l_file: RAW_FILE
		do
			create l_file.make (file_name.string)
			Result := l_file.exists
		end

	continue_editing is
			-- Continue editing document
			-- Note: Called from the reload request prompt
		require
			file_loaded: file_loaded
			file_exists: file_exists
			text_is_fully_loaded: text_is_fully_loaded
		do
			text_displayed.set_changed (True, False)
			date_of_file_when_loaded := file_date_ticks
			size_of_file_when_loaded := file_size
		end

feature {NONE} -- Implementation

	line_type: EDITOR_LINE is
			-- Type of a line.
		do
		end

	cursor_type: TEXT_CURSOR is
			-- Type of a cursor.
		do
		end


invariant
	offset_view: is_offset_valid

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




end -- class TEXT_PANEL
