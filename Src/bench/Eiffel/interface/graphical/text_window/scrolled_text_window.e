indexing
	description: "Notion of a text of some tool. Widget that is able %
				%to edit text."
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLED_TEXT_WINDOW 

inherit
	SCROLLED_T
		rename
			cursor as widget_cursor,
			lower as lower_window
		undefine
			is_equal, copy
		redefine
			make,
			set_cursor_position,
			set_text,
			set_top_character_position,
			set_background_color
		end

	CLICK_WINDOW
		rename
			hole_target as source,
			count as array_count,
			text_count as count,
			widget as source
		redefine
			clear_window,
			display, 
			update_before_transport,
			initial_coord,
			update_after_transport,
			set_font_to_default
		end

	SHARED_APPLICATION_EXECUTION
		undefine
			is_equal, copy
		end

	WIDGET_ROUTINES
		undefine
			is_equal, copy
		end

	EB_CONSTANTS
		undefine
			is_equal, copy
		end

creation
	make,
	make_from_tool

feature -- Initialization

	make_from_tool (a_name: STRING; form: COMPOSITE; a_tool: TOOL_W) is
			-- Initialize text window with name `a_name', parent `a_parent',
			-- and tool window `a_tool'.
		require
			valid_tool: a_tool /= Void and then a_tool.global_form /= Void
		do
			make (a_name, form)
			a_tool.init_modify_action (Current)
		end

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Initialize text window with name `a_name', parent `a_parent',
			-- and tool window `a_tool'.
		require else
			valid_parent: a_parent /= Void 
		do
			{SCROLLED_T} Precursor (a_name, a_parent)
			initialize_transport
			upper := -1 			-- Init clickable array.

			add_modify_action (Current, modify_event_action)
			set_action ("Ctrl<Btn3Down>", Current, new_tooler_action)
			set_action ("Ctrl<Btn1Down>", Current, retarget_tooler_action)
--Arnaud	set_action ("Shift<Btn3Down>", Current, super_melt_action)
			set_action ("Ctrl Shift<Btn3Down>", Current, insert_breakpoint_action)
		end

	init_resource_values is
			-- Initialize the resource values.
		local
			f: FONT
		do
			set_foreground_color (Graphical_resources.text_foreground_color.actual_value)
			set_scrolled_text_background_color (implementation, Graphical_resources.text_background_color.actual_value)
			f := Graphical_resources.text_font.actual_value
			if f /= Void then
				set_font (f)
			end
		end

feature -- Drag source/Hole properties

	source: WIDGET is
			-- Target widget of hole
		do
			Result := Current
		end

feature -- Properties

	last_found_position: INTEGER
			-- Start position of last successful search 

feature -- Access

	default_font: CELL [FONT] is
			-- Default font
		once
			!! Result.put (font)
		end

	cursor: SCROLLED_WINDOW_CURSOR is
			-- Current cursor position in scrolled text 
		do
			!! Result.make (cursor_position, top_character_position)
		end

	current_line: INTEGER is
			-- Current line in text
		local
			text_value: STRING
			text_count, pos, i: INTEGER
		do
			from
				text_value := text
				pos := cursor_position
				text_count := text_value.count
				Result := 1
				i := 1
			until
				i >= pos or i > text_count
			loop
				if text_value.item (i) = '%N' then
					Result := Result + 1
				end
				i := i + 1
			end
		end

feature -- Changing

	set_font_to_default is
			-- Set font to the default value.
		do
			set_font (default_font.item)
		end

	set_changed (b: BOOLEAN) is
			-- Set `changed' to b.
		do
			changed := b
		ensure then
			set: changed = b
		end

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		do
			set_editable
			changed := True
			{SCROLLED_T} Precursor (a_text)
			changed := False
		ensure then
			not_changed: not changed	
		end

	set_background_color (new_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			{SCROLLED_T} Precursor (new_color)
			set_scrolled_text_background_color (implementation, 
				Graphical_resources.text_background_color.actual_value)
		end

feature -- Displaying

	display is
			-- Display the `image' to the text window.
		do
			set_editable
			set_text (image)
			set_read_only
		ensure then
			up_to_date: not changed
		end

feature -- Search

	search_stone (a_stone: STONE) is
			-- Search for `stone' in the click list and
			-- highlight it if found.
		local
			click_stone: CLICK_STONE
			i: INTEGER
			stone_found: BOOLEAN
			local_copy: like Current
		do
			from
				local_copy := Current
				i := 1
			until
				stone_found or i > clickable_count
			loop
				click_stone := local_copy.item (i)
				if a_stone.same_as (click_stone.node) then
					set_bounds (click_stone.start_position, 
						click_stone.end_position)
					highlight_focus
					stone_found := true
				end
				i := i + 1
			end
		end

feature -- Cursor movement

	go_to (a_cursor: CURSOR) is
			-- Go to `a_cursor) position
		local
			cur: SCROLLED_WINDOW_CURSOR
			c: INTEGER
			last_cursor_position, last_top_position: INTEGER
		do
			cur ?= a_cursor
			if cur /= Void then
				last_cursor_position := cur.cursor_position
				last_top_position := cur.top_character_position
				c := count
				if last_cursor_position > c then
					last_cursor_position := c
				end
				if last_top_position > c then
					last_top_position := c
				end
				set_cursor_position (last_cursor_position)
				set_top_character_position (last_top_position)
			end
		end

feature -- Text selection

	deselect_all is
		do
			if is_selection_active then
				clear_selection
			end
		end

feature -- Text manipulation

	copy_text is
			-- Copy the highlighted text.
		do
			copy_text_from_widget (implementation)
		end
 
	cut_text is
			-- Cut the highlighted text.
		do
			cut_text_from_widget (implementation)
		end
 
	paste_text is
			-- Paste the highlighted text.
		do
			paste_text_to_widget (implementation)
		end
 
	clear_window is
			-- Erase internal structures of Current.
		do
			image.wipe_out
			disable_clicking
			position := 0
			text_position := 0
			focus_start := 0
			focus_end := 0
			changed := True
			clear
			set_cursor_position (0)
			set_changed (false)
		ensure then
			image.is_empty
			position = 0
			clickable_count = 0
			focus_start = 0
			focus_end = 0
			not changed
		end

	clear_text is
			-- Clear the text structures.
		do
			image.wipe_out
			clear
			disable_clicking
			position := 0
			text_position := 0
			focus_start := 0
			focus_end := 0
			set_changed (false)
		end

feature -- Update

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position' if the new position
			-- is not out of bounds.
		do
			if a_position <= count then
				{SCROLLED_T} Precursor (a_position)
			end
		end

	set_top_character_position (a_position: INTEGER) is
			-- Set top_character_position to `a_position' if the new position
			-- is not out of bounds.
		do
			if a_position <= count then
				{SCROLLED_T} Precursor (a_position)
			end
		end

	search_text (s: STRING; is_case_sensitive: BOOLEAN) is
			-- Highlight and show next occurence of `s'.
		local
			start_position: INTEGER
		do
				--| We start the search at the current position
			start_position := find (s, is_case_sensitive, implementation.actual_cursor_position)
			
			if start_position = -1 then
				start_position := find (s, is_case_sensitive, 0)
			end			

			if start_position /= -1 then
				set_cursor_position (start_position + s.count)
				highlight_selected (start_position, start_position + s.count)
			else
				eif_beep
			end
		end
			
	replace_text (s, r: STRING replace_all, is_case_sensitive: BOOLEAN) is
			-- Replace next occurence of `s' with `r'.
		local
			start_position: INTEGER
			c_position: INTEGER
			length_s, length_r: INTEGER
		do
			if not replace_all then
					--| The search start where the selection begins

				if is_selection_active then
					start_position := find (s, is_case_sensitive, begin_of_selection)
				else
					start_position := find (s, is_case_sensitive, implementation.actual_cursor_position)
				end

				if start_position /= -1 then
					replace (start_position, start_position + s.count, r)
					search_text (s, is_case_sensitive)
				else
					eif_beep
				end
			else
				from
					implementation.hide_selection
					c_position := cursor_position
					length_s := s.count
					length_r := r.count
					start_position := find (s, is_case_sensitive, 0)
				until
					start_position  = -1
				loop
					replace (start_position, start_position + length_s, r)
					start_position := find (s, is_case_sensitive, start_position + length_r)
				end
				set_cursor_position (c_position)
				implementation.show_selection
				eif_beep
			end
		end

feature -- Focus Access

	initial_coord: COORD_XY is
			-- Initial coordinate for drag
		do
			Result := coordinate (focus_start)
			Result.set (Result.x + real_x, Result.y + real_y)
		end

feature -- Update

	update_after_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- before transport using button data `but_data'.
		do	
			deselect_all
		end

	update_before_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- before transport using button data `but_data'.
		local
			cur_pos: INTEGER
		do
			if clickable_count /= 0 then
				if last_warner /= Void then
					last_warner.popdown
				end
				cur_pos := character_position (but_data.absolute_x - real_x, but_data.absolute_y - real_y)
				update_focus (cur_pos)
				highlight_focus
			end
		end

	redisplay_breakable_mark (body_index: INTEGER; index: INTEGER) is
			-- Redisplay the sign of the `index'-th breakable point
			-- of the feature that have its body_index equal to `body_index'
			-- Display the arrow "->" if `display_arrow' is True.
		local
			start_pos, end_pos: INTEGER
			was_selection_active: BOOLEAN
			status: APPLICATION_STATUS
			cb: CLICK_BREAKABLE
			bs: BREAKABLE_STONE
		do
			cb := breakable_for (body_index, index)
			if cb /= Void then
				changed := True
				bs := cb.breakable
				if is_selection_active then
					was_selection_active := True
					start_pos := begin_of_selection
					end_pos := end_of_selection
					clear_selection
				end
				changed := True
				replace (cb.start_position, cb.end_position, bs.sign)
				changed := False
				status := Application.status
				if status /= Void and then status.is_stopped and then status.is_at (bs.body_index, bs.index) then
						-- Execution stopped at that breakpoint.
						-- Show the point on the screen (scroll if
						-- necessary)
					set_cursor_position (cb.end_position)
				elseif was_selection_active then
					set_selection (start_pos, end_pos)
				end
			end
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command for Current.
		do
			if not changed then
				if argument = modify_event_action then
						-- If the text of a windows has been modified
						-- we need to remove the clickable action because
						-- of the strange graphical result
					disable_clicking
				else
					process_action (argument)
				end
			end
		end

feature {TOOL_W} -- Objects in Current text area

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects
		local
			obj_stone: OBJECT_STONE
			i: INTEGER
			local_copy: like Current
		do
			!! Result.make
			from
				local_copy := Current
				i := 1
			until
				i > clickable_count
			loop
				obj_stone ?= local_copy.item (i).node
				if obj_stone /= Void then
					Result.extend (obj_stone.object_address)
				end
				i := i + 1
			end
		end

feature {OBJECT_W} -- Settings

	hang_on is
			-- Make object addresses unclickable.
		local
			obj_stone: OBJECT_STONE
			index, last_pos: INTEGER
			local_copy: like Current
		do
			from
				local_copy := Current
				index := 1
			until
				index > clickable_count
			loop
				obj_stone ?= local_copy.item (index).node

					-- Remove object stone
				if obj_stone = Void then
					-- Keep routine and class stones clickable.
					last_pos := last_pos + 1
					local_copy.put (local_copy.item (index), last_pos)
				end
				index := index + 1
			end
			clickable_count := last_pos
		end

feature {NONE}

	eif_beep is
		external
			"C"
		end

end -- class SCROLLED_TEXT_WINDOW
