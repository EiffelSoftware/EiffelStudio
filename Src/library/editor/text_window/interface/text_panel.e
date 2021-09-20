note
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

	SYSTEM_ENCODINGS
		export
			{NONE} all
		undefine
			default_create
		end

	ENCODING_DETECTOR
		rename
			detected_encoding as default_encoding
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Initialization

	default_create
			-- Default creation
		do
			create widget

				-- Initialize with unexecutable agent.
			update_scroll_agent := agent do check False end end
			refresh_line_number_agent := agent do check False end end

			initialize
			is_initialized := True
		end

	initialize_buffer_settings
		do
				-- Buffer settings
			set_buffered_drawable_size (default_buffered_drawable_width, default_buffered_drawable_height)
		end

feature {NONE} -- Initialization

	user_initialization
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_margin: like margin
		do
			initialize_buffer_settings

				-- Create the buffered line.
			create buffered_line.make_with_size (buffered_drawable_width, line_height)

				-- First display the first line...
			first_line_displayed := 1
			initialize_editor_context
			text_displayed := new_text_displayed
			register_observers
			panel_manager.add_panel (Current)
			set_current_document_class (default_document_class)
			editor_width := buffered_drawable_width
			main_vbox.set_background_color (editor_preferences.normal_background_color)
			inner_hbox.set_background_color (editor_preferences.normal_background_color)

				-- Create the margin and associate it with `margin_container'.
			create l_margin.make_with_panel (Current)
			margin := l_margin

				-- Enable line number functionality in margin.
			l_margin.enable_line_numbers


			if attached {EV_HORIZONTAL_BOX} margin_container.parent as l_parent then
				l_parent.prune (margin_container)
				margin_container := l_margin.margin_viewport
				l_parent.put_front (margin_container)
				l_parent.disable_item_expand (margin_container)
			else
				check parent_set: False end
			end

			editor_drawing_area.set_minimum_size (buffered_drawable_width, buffered_drawable_height)

				-- Viewport Events
			editor_drawing_area.expose_actions.extend (agent on_repaint)
			editor_drawing_area.resize_actions.extend (agent on_size)
			editor_drawing_area.dpi_changed_actions.extend (agent on_dpi_change)
			editor_drawing_area.mouse_wheel_actions.extend (agent on_mouse_wheel)
			editor_drawing_area.focus_in_actions.extend (agent on_focus)
			editor_viewport.resize_actions.extend (agent on_viewport_size)
			editor_viewport.dpi_changed_actions.extend (agent on_dpi_change_viewport_size)

				-- Scrollbar Events		
			vertical_scrollbar.change_actions.extend (agent on_vertical_scroll)
			horizontal_scrollbar.change_actions.extend (agent on_horizontal_scroll)
			scroll_cell.set_minimum_size (vertical_scrollbar.width, vertical_scrollbar.width)
			update_scroll_agent := agent update_scrollbars_display
			last_vertical_scroll_bar_value := 1
			display_scrollbars := True

				-- Set up the screen.
			buffered_line.set_background_color (editor_preferences.normal_background_color)

				-- Ensure line numbers are displayed
			refresh_line_number_agent := agent refresh_line_number_display
			editor_preferences.show_line_numbers_preference.change_actions.extend (refresh_line_number_agent)
			refresh_line_number_display
		end

	initialize_editor_context
			-- Here initialize editor contextual settings.  For example, set location of cursor
			-- pixmaps.
		do
		end

feature -- Access

	is_initialized: BOOLEAN
			-- Is current text panel properly initialized? I.e. ready for use.

	new_text_displayed: like text_displayed
			-- New instance of `text_displayed' for Current.
		do
			create Result.make
			Result.set_first_read_block_size (number_of_lines_in_block)
			Result.set_userset_data (userset_data)
		ensure
			new_text_not_void: Result /= Void
		end

	register_observers
			-- Register observers for `text_displayed'
		do
			text_displayed.add_lines_observer (Current)
			text_displayed.add_edition_observer (Current)
		end

	text: STRING
			-- Image of the text being displayed.
		obsolete
			"Use `wide_text' instead, or wide characters are truncated. [2017-05-31]"
		do
			Result := wide_text.as_string_8
		end

	wide_text: STRING_32
			-- Image of text in `Current'.
		do
			if text_displayed.is_empty then
				Result := ""
			else
				Result := text_displayed.wide_text
			end
		end

	text_displayed: TEXT
			-- Text currently displayed on the screen.

	file_name: detachable FILE_NAME
			-- Name of the currently opened file, if any.
		obsolete
			"Use `file_path' instead as content could be truncated for Unicode paths. [2017-05-31]"
		do
			if attached file_path as l_path then
				create Result.make_from_string (l_path.name.as_string_8)
			end
		end

	file_path: detachable PATH
			-- Name of the currently opened file, if any.

	size_of_file_when_loaded: INTEGER
			-- Number of bytes in current file when it was loaded.

	date_of_file_when_loaded: INTEGER
			-- Date of current file when it was loaded.

	margin: detachable MARGIN_WIDGET note option: stable attribute end
			-- Margin.

	first_line_displayed: INTEGER
			-- First line currently displayed on the screen.

	flip_count: INTEGER
			-- How many times has the `editor_viewport' been flipped?

	is_checking_modifications: BOOLEAN
			-- Are document modifications being checked?

	cursors: detachable EDITOR_CURSORS note option: stable attribute end
			-- Editor cursors

	icons: detachable EDITOR_ICONS note option: stable attribute end
			-- Editor icons

	encoding: detachable ENCODING
			-- Returns user encoding if `user_encoding' is set by `set_encoding'.
			-- Otherwise returns encodinge valuated when text was loaded.
		do
			if attached user_encoding as l_enc then
				Result := l_enc
			else
				Result := detected_encoding
			end
		end

	display_scrollbars: BOOLEAN assign set_display_scrollbars
			-- Should scrollbars be display automatically?

