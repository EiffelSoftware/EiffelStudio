indexing
	description: "[		
		Editable: no
		Scroll bars: yes
		Cursor: no
		Keyboard: no
		Mouse: no
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
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
			on_text_block_loaded		
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
		redefine
			is_equal
		end

feature -- Initialization

	default_create is
			-- Default creation
		do
			create widget
			initialize
		end		

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do	
				-- First display the first line...
			first_line_displayed := 1
			
			panel_manager.add_panel (Current)
			initialize_editor_context
		
			text_displayed := new_text_displayed

			set_current_document_class (default_document_class)
			editor_width := 100
			offset := 0
			
			create margin.make_with_panel (Current)

			editor_area.expose_actions.extend (agent on_repaint)
			editor_area.resize_actions.extend (agent on_size)
			editor_area.mouse_wheel_actions.extend (agent on_mouse_wheel)	
			editor_area.focus_in_actions.extend (agent on_focus)
				
				-- Scrollbars			
			vertical_scrollbar.change_actions.extend (agent on_vertical_scroll)
			horizontal_scrollbar.change_actions.extend (agent on_horizontal_scroll)
			scroll_cell.set_minimum_size (vertical_scrollbar.width, vertical_scrollbar.width)

			update_scroll_agent := agent update_scrollbars_display
			
			main_vbox.set_background_color (editor_preferences.normal_background_color)
			inner_hbox.set_background_color (editor_preferences.normal_background_color)			

			----------------------------
			-- General initialisation --
			----------------------------

				-- Compute Font related constants.
			number_of_lines_displayed := editor_area.height // line_height

				-- Set up the screen.
			create buffered_screen.make_with_size (editor_area.width, corrected_buffered_screen_height (editor_area.height))
			buffered_screen.set_background_color (editor_preferences.normal_background_color)
			create left_margin_buffered_screen.make_with_size (left_margin_width, editor_area.height)														
		end

	initialize_editor_context is
			-- Here initialize editor contextual settings.  For example, set location of cursor
			-- pixmaps.
		deferred
		end		