feature -- Status Setting

	set_cursors (a_cursors: like cursors)
			-- Sets `cursors' with `a_cursors'
		require
			a_cursors_not_void: a_cursors /= Void
		do
			cursors := a_cursors
		ensure
			cursors_set: cursors = a_cursors
		end

	set_icons (a_icons: like icons)
			-- Sets `icons' with `a_icons'
		require
			a_icons_not_void: a_icons /= Void
		do
			icons := a_icons
		ensure
			icons_set: icons = a_icons
		end

	set_text (a_text: like text_displayed; a_filename: STRING)
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
			create file_path.make_from_string (a_filename)
		end

	set_encoding (a_encoding: like user_encoding)
			-- Set `encoding' with `a_encoding'
		do
			user_encoding := a_encoding
		ensure
			encoding_set: user_encoding = a_encoding
		end

	display_line_with_context (l_number: INTEGER)
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

	setup_editor (first_line_to_display: INTEGER)
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
			if attached margin as l_margin then
				l_margin.setup_margin
			else
				check margin_always_attached: False end
			end
		end

	on_focus
			-- Editor received focus
		local

		do
			editor_drawing_area.focus_in_actions.block

			if not is_checking_modifications and file_loaded then
				check_document_modifications_and_reload
			end

			editor_drawing_area.focus_in_actions.resume
		end

	set_left_margin_width (a_width: like left_margin_width)
			-- Set `left_margin_width' with `a_width'.
			-- Set with zero to use preference value.
		do
			internal_left_margin_width := a_width
		end

	set_fonts (a_fonts: like userset_fonts)
			-- Set `userset_font' with `a_font'.
		do
			userset_data.fonts := a_fonts
			buffered_line.set_size (buffered_line.width, line_height)
			update_line_and_token_info
		end

	set_line_height (a_height: like line_height)
			-- Set `userset_font_height'
		do
			userset_data.line_height := a_height
			buffered_line.set_size (buffered_line.width, line_height)
		end

	set_font_offset (a_offset: INTEGER)
			-- Set `font_offset'
		do
			userset_data.font_offset := a_offset
		end

	set_display_scrollbars (a_display: BOOLEAN)
			-- Set `display_scrollbars' with `a_display'.
			-- Show or hide the scrollbars accordingly.
		do
			display_scrollbars := a_display
			if a_display then
				update_horizontal_scrollbar
				update_vertical_scrollbar
			else
				horizontal_scrollbar.hide
				vertical_scrollbar.hide
				scroll_cell.hide
			end
		end