feature -- Access

	new_text_displayed: like text_displayed is
			-- New instance of `text_displayed' for Current.
		do
			create Result.make
			Result.add_lines_observer (Current)
			Result.add_edition_observer (Current)
			Result.set_first_read_block_size (number_of_lines_displayed)
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

	date_of_file_when_loaded: INTEGER
			-- Date of current file when it was loaded	
		
	margin: MARGIN_WIDGET
			-- Margin
		
	first_line_displayed: INTEGER
			-- First line currently displayed on the screen.	
		
feature -- Status Setting

	set_text (a_text: TEXT) is
			-- Set `text_displayed' to `text'
		require
			text_not_void: a_text /= Void
		do		
			text_displayed := a_text			
		end		
		
	display_line_with_context (l_number: INTEGER) is
			-- display line number `l_number' in the editor
			-- center display on this line if it is not yet displayed
			-- scroll otherwise
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
		do
			first_line_displayed := first_line_to_display
			vertical_scrollbar.set_value (1)

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
				
feature -- Query

	editor_x: INTEGER
			-- Editor_area absolute position.
	
	editor_y: INTEGER
			-- Editor_area absolute position.
	
	has_focus: BOOLEAN is
			-- Does the text panel have focus ?
		do
			Result := editor_area.has_focus
		end

	is_empty: BOOLEAN is
			-- Is the text panel blank ?
		do
			Result := text_displayed.is_empty
		end

	text_is_fully_loaded: BOOLEAN is
			-- Is current text still being loaded ?
		do
			Result := text_displayed.reading_text_finished
		end

	line_numbers_visible: BOOLEAN
			-- Are line numbers currently visible
		
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
						a_screen_x < editor_x + editor_area.width
							and then
						a_screen_y > editor_y
							and then
						a_screen_y < editor_y + editor_area.height
		end
	
	number_of_lines: INTEGER is
		do
			Result := text_displayed.number_of_lines
		end

	left_margin_width: INTEGER is
			-- Width in pixel of the margin on the left of the screen.
		do
			Result := default_left_margin_width
		end

feature -- Pick and Drop

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions performed when user drops a stone on the text_area.
		do
			Result := editor_area.drop_actions
		end	

feature -- File Properties

	date_when_checked: INTEGER
			-- Date of the open file when checked for the latest time

	file_is_up_to_date: BOOLEAN is
			-- Is the open file up to date?
		local
			file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				Result := True
				if file_name /= Void then
					create file.make (file_name)
					if file /= Void and then file.exists and then date_of_file_when_loaded /= 0 then
						Result := date_of_file_when_loaded = file.date
					end
				end
			else
				Result := True
			end			
		rescue
			retried := True
			retry
		end

	file_date_already_checked: BOOLEAN is
			-- Have we already checked the date ?
		local
			file: RAW_FILE
		do
			Result := True
			if file_name /= Void then
				create file.make (file_name)
				Result := file.date = date_when_checked
				date_when_checked := file.date
			end
		end

	set_reference_window (a_window: like reference_window) is
			-- Set reference window
		do
			internal_reference_window := a_window
		end

feature -- Status setting
		
	toggle_line_number_display is
	        -- Toggle line number display in Current and update display
	   	do
	   	 	line_numbers_visible := not line_numbers_visible
	   	 	if line_numbers_visible and then margin_cell.is_empty then
	   	 		margin_cell.put (margin.widget)
	   	 	elseif not line_numbers_visible and then not margin_cell.is_empty then	   	 		
	   	 		margin_cell.prune (margin.widget)
	   	 	end
	   	   	refresh_now
	   	ensure
	   		widget_displayed: line_numbers_visible implies not margin_cell.is_empty
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
			if editor_area.is_displayed then
				editor_area.set_focus
			end
		end
	
feature -- Basic Operations

	refresh is
			-- Update display.
		do
			if left_margin_buffered_screen.width /= left_margin_width then
				left_margin_buffered_screen.set_size (left_margin_width, editor_area.height)
			end
			editor_area.redraw			
			margin.refresh
		end

	refresh_now is
			-- Update display without waiting for next idle
		do
			refresh
			editor_area.flush
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
			-- Redraw the current screen.  Do not scroll or move the cursor, just redraw.
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
  	   	do
  	   		editor_area.disable_sensitive
  	   			-- Check the document type of the file to load.
  	   		l_doc_type := a_filename.substring (a_filename.last_index_of ('.', a_filename.count) + 1, a_filename.count)
  	   		if l_doc_type /= Void and then known_document_type (l_doc_type) then
				set_current_document_class (registered_document_types.item (l_doc_type))
			else
			    set_current_document_class (default_document_class)
  	   		end
  	   		
  	   		create l_file.make (a_filename)
  	   		if l_file.exists then
  	   		    l_file.open_read
  	   		    if l_file.is_empty then
  	   		    	load_text ("")	
  	   		    else  	   		    	
	  	   		    l_file.read_stream (l_file.count)
	  	   		    load_text (l_file.last_string)	
  	   		    end
  	   		    l_file.close
  	   		    create file_name.make_from_string (a_filename)
  	   		    date_of_file_when_loaded := l_file.date
  	   		else
  	   			reset
  	   			load_text ("")
  	   		end
  	  	end
		
	load_text (s: STRING) is
			-- Display `s'.			
		do
				-- Reset the editor state
			reset

			is_unix_file :=	s.substring_index ("%R%N", 1) = 0
			if not is_unix_file then
				s.replace_substring_all ("%R%N", "%N")
			end

			file_loading_setup

				-- Read and parse the file.
			text_displayed.set_first_read_block_size (number_of_lines_displayed)
			text_displayed.load_string (s)

				-- Setup the editor to load first page
			setup_editor (1)
		end	
			
	reload_text is
			-- Recompute token informationfor for loaded text.
		local
			l_line: EDITOR_LINE
			l_line_index: INTEGER
		do
			from
				l_line_index := 1
			until
				l_line_index > text_displayed.number_of_lines
			loop
				text_displayed.update_line (l_line_index)
				l_line_index := l_line_index + 1
			end			
			redraw_current_screen
		end		
			