feature -- Query

	file_loaded: BOOLEAN
			-- Has a file been loaded into the text panel?
		do
			Result := attached file_path as l_name and then not l_name.is_empty
		end

	editor_x: INTEGER
			-- editor_viewport absolute position.
		do
			Result := editor_viewport.screen_x
		end

	editor_y: INTEGER
			-- editor_viewport absolute position.
		do
			Result := editor_viewport.screen_y
		end

	has_focus: BOOLEAN
			-- Does the text panel have focus?
		do
			Result := editor_drawing_area.has_focus
		end

	has_margin: BOOLEAN
			-- Should margin be displayed?
		do
			Result := margin /= Void and then margin.is_show_requested
		end

	is_empty: BOOLEAN
			-- Is the text panel blank?
		do
			Result := text_displayed.is_empty
		end

	text_is_fully_loaded: BOOLEAN
			-- Is current text still being loaded?
		do
			Result := text_displayed.reading_text_finished
		end

	line_numbers_visible: BOOLEAN
			-- Are line numbers currently visible
		do
			Result := editor_preferences.show_line_numbers
		end

	view_invisible_symbols: BOOLEAN
			-- Are the spaces, the tabulations and the end_of_line characters visible?			

	is_unix_file: BOOLEAN
			-- Is current file a Unix file? (i.e. is "%N" line separator?)
		do
			Result := not is_windows_file
		end

	is_windows_file: BOOLEAN
			-- Is current file a Windows file? (i.e. is "%R%N" line separator?)
		do
			Result := text_displayed.is_windows_eol_style
		end

	is_in_editor_panel (a_screen_x, a_screen_y: INTEGER): BOOLEAN
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

	number_of_lines: INTEGER
		do
			Result := text_displayed.number_of_lines
		end

	number_of_lines_displayed: INTEGER
			-- Number of lines currently displayed on the screen.	
		do
			Result := viewable_height // line_height
		end

	number_of_lines_displayed_from_text: INTEGER
			-- Number of lines currently displayed on the screen, excluding the white space visible below the actual text.	
		do
			Result := number_of_lines_displayed
			if (first_line_displayed + Result) > text_displayed.number_of_lines then
				Result := text_displayed.number_of_lines - first_line_displayed + 1
			end
		end

	left_margin_width: INTEGER
			-- Width of left margin
		do
			if internal_left_margin_width = 0 then
				Result := editor_preferences.left_margin_width
				if Result < 1 then
					Result := default_left_margin_width
				end
			else
				Result := internal_left_margin_width
			end
		end

	changed: BOOLEAN
			-- Has the content of the editor changed since it was
			-- loaded or saved?
		do
			Result := attached text_displayed as td and then td.is_modified
		end

	line_numbers_enabled: BOOLEAN
			-- Is it permitted to show line numbers in Current?
		do
			Result := margin /= Void and then margin.line_numbers_enabled
		end

	is_offset_valid: BOOLEAN
			-- If viewport offset vaild?
		do
			Result := editor_viewport.y_offset >= 0
		end

	has_icons: BOOLEAN
			-- Has `icons' set?
		do
			Result := icons /= Void
		end

feature -- Pick and Drop

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions performed when user drops a stone on the text_area.
		do
			Result := editor_drawing_area.drop_actions
		end

feature -- File Properties

	date_when_checked: INTEGER
			-- Date of the open file when checked for the latest time

	file_date_already_checked: BOOLEAN
			-- Has the date of the file already been checked?

	file_is_up_to_date: BOOLEAN
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

	set_reference_window (a_window: like reference_window)
			-- Set reference window
		do
			internal_reference_window := a_window
		end

feature -- Status setting

	refresh_line_number_display, refresh_margin
	        -- Refresh margin display in `Current'.
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

	enable_line_numbers
			-- Enable line numbers
		do
			if margin /= Void then
				margin.enable_line_numbers
			end
			refresh_margin
		ensure
			line_numbers_enabled: line_numbers_enabled
		end

	disable_line_numbers
			-- Disable line numbers
		do
			if margin /= Void then
				margin.disable_line_numbers
			end
			refresh_margin
		ensure
			line_numbers_disabled: not line_numbers_enabled
		end

	toggle_view_invisible_symbols
			-- Toggle `view_invisible_symbols'.
		do
			view_invisible_symbols := not view_invisible_symbols
			refresh_now
		ensure
			view_invisible_symbols_set: view_invisible_symbols = not old view_invisible_symbols
		end

	set_focus
			-- Give the focus to the editor area.
		do
			if is_initialized and then not editor_drawing_area.is_destroyed and then editor_drawing_area.is_displayed and then editor_drawing_area.is_sensitive then
				if attached reference_window as l_window then
					if l_window.has_focus then
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

	refresh
			-- Update display.
		do
			in_scroll := True
			update_line_and_token_info
			editor_drawing_area.redraw
			if attached margin as l_margin then
				l_margin.refresh
			else
				check margin_always_attached: False end
			end
		end

	refresh_now
			-- Update display without waiting for next idle
		do
			refresh
			if attached margin as m and then m.is_show_requested then
				m.margin_area.flush
			end
			editor_drawing_area.flush
			in_scroll := False
		end

	clear_window
			-- Wipe out the text area.
		do
			reset
			update_vertical_scrollbar
			update_horizontal_scrollbar
			refresh_now
		end

	reset
			-- Reinitialize `Current' so that it can receive a new content.
		do
				-- First abort our previous actions.
			if attached text_displayed as td then
				td.reset_text
			end
			editor_width := 100
			set_offset (0)
			first_line_displayed := 1
			vertical_scrollbar.set_value (1)
		end

	redraw_current_screen
			-- Redraw the current screen. Do not scroll or move the cursor, just redraw.
		do
			set_first_line_displayed (first_line_displayed, True)
		end

	load_file (a_filename: STRING_32)
			-- Load contents of `a_filename'.
		obsolete
			"Use `load_file_path' instead. [2017-05-31]"
		require
			a_filename_not_void: a_filename /= Void
		do
			load_file_path (create {PATH}.make_from_string (a_filename))
		end

	load_file_path (a_filename: PATH)
			-- Load contents of `a_filename'
		require
			filename_not_void: a_filename /= Void
		local
			l_file: RAW_FILE
			l_doc_type: STRING_32
			l_date: like date_of_file_when_loaded
			l_size: like size_of_file_when_loaded
			s: STRING_32
		do
			editor_drawing_area.disable_sensitive
				-- Check the document type of the file to load.
			s := a_filename.name
			l_doc_type := s.substring (s.last_index_of ('.', s.count) + 1, s.count)
			if l_doc_type /= Void and then known_document_type (l_doc_type) then
				set_current_document_class (get_class_from_type (l_doc_type))
			else
				set_current_document_class (default_document_class)
			end

			create l_file.make_with_path (a_filename)
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
				load_text ({STRING_32} "File: " + a_filename.name + "%Ndoes not exist.")
			end
			create file_path.make_from_string (a_filename.name)
			date_of_file_when_loaded := l_date
			size_of_file_when_loaded := l_size
		end

	load_text (a_text: READABLE_STRING_GENERAL)
			-- Display `a_text'.
			-- `a_text' is not necessarily in UTF-32, it can be specified by `set_encoding'.
		local
			l_line: INTEGER
			l_text: STRING
		do
				-- Reset the editor state
			reset
			l_text := evaluate_encoding_and_convert_to_utf8 (a_text)
			text_displayed.set_is_windows_eol_style (l_text.substring_index ("%R%N", 1) > 0)

			file_loading_setup

				-- Read and parse the file.
			text_displayed.set_first_read_block_size (number_of_lines_in_block)
			text_displayed.load_string (l_text)

				-- Setup the editor to load first page and display proper first line.
			if first_line_displayed > 0 and then first_line_displayed <= number_of_lines then
				l_line := first_line_displayed
			else
				l_line := 1
			end
			setup_editor (l_line)
		end

	on_font_changed
			-- Recompute token information for for loaded text.
		local
			l_line_index: INTEGER
			l_text_displayed: like text_displayed
			n: INTEGER
		do
				-- Recompute token information for loaded text.
			from
				l_text_displayed := text_displayed
				n := l_text_displayed.number_of_lines
				l_line_index := 1
			until
				l_line_index > n
			loop
				l_text_displayed.update_line (l_line_index)
				l_line_index := l_line_index + 1
			end

			buffered_line.set_size (buffered_line.width, line_height)
			update_horizontal_scrollbar
			update_vertical_scrollbar
			if attached margin as l_margin then
				l_margin.on_font_changed
			else
				check margin_always_attached: False end
			end
			redraw_current_screen
		end

	check_document_modifications_and_reload
			-- Check document modifications and reload as necessary.
		require
			not_is_checking_modifications: not is_checking_modifications
			file_loaded: file_loaded
		local
			dialog: EV_INFORMATION_DIALOG
			button_labels: ARRAY [STRING]
			actions: ARRAY [PROCEDURE]
		do
			is_checking_modifications := True

			if not file_exists then
				reload
			elseif not file_is_up_to_date then
				if changed or not editor_preferences.automatic_update then
						-- File has not changed in panel and is not up to date.  However, user does want auto-update so prompt for reload.
					create dialog.make_with_text ("This file has been modified by another editor.")
					create button_labels.make_from_array (<<"Reload", "Continue anyway">>)
					button_labels.rebase (1)
					create actions.make_from_array (<<agent reload, agent continue_editing>>)
					actions.rebase (1)
					dialog.set_buttons_and_actions (button_labels, actions)
					dialog.set_default_push_button (dialog.button (button_labels [1]))
					dialog.set_default_cancel_button (dialog.button (button_labels [2]))
					dialog.set_title ("External edition")
					if attached reference_window as l_window then
						dialog.show_modal_to_window (l_window)
					else
						check False end -- Bug
					end
				elseif editor_preferences.automatic_update and not changed then
					reload
				end
			end

			is_checking_modifications := False
		ensure
			is_checking_modifications_is_false: not is_checking_modifications
		end

	flush
			-- Load texts immediately
		do
			if attached text_displayed as t then
				t.flush
			end
		end

feature -- Graphical interface

	pointer_style: detachable EV_POINTER_STYLE
			-- Pointer style over the text.
		do
			Result := editor_drawing_area.pointer_style
		end

	font: EV_FONT
			-- Font used to display the text
		local
			l_fonts: detachable SPECIAL [EV_FONT]
		do
			l_fonts := userset_data.fonts
			if l_fonts /= Void then
				Result := l_fonts [{EDITOR_TOKEN_TEXT}.editor_font_id]
			else
				Result := editor_preferences.font
			end
		end

	userset_fonts: detachable SPECIAL [EV_FONT]
			-- Font set via `set_font'
		do
			Result := userset_data.fonts
		end

	line_height: INTEGER
			-- Height of lines in pixels
		local
			l_user_data: like userset_data
		do
			l_user_data := userset_data
			if l_user_data.line_height > 0 then
				Result := l_user_data.line_height
			else
				Result := editor_preferences.line_height
			end
		end

	reference_window: detachable EV_WINDOW
			-- Window which error dialogs will be shown relative to. Void if not set using `set_reference_window'.
		do
			Result := internal_reference_window
		end

	show_warning_message (a_message: READABLE_STRING_GENERAL)
			-- Show `a_message' in a dialog window
			-- |Use {READABLE_STRING_GENERAL}, following Vision2 interface.
		local
			wd: EV_WARNING_DIALOG
		do
			create wd.make_with_text (a_message)
			wd.pointer_button_release_actions.extend
				(agent (x, y, button: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32; d: EV_WARNING_DIALOG) do d.destroy end (?, ?, ?, ?, ?, ?, ?, ?, wd))
			wd.key_press_actions.extend (agent (k: EV_KEY; d: EV_WARNING_DIALOG) do d.destroy end (?, wd))
			if attached reference_window as l_window then
				wd.show_modal_to_window (l_window)
			end
		end

feature {MARGIN_WIDGET} -- Private properties of the text window

	offset: INTEGER
			-- Horizontal offset of the display.
		do
			Result := editor_viewport.x_offset
		end

	number_of_lines_in_block: INTEGER
			-- Default number of lines read when loading a text in editor.
		do
			Result := (4 * number_of_lines_displayed).max (1)
		ensure
			number_of_lines_computed_non_negative: Result >= 1
		end

	editor_width: INTEGER
			-- Width of the text. (i.e. minimum width of the panel
			-- for which no scroll bar is needed)

	maximum_top_line_index: INTEGER
			-- Number of the last possible line that can be displayed
			-- at the top of the editor window.
		do
			Result := (text_displayed.number_of_lines - (number_of_lines_displayed // 2)).max (1)
		end

	show_vertical_scrollbar: BOOLEAN
			-- Is it necessary to show the vertical scroll bar?
		do
			Result := text_displayed.number_of_lines > number_of_lines_displayed // 2
		end

	horizontal_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update horizontal
			-- scroll bar display?

	vertical_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update vertical
			-- scroll bar display?

feature -- Status Setting

	set_editor_width (a_width: INTEGER)
			-- If `a_width' is greater than `editor_width', assign `a_width' to `editor_width'
			-- update display if necessary.
		do
			if editor_width < a_width then
				editor_width := a_width
				editor_drawing_area.redraw_rectangle (0, editor_viewport.y_offset, viewable_width, viewable_height)
				update_horizontal_scrollbar
			end
		end

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN)
			-- Assign `fld' to `first_line_displayed'.
		require
			fld_large_enough: fld > 0
			fld_small_enough: fld <= text_displayed.number_of_lines.max (1)
			fld_in_range: vertical_scrollbar.value_range.has (fld)
		do
			first_line_displayed := fld
			vertical_scrollbar.set_value (fld)
		end

	set_offset (an_offset: INTEGER)
			-- Assign `an_offset' to `offset' and update scrollbar if necessary.
		do
			editor_viewport.set_x_offset (an_offset)
			if horizontal_scrollbar.is_show_requested then
				horizontal_scrollbar.set_value (offset.min (horizontal_scrollbar.value_range.upper))
			end
		end