feature -- Graphical interface

	pointer_style: EV_CURSOR is
			-- Pointer style over the text.
		do
			Result := editor_area.pointer_style
		end

	buffered_screen: EV_PIXMAP
			-- Buffer containing the current displayed screen.

	left_margin_buffered_screen: EDITOR_BUFFERED_SCREEN
			-- Buffer containing the current displayed left margin.  This is the margin area IN THE EDITOR, not
			-- the actual margin widget.

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
			-- Window which error dialogs will be shown relative to.		
		deferred
		end

	show_warning_message (a_message: STRING) is
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

	offset: INTEGER
			-- Horizontal offset of the display.
	
	number_of_lines_displayed: INTEGER
			-- Number of lines currently displayed on the screen.	

	editor_width: INTEGER
			-- Width of the text. (i.e. minimum width of the panel
			-- for which no scroll bar is needed)

	maximum_top_line_index: INTEGER is
			-- Number of the last possible line that can be displayed
			-- at the top of the editor window.
		do
			Result := (text_displayed.number_of_lines - number_of_lines_displayed + 1).max (1)
		end

	show_vertical_scrollbar: BOOLEAN is
			-- Is it necessary to show the vertical scroll bar ?
		do
			Result := text_displayed /= Void and then (number_of_lines_displayed < text_displayed.number_of_lines)
		end

	horizontal_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update horizontal
			-- scroll bar display ?

	vertical_scrollbar_needs_updating: BOOLEAN
			-- Is it necessary to update vertical
			-- scroll bar display ?

	display_margin: BOOLEAN
			-- Should margin be displayed?	
	
	corrected_buffered_screen_height (a_height: INTEGER): INTEGER is
			-- Takes `a_height' and calculates correct height which won't include half-lines.  Used to set buffered screen
			-- height and avoid half-line buffering which can cause problems with anti-aliasing.
		local
			l_remaining: INTEGER
		do		
			l_remaining := line_modulo (a_height)
			if l_remaining = line_height then
				Result := a_height
			else
				Result := a_height + l_remaining
			end
		end
		
	line_modulo (a_height: INTEGER): INTEGER is
			-- Number of pixels of bottom displayed line that are out of view.
		do		
			Result := line_height - (a_height - (a_height - a_height \\ line_height))
		end	

feature -- Status Setting

	set_editor_width (a_width: INTEGER) is
			-- If `a_width' is greater than `editor_width', assign `a_width' to `editor_width'
			-- update display if necessary.
		do
			editor_width := a_width.max (editor_width) + right_buffer_width
			if editor_width > buffered_screen.width then
				buffered_screen.set_size (editor_width, corrected_buffered_screen_height (editor_area.height))
				update_buffered_screen (0, editor_area.height)
				update_horizontal_scrollbar
				update_display
			end
		end

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN) is
			-- Assign `fld' to `first_line_displayed'.
		require
			fld_large_enough: fld > 0
			fld_small_enough: fld <= text_displayed.number_of_lines.max (1)
		local
			diff, y_offset, prev_line: INTEGER
			zone: EV_RECTANGLE
		do			
			prev_line := first_line_displayed
			diff := fld - first_line_displayed
			first_line_displayed := fld					
			if diff.abs < number_of_lines_displayed then
				if diff < 0 then
						-- Scrolling up
					y_offset := buffered_screen.height + diff * line_height
					create zone.make (0, 0, buffered_screen.width, y_offset)
					buffered_screen.draw_sub_pixmap (0, - diff * line_height, buffered_screen, zone)
					create zone.make (0, 0, left_margin_width, y_offset)
					left_margin_buffered_screen.draw_sub_pixmap (0, - diff * line_height, left_margin_buffered_screen, zone)
					update_buffered_screen (0, - diff * line_height)
				elseif diff >= 0 then						
						-- Scrolling down							
					y_offset := diff * line_height
					create zone.make (0, y_offset, buffered_screen.width, buffered_screen.height)
					buffered_screen.draw_sub_pixmap (0, 0, buffered_screen, zone)
					create zone.make (0, y_offset, left_margin_width, left_margin_buffered_screen.height)
					left_margin_buffered_screen.draw_sub_pixmap (0, 0, left_margin_buffered_screen, zone)
					update_buffered_screen (buffered_screen.height - y_offset - line_modulo (buffered_screen.height), y_offset + buffered_screen.height)
				end
				update_display
			else
				editor_area.redraw
			end					
				-- Setup the new vertical position.
			vertical_scrollbar.set_value (first_line_displayed)
			margin.synchronize_with_text_panel (prev_line)			
		end

	set_offset (an_offset: INTEGER) is
			-- Assign `an_offset' to `offset' and update scrollbar if necessary.
		do	
			offset := an_offset
			update_display
			check
				offset_within_bounds: horizontal_scrollbar.value_range.has (an_offset)
			end
			if horizontal_scrollbar.is_show_requested then
				horizontal_scrollbar.set_value (offset)
			end
		end