feature {NONE} -- Scroll bars Management

	update_horizontal_scrollbar
			-- Update horizontal scrollbar value range and show it or
			-- hide it if it is not needed.
		local
			w: INTEGER
		do
			if display_scrollbars then
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
			else
				horizontal_scrollbar.hide
				scroll_cell.hide
			end
		end

	update_vertical_scrollbar
			-- Update vertical scrollbar value range.
			-- Show it or hide it depending on what is appropriate.
		do
			if not in_resize then
				in_resize := True

				if display_scrollbars then
					if show_vertical_scrollbar then
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
				else
					vertical_scrollbar.hide
					scroll_cell.hide
				end
				in_resize := False
			end
		end

	update_scroll_cell
			-- Hide or show scroll bar depending on what is appropriate.
		do
			if vertical_scrollbar.is_show_requested and then horizontal_scrollbar.is_show_requested then
				scroll_cell.show
			else
				scroll_cell.hide
			end
		end

	update_scrollbars_display
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
			if attached shared_environment.application then
				ev_application.remove_idle_action (update_scroll_agent)
			end
		end

	update_width
			-- Update `editor_width'
		local
			i: INTEGER
			l_text_displayed: like text_displayed
			n: INTEGER
		do
			from
				l_text_displayed := text_displayed
				n := number_of_lines
				i := 1
			until
				i = n
			loop
				if attached l_text_displayed.line (i) as l_line then
					editor_width := editor_width.max (l_line.width)
				else
					check False end -- Bug
				end
				i := i + 1
			end
		end

	on_vertical_scroll (vscroll_pos: INTEGER)
 			-- Process vertical scroll event. `vertical_scrollbar.value' has changed.
 		local
 			l_bottom_line_y,
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
 				if view_y_offset + (l_diff * l_line_height) < 0 then
 						-- The newly anticipated y_offset (taking into account where we are moving to) is
 						-- above the drawing area, so flip to the bottom
 					editor_viewport.set_y_offset (l_buff_height - viewable_height - ((l_buff_height - viewable_height) \\ l_line_height))
 					flip_count := flip_count - 1
					if attached margin as l_margin then
						l_margin.synch_with_panel
					else
						check margin_always_attached: False end
					end
 					refresh_now
 				else
 					editor_viewport.set_y_offset (view_y_offset + (l_diff * l_line_height))
 					check
 						not_negative: editor_viewport.y_offset >= 0
 					end
					if attached margin as l_margin then
						l_margin.synch_with_panel
					else
						check margin_always_attached: False end
					end
 				end
 			elseif l_diff > 0 then
 					-- Scroll down
 				l_bottom_line_y := viewable_height + view_y_offset + (l_diff * l_line_height)
 				if l_bottom_line_y > l_buff_height then
 					editor_viewport.set_y_offset (0)
 					flip_count := flip_count + 1
					if attached margin as l_margin then
						l_margin.synch_with_panel
					else
						check margin_always_attached: False end
					end
 					refresh_now
 				else
 					editor_viewport.set_y_offset (view_y_offset + (l_diff * l_line_height))
					if attached margin as l_margin then
						l_margin.synch_with_panel
					else
						check margin_always_attached: False end
					end
 				end
 			end
			last_vertical_scroll_bar_value := vscroll_pos

			check
 				not_too_high: editor_viewport.y_offset >= 0
 				not_too_low: (editor_viewport.y_offset + viewable_height) <= buffered_drawable_height
 			end
 		end

 	on_horizontal_scroll (scroll_pos: INTEGER)
 			-- Process horizontal scroll event. `horizontal_scrollbar.value' has changed.
 		do
 			in_scroll := True
			set_offset (scroll_pos)
			buffered_line.set_size ((viewable_width + offset).max (buffered_line.width), line_height)
		end

	on_mouse_wheel (delta: INTEGER)
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

	scrolling_quantum: INTEGER
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

	on_repaint (x, y, a_width, a_height: INTEGER)
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

	on_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER)
			-- Refresh the panel after it has been resized (and moved) to new coordinates (`a_x', `a_y') and
			-- new size (`a_width', `a_height').
			--| Note: This feature is called during the creation of the window
		do
			update_vertical_scrollbar
			update_horizontal_scrollbar
		end

	on_dpi_change (a_dpi: NATURAL_32; a_x, a_y: INTEGER; a_width, a_height: INTEGER)
			-- Refresh the panel after it has been resized (and moved) to new coordinates (`a_x', `a_y') and
			-- new size (`a_width', `a_height').
			--| Note: This feature is called during the creation of the window
		do
			on_size (a_x, a_y, a_width, a_height)
		end

	on_viewport_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER)
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

					-- Note: this call is to process the platform dependent
					-- operations.
				on_visible_area_resized (a_width, a_height)

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

	on_dpi_change_viewport_size (a_dpi: NATURAL_32; a_x, a_y: INTEGER; a_width, a_height: INTEGER)
			-- Viewport was resized.
		do
			on_viewport_size (a_x, a_y, a_width, a_height)
		end

	last_viewport_height: INTEGER

	update_viewport_after_resize
			--
		do
			if editor_viewport.y_offset + viewable_height > buffered_drawable_height then
					-- The viewport needs to be moved up because it is too low down to display
				editor_viewport.set_y_offset (editor_viewport.y_offset - (editor_viewport.height - last_viewport_height))
				if attached margin as l_margin then
					l_margin.margin_viewport.set_y_offset (editor_viewport.y_offset)
				else
					check margin_always_attached: False end
				end
			end
		end

	update_area (x_pos, top, a_width, bottom: INTEGER; x: INTEGER; buffered: BOOLEAN)
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
 			last_line_to_draw := (first_line_displayed + (bottom - view_y_offset) // line_height).min (text_displayed.number_of_lines)

			check
				not_too_many_lines: bottom = top implies first_line_to_draw = last_line_to_draw
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

	update_lines (first, last, start_pos, end_pos: INTEGER; buffered: BOOLEAN)
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
			l_editor_viewport: like editor_viewport
		do
			updating_line := True
			l_text := text_displayed
			if not l_text.is_empty then
				l_text.go_i_th (first)

				if buffered then
					buffered_line.set_background_color (editor_preferences.normal_background_color)
				end

				from
					l_editor_viewport := editor_viewport
	 				curr_line := first
	 			until
	 				curr_line > last or else l_text.after
	 			loop
	 				y_offset := l_editor_viewport.y_offset + (curr_line - first_line_displayed) * line_height

					if buffered then
	 		--			draw_line_to_buffered_line (curr_line, l_text.current_line)
			--			draw_buffered_line_to_screen (0, y_offset)
					else
						if attached l_text.current_line as l_line then
							draw_line_to_screen (start_pos, end_pos, y_offset, l_line)
						else
							check False end -- Not possible according to not `after'.
						end
					end
	 				curr_line := curr_line + 1
	 				l_text.forth
	 			end
			end

 			updating_line := False
		end

	invalidate_block (first, last: INTEGER; flush_screen: BOOLEAN)
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

	draw_buffered_line_to_screen (start_pos, end_pos, x, y: INTEGER)
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

	draw_line_to_screen (start_pos, end_pos, y: INTEGER; a_line: EDITOR_LINE)
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
				check current_is_end_token: attached {EDITOR_TOKEN_EOL}curr_token end
				curr_token.display_with_offset (curr_token.position + left_margin_width, y, da, Current)
			end
		end

 	draw_margin (y: INTEGER)
 			-- Draw the left margin space (not the line margin)
 		do
 			debug ("editor")
				draw_flash (0, y, left_margin_width, line_height, False)
			end
			editor_drawing_area.set_background_color (editor_preferences.normal_background_color)
			editor_drawing_area.clear_rectangle (0, y, left_margin_width, line_height)
 		end

 	draw_flash (x, y, width, height: INTEGER; buffered: BOOLEAN)
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

 	draw_line_to_buffered_line (xline: INTEGER; a_line: EDITOR_LINE)
			-- Draw onto the buffered line the tokens in `a_line'.
		require
			text_is_not_empty: not text_displayed.is_empty
			on_paint: on_paint
 		local
 			curr_token: EDITOR_TOKEN
 		do
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

	invalidate_line (line_number: INTEGER; draw_immediately: BOOLEAN)
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
		end

feature {NONE} -- Text loading

	reload
			-- Reload the opened file from disk.
		do
			if attached file_path as l_name and then not l_name.is_empty then
				load_file_path (l_name)
			end
		end

	on_text_loaded
			-- Finish the panel setup as the entire text has been loaded.
		local
			l_text_displayed: like text_displayed
		do
			editor_width := 0
			from
				l_text_displayed := text_displayed
				l_text_displayed.start
			until
				l_text_displayed.after
			loop
				if attached l_text_displayed.current_line as l_line then
					editor_width := editor_width.max (l_line.width)
				else
					check current_line_attached: False end -- Implied by not `after'.
				end
				l_text_displayed.forth
			end
			if attached margin as l_margin then
				editor_width := editor_width + left_margin_width + l_margin.width
			else
				check margin_always_attached: False end
			end
			set_editor_width (editor_width)
			vertical_scrollbar.enable_sensitive
			update_vertical_scrollbar
			update_horizontal_scrollbar
			editor_drawing_area.enable_sensitive
			refresh
		end

	on_text_block_loaded (was_first_block: BOOLEAN)
			-- Update scroll bar as a new block of text as been loaded.
		do
			update_vertical_scrollbar
		end

	on_text_fully_loaded
			-- Text has been fully loaded
		do
			if internal_focus_requested then
				set_focus
				internal_focus_requested := False
			end
		end

	file_loading_setup
			-- Setup before file loading
		do
		end

feature {MARGIN} -- Implementation

	in_resize: BOOLEAN
			-- Are we a call to on_resize that was not triggered by the function itself.

	update_scroll_agent: PROCEDURE
			-- Agent for scrollbar display updates.

	platform_is_windows: BOOLEAN
			-- Is windows the current platform?
		once
			Result := (create {PLATFORM}).is_windows
		end

	updating_line: BOOLEAN
			-- Is buffered line currently being updated?

	default_left_margin_width: INTEGER = 10
			-- Default width of left margin

	internal_reference_window: like reference_window
			-- Window which error dialogs will be shown relative to.		

	right_buffer_width: INTEGER = 50

	internal_left_margin_width: like left_margin_width
			-- Saved user set left margin width

feature {EDITOR_TOKEN} -- User set data

	userset_data: TEXT_PANEL_BUFFERED_DATA
			-- Userset editor data
		local
			l_data: like internal_userset_data
		do
			l_data := internal_userset_data
			if l_data = Void then
				create l_data
				Result := l_data
				internal_userset_data := l_data
			else
				Result := l_data
			end
		ensure
			userset_data_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	refresh_line_number_agent: PROCEDURE
			-- Agent called when `show_line_numbers' preferences is changed.

feature -- Memory management

	recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
				-- Cannot use current anymore.
			is_initialized := False

			ev_application.remove_idle_action (update_scroll_agent)

				-- Remove `refresh_line_number_agent' from `change_actions' for `show_line_numbers'.
			editor_preferences.show_line_numbers_preference.change_actions.prune_all (refresh_line_number_agent)
			refresh_line_number_agent := agent do end

				-- Reset scrolling agent.
			update_scroll_agent := agent do end

			editor_drawing_area.destroy
			create editor_drawing_area	-- Detach original instance to help memory management.

			if margin /= Void then
				margin.destroy
			end
			scroll_cell.destroy
			create scroll_cell
			horizontal_scrollbar.destroy
			create horizontal_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (1, 1))
			vertical_scrollbar.destroy
			create vertical_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (1, 1))
			text_displayed.recycle
			create text_displayed.make
			editor_viewport.destroy
			create editor_viewport
			panel_manager.remove_panel (Current)
		ensure
			not_initialized: not is_initialized
		end

feature -- Implementation

	buffered_line: EV_PIXMAP
			-- Buffer large enough to hold line information.

	buffered_drawable_width: INTEGER
		-- Default size of `drawable' used for scrolling purposes.

	buffered_drawable_height: INTEGER
		-- Default size of `drawable' used for scrolling purposes.

	set_buffered_drawable_size (a_width, a_height: INTEGER)
			-- Set `buffered_drawable_width` and `buffered_drawable_height` to `a_width` and `a_height`.
		do
			buffered_drawable_width := a_width
			buffered_drawable_height := a_height
		end

	last_vertical_scroll_bar_value: INTEGER
		-- Last value of `vertical_scroll_bar' used within `vertical_scroll_bar_changed'. See
		-- comment of `last_horizontal_scroll_bar_value' for details of it's use.

	viewable_width: INTEGER
			-- Width of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars.
		do
			Result := editor_viewport.width
		end

	viewable_height: INTEGER
			-- Height of `Current' available to view displayed items. Does
			-- not include width of any displayed scroll bars and/or header if shown.
		do
			Result := editor_viewport.height
		end

	on_paint: BOOLEAN

	internal_focus_requested: BOOLEAN
		-- Should give focus after text has been fully loaded?

	common_line_count: INTEGER
			-- Number of lines in common when performing a page down/page up operation.
		do
			Result := editor_preferences.scrolling_common_line_count
		end

	file_date_ticks: INTEGER
			-- Retrieve file last modified date in the number of ticks
		require
			file_loaded: file_loaded
			file_exists: file_exists
		do
			if attached file_path as l_name then
				Result := (create {RAW_FILE}.make_with_path (l_name)).date
			end
		end

	file_size: INTEGER
			-- Retrieve file count
		require
			file_loaded: file_loaded
			file_exists: file_exists
		do
			if attached file_path as l_name then
				Result := (create {RAW_FILE}.make_with_path (l_name)).count
			end
		end

	file_exists: BOOLEAN
			-- Does file exist?
		require
			file_loaded: file_loaded
		do
			if attached file_path as l_name then
				Result := (create {RAW_FILE}.make_with_path (l_name)).exists
			end
		end

	continue_editing
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

	internal_userset_data: detachable like userset_data
			-- Buffered userset data

	update_line_and_token_info
			-- Update all tokens for correct width.
		local
			l_text: like text_displayed
			l_line: detachable EDITOR_LINE
		do
			l_text := text_displayed
			if not l_text.is_empty then
				from
					l_text.start
	 			until
	 				l_text.after
	 			loop
	 				l_line := l_text.current_line
	 				check l_line /= Void end -- Implied by not `after'
					if l_line.userset_data /= userset_data then
						l_line.set_userset_data (userset_data)
						l_line.update_token_information
					end
	 				l_text.forth
	 			end
			end
		end

feature {NONE} -- Implementation

	line_type: EDITOR_LINE
			-- Type of a line.
		require
			False
		do
			check from_precondition: False then end
		ensure
			False
		end

	cursor_type: TEXT_CURSOR
			-- Type of a cursor.
		require
			False
		do
			check from_precondition: False then end
		ensure
			False
		end

feature {NONE} -- Encoding conversion

	user_encoding: detachable ENCODING
			-- User set encoding of the text

	detected_encoding: detachable ENCODING
			-- Detected encoding of the text loaded
			-- `user_encoding' takes higher priority.

	evaluate_encoding_and_convert_to_utf8 (a_string: READABLE_STRING_GENERAL): STRING
			-- Convert `a_string' as `user_encoding' to UTF-8.
			-- If `user_encoding' is not set,
			-- evaluate encoding of `a_string', set `detected_encoding' and
			-- convert it to UTF-8.
			-- If conversion fails, `a_string' is simply convert to STRING_8
		require
			a_string_not_void: a_string /= Void
		local
			l_str: detachable READABLE_STRING_GENERAL
			l_encoding: detachable ENCODING
		do
			if not attached user_encoding as l_encod then
				encoding_detector.detect (a_string)
				if encoding_detector.last_detection_successful then
					l_encoding := encoding_detector.detected_encoding
					if encoding_detector.last_detection_successful then
						detected_encoding := l_encoding
					end
				end
			else
				l_encoding := l_encod
			end
			if l_encoding /= Void then
				l_encoding.convert_to (utf8, a_string)
				if l_encoding.last_conversion_successful then
					l_str := l_encoding.last_converted_string
				end
			end
			Result :=
				if attached l_str then
					l_str.to_string_8
				elseif attached {READABLE_STRING_8} a_string as s then
					s.string
				else
					{UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_string.as_string_32)
				end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Encoding detector

	encoding_detector: ENCODING_DETECTOR
			-- Encoding detector.
			-- Used to detect/decide what encoding should be used.
		do
			if current_class_set and then attached current_class.encoding_detector as l_detector then
				Result := l_detector
			else
				Result := Current
			end
		ensure
			encoding_detector_not_void: Result /= Void
		end

	default_encoding: ENCODING
			-- <Precursor>
		once
			Result := system_encoding
		end

	detect (a_string: READABLE_STRING_GENERAL)
			-- <Precursor>
			-- Current is used as a simple encoding detector
			-- that returns `system_encoding`.
			-- So, `last_detection_successful` is always true.
		do
			last_detection_successful := True
		end

invariant
	offset_view: is_initialized implies is_offset_valid
	buffered_line_not_void: is_initialized implies buffered_line /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