feature {NONE} -- Scroll bars Management

	update_horizontal_scrollbar is
			-- Update horizontal scrollbar value range and show it or
			-- hide it if it is not needed.
		local
			w: INTEGER
		do
			w := editor_area.width
			if editor_width > w and then text_displayed /= Void then
				horizontal_scrollbar.value_range.resize_exactly (0, editor_width - w)
				horizontal_scrollbar.set_leap (w)
				if horizontal_scrollbar.is_show_requested then 
					if not platform_is_windows then
						horizontal_scrollbar_needs_updating := False
					end
				else
					horizontal_scrollbar.show
					horizontal_scrollbar_needs_updating := True
					if not ev_application.idle_actions.has (update_scroll_agent) then
						ev_application.idle_actions.extend (update_scroll_agent)
					end
				end
			elseif horizontal_scrollbar.is_show_requested then
				horizontal_scrollbar.value_range.resize_exactly (0, 1)
				horizontal_scrollbar.set_leap (1)
				horizontal_scrollbar.hide
				horizontal_scrollbar_needs_updating := True
				set_offset (0)
				if not ev_application.idle_actions.has (update_scroll_agent) then
					ev_application.idle_actions.extend (update_scroll_agent)
				end
			elseif horizontal_scrollbar_needs_updating and then not platform_is_windows then
				horizontal_scrollbar_needs_updating := False
			end
			update_scroll_cell
		end

	update_vertical_scrollbar is
			-- Update vertical scrollbar value range.
			-- Show it or hide it depending on what is appropriate.
		local
			nol: INTEGER
		do
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
					if not ev_application.idle_actions.has (update_scroll_agent) then
						ev_application.idle_actions.extend (update_scroll_agent)
					end
				end
			elseif scroll_vbox.is_show_requested then
				scroll_vbox.hide
				vertical_scrollbar_needs_updating := True
				if not ev_application.idle_actions.has (update_scroll_agent) then
					ev_application.idle_actions.extend (update_scroll_agent)
				end
			elseif vertical_scrollbar_needs_updating and then not platform_is_windows then
				vertical_scrollbar_needs_updating := False
			end
			update_scroll_cell
		end

	update_scroll_cell is
			-- Hide or show scroll bar depending on what is appropriate.
		do
			if
				vertical_scrollbar.is_show_requested 
				and then
				horizontal_scrollbar.is_show_requested
			then
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
			if ev_application.idle_actions.has (update_scroll_agent) then
				ev_application.idle_actions.prune_all (update_scroll_agent)
			end			
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
 			vscroll_inc: INTEGER
 		do 							
				-- Compute the first line to be displayed
			vscroll_inc := (vscroll_pos.min (text_displayed.number_of_lines)).max (1) - first_line_displayed
			
			set_first_line_displayed (first_line_displayed + vscroll_inc, True)			
 		end

 	on_horizontal_scroll (scroll_pos: INTEGER) is
 			-- Process horizontal scroll event. `horizontal_scrollbar.value' has changed.
 		do
			offset := scroll_pos
			update_display
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
			set_first_line_displayed (l_offset, True)
		end

	scrolling_quantum: INTEGER is
			-- Number of lines to scroll per mouse wheel scroll increment.
		do
			if editor_preferences.mouse_wheel_scroll_full_page then
				Result := number_of_lines_displayed - 2
			else
				Result := editor_preferences.mouse_wheel_scroll_size
			end
		end

feature {NONE} -- Display functions

	on_repaint (x, y, a_width, a_height: INTEGER) is
			-- Repaint the part of the panel between in the rectangle between
			-- (`x', `y') and (`x' + `a_width', `y' + `a_height').
			--| Actually, rectangle defined by (0, y) -> (editor_area.width, y + height) is redrawn.
		do
			if a_width /= 0 and a_height /= 0 then
				update_buffered_screen (y, y + a_height)
				update_display				
			end
		end

	on_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER) is
			-- Refresh the panel after it has been resized (and moved) to new coordinates (`a_x', `a_y') and
			-- new size (`a_width', `a_height'). 
			--| Note: This feature is called during the creation of the window
		local
			fld: INTEGER
			old_height: INTEGER
			w,h: INTEGER
		do
				-- Resize & redraw the buffered screen.
			if buffered_screen /= Void then -- System initialized.
				in_resize := True
				number_of_lines_displayed := a_height // line_height
				fld := maximum_top_line_index
				if fld <= 0 then
					first_line_displayed := 1
				else
					first_line_displayed := first_line_displayed.min (fld)
				end
				offset := offset.min (editor_width - a_width).max (0)

				update_vertical_scrollbar
				update_horizontal_scrollbar

				if buffered_screen.width + left_margin_width < a_width then
					if in_resize then
						w := editor_width.max (a_width - left_margin_width)
						h := a_height.max (1)
					else
						w := editor_width.max (a_width - left_margin_width).max (buffered_screen.width)
						h := a_height.max (1).max (h)
					end
					buffered_screen.set_size (w, corrected_buffered_screen_height (h))
					left_margin_buffered_screen.set_size (left_margin_width, h)
					update_buffered_screen (0, h)
				else
					old_height := buffered_screen.height
					if in_resize then
						w := editor_width.max (editor_area.width - left_margin_width)
						h := a_height.max (1)
					else
						w := editor_width.max (editor_area.width - left_margin_width).max (buffered_screen.width)
						h := a_height.max (1).max (buffered_screen.height)
					end
					buffered_screen.set_size (w, corrected_buffered_screen_height (h))
					left_margin_buffered_screen.set_size (left_margin_width, h)
					if old_height < a_height then
						update_buffered_screen (old_height - 1, h)
					end
				end
				in_resize := False
			end
		end	

	update_buffered_screen (top: INTEGER; bottom: INTEGER) is
 			-- Update buffered pixmap between area `top' and `bottom'.
 		local
 			curr_line			: INTEGER
 			first_line_to_draw	: INTEGER
 			last_line_to_draw	: INTEGER
 			curr_y				: INTEGER
 		do
 			updating_screen := True
			buffered_screen.set_background_color (editor_preferences.normal_background_color)
			buffered_screen.clear_rectangle (0, top, buffered_screen.width, bottom - top)
			left_margin_buffered_screen.set_background_color (editor_preferences.normal_background_color)
			left_margin_buffered_screen.clear_rectangle (0, top, left_margin_width, bottom - top)

 				-- Draw all lines
 			first_line_to_draw := (first_line_displayed + top // line_height).max (1)
 			last_line_to_draw := (first_line_displayed + (bottom - 1) // line_height).min (text_displayed.number_of_lines)
 			curr_y := top
 
 			if first_line_to_draw <= last_line_to_draw then
 				text_displayed.go_i_th (first_line_to_draw)
 				from
 					curr_line := first_line_to_draw
 				until
 					curr_line > last_line_to_draw or else
 					text_displayed.after
 				loop
 					display_line (curr_line, text_displayed.current_line)
 					curr_line := curr_line + 1
 					text_displayed.forth
 				end
 
 				curr_y := (curr_line - first_line_displayed) * line_height
 			end
 			if curr_y < bottom then
 				-- The file is too small for the screen, so we fill in the
 				-- last portion of the screen.
				buffered_screen.set_background_color (editor_preferences.normal_background_color)
				buffered_screen.clear_rectangle (0, curr_y, editor_width, (bottom - curr_y))
 			end 			
 			updating_screen := False
 		end		

	update_display is
			-- Update display by drawing the buffered pixmap on `editor_area'.
		do		
			if offset >= left_margin_width then
				editor_area.draw_sub_pixmap (
					0,
					0,
					buffered_screen,
					create {EV_RECTANGLE}.make (
						offset - left_margin_width,
						0,
						editor_area.width + offset - left_margin_width,
						buffered_screen.height)	
					)
			else
				editor_area.draw_sub_pixmap (
					0,
					0,
					left_margin_buffered_screen,
					create {EV_RECTANGLE}.make (
						offset,
						0,
						left_margin_width - offset,
						left_margin_buffered_screen.height
					)
				)
				editor_area.draw_sub_pixmap (
					left_margin_width - offset,
					0,
					buffered_screen,
					create {EV_RECTANGLE}.make (
						0,
						0,
						editor_area.width,
						buffered_screen.height
					)
				)
			end
		end
 
 	display_line (xline: INTEGER; a_line: EDITOR_LINE) is
 			-- Display `a_line' on the buffered screen.
		require
			text_is_not_empty: not text_displayed.is_empty
 		local
 			curr_token	: EDITOR_TOKEN
 			curr_y		: INTEGER
 		do
   			curr_y := (xline - first_line_displayed) * line_height
  			from				
				a_line.start				
				curr_token := a_line.item
 			until
 				a_line.after or else curr_token = a_line.eol_token or else curr_token.position > editor_width
 			loop
					-- Normally Display the token.
				if not curr_token.is_margin_token then					
					curr_token.display (curr_y, buffered_screen, Current)	
				end

					-- Prepare next iteration
				a_line.forth
				curr_token := a_line.item
			end

			if curr_token.position < editor_width then
					-- Display the end token
				curr_token := a_line.eol_token
				a_line.eol_token.display_end_token_normal (curr_y, buffered_screen,buffered_screen.width, Current)
			end
		end

	invalidate_block (a_first_line, a_last_line: INTEGER) is
			-- Redraw lines with numbers between `first_line' and `last_line' on the buffered screen.
		local
			lower_bound, upper_bound: INTEGER
			line_up: INTEGER
		do
			lower_bound := a_first_line.max (first_line_displayed)
			upper_bound := a_last_line.min (first_line_displayed + number_of_lines_displayed)
			if upper_bound >= lower_bound then				
				line_up := (lower_bound - first_line_displayed) * line_height			
				editor_area.redraw_rectangle (0, line_up, editor_area.width, (upper_bound - lower_bound + 1) * line_height)
				editor_area.flush
			end
		end

	invalidate_line (line_number: INTEGER; flush_screen: BOOLEAN) is
			-- Set the line `line_number' to be redrawn.
			-- Redraw immediately if `flush' is set.
		local
			line_up: INTEGER
		do
  				-- Invalidate old cursor location.
			if line_number >= first_line_displayed and then line_number <= first_line_displayed + number_of_lines_displayed then		
				line_up := (line_number - first_line_displayed) * line_height
				editor_area.redraw_rectangle (0, line_up, editor_area.width, line_height)
			end
			if flush_screen then
				editor_area.flush
			end
		end	

feature {NONE} -- Text loading

	reload is
			-- Reload the opened file from disk.
		do
			if file_name /= Void and then not file_name.is_empty then
				load_file (file_name)
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

			refresh_now
			editor_area.enable_sensitive
		end

	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Update scroll bar as a new block of text as been loaded.
		do
			update_vertical_scrollbar
		end

	on_focus is
			-- Editor received focus
		do
			if editor_preferences.automatic_update and then not file_is_up_to_date and then not file_date_already_checked then
				reload
			end			
		end		

	file_loading_setup is
			-- Setup before file loading
		do			
		end		

feature {MARGIN} -- Implementation

	in_resize: BOOLEAN
			-- Are we a call to on_resize that was not triggered by the function itself.

	ev_application: EV_APPLICATION is
			-- Current application.
		once
			Result := (create {EV_ENVIRONMENT}).application
		end

	update_scroll_agent: PROCEDURE [like Current, TUPLE]
			-- Agent for scrollbar display updates.

	platform_is_windows: BOOLEAN is
			-- Is windows the current platform?
		once
			Result := (create {PLATFORM}).is_windows
		end
		
	updating_screen: BOOLEAN
			-- Is buffered screen currently being updated?

	default_left_margin_width: INTEGER is 10
			-- Default width of left margin

	internal_reference_window: like reference_window
			-- Window which error dialogs will be shown relative to.		

	right_buffer_width: INTEGER is 50

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if ev_application.idle_actions.has (update_scroll_agent) then
				ev_application.idle_actions.prune_all (update_scroll_agent)
			end
			update_scroll_agent := Void
			
			if editor_area /= Void then
				editor_area.destroy
				editor_area := Void
			end
			if margin /= Void then
				margin.destroy
				margin := Void
			end
			if scroll_cell /= Void then
				scroll_cell.destroy
				scroll_cell := Void
			end
			if vertical_scrollbar /= Void then
				vertical_scrollbar.destroy
				vertical_scrollbar := Void
			end
			if left_margin_buffered_screen /= Void then
				left_margin_buffered_screen.destroy
				left_margin_buffered_screen := Void
			end
			if update_scroll_agent /= Void then
				update_scroll_agent := Void
			end
			if text_displayed /= Void then
				text_displayed.recycle
				text_displayed := Void
			end
		end

invariant
--	text_displayed_exists: text_displayed /= Void
--	first_line_number_is_valid: first_line_displayed > 0 and then first_line_displayed <= maximum_top_line_index

end -- class TEXT_PANEL
