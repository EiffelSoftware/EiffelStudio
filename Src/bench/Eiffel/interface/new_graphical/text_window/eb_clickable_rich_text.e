indexing
	description: "Implementation of a clikable text using a rich text"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICKABLE_RICH_TEXT

inherit
	EV_RICH_TEXT
		rename
			cursor as widget_cursor
		undefine
			is_equal, copy
		redefine
			make,
			set_text,
			set_position
--			set_top_character_position
		end

	EB_CLICKABLE_TEXT
		rename
			freeze as temp_freeze,
			thaw as temp_thaw,
				--| FIXME
				--| Christophe, 26 oct 1999
				--| freeze and thaw where "about to be implemented".
				--| now it is not sure anymore. maybe these functions
				--| could be removed.
			hole_target as source,
			count as array_count,
			widget as source
		redefine
			clear_window,
			display, 
--			update_before_transport,
--			initial_coord,
--			update_after_transport,
			set_font_to_default
		end

	SHARED_APPLICATION_EXECUTION
		undefine
			is_equal, copy
		end

--	NEW_EB_CONSTANTS
--		undefine
--			is_equal, copy
--		end

creation
	make,
	make_from_tool

feature -- Initialization

	make_from_tool (par: EV_CONTAINER; ed: EB_EDIT_TOOL) is
			-- Initialize Current with parent `par',
			-- and link it to `ed'.
		require
			valid_tool: ed /= Void and then not ed.destroyed
		local
			rc: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EB_EDIT_TOOL]
		do
			make (par)
			create rc.make (~modify)
			create arg.make (ed)
			add_change_command (rc, arg)
		end

	make (par: EV_CONTAINER) is
			-- Initialize Current with parent `par'.
		require else
			valid_parent: par /= Void 
		do
			{EV_RICH_TEXT} Precursor (par)
--			initialize_transport
			array_create (1, 0)
--			upper := -1 			-- Init clickable array.

--			add_change_command (Current, modify_event_action)
--			set_action ("Ctrl<Btn3Down>", Current, new_tooler_action)
--			set_action ("Ctrl<Btn1Down>", Current, retarget_tooler_action)
--			set_action ("Shift<Btn3Down>", Current, super_melt_action)
--			set_action ("Ctrl Shift<Btn3Down>", Current, insert_breakpoint_action)
		end

	init_resource_values is
			-- Initialize the resource values.
		do
			set_format (default_text_font, text_foreground_color)
			set_background_color (text_background_color)
		end

feature -- Drag source/Hole properties

	source: EV_WIDGET is
			-- Target widget of hole
		do
			Result := Current
		end

feature -- Properties

	last_found_position: INTEGER
			-- Start position of last successful search 

feature -- Access

--	default_font: CELL [EV_FONT] is
--			-- Default font
--		once
--			create Result.put (font)
--		end

--	cursor: SCROLLED_WINDOW_CURSOR is
--			-- Current cursor position in scrolled text 
--		do
--			!! Result.make (cursor_position, top_character_position)
--		end

	current_line: INTEGER is
			-- Current line in text
		local
			text_value: STRING
			text_count, pos, i: INTEGER
		do
			from
				text_value := text
				pos := position
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
--			set_font (default_font.item)
		end

	set_format (f: EV_FONT; c: EV_COLOR) is
		local
			format: EV_CHARACTER_FORMAT
		do
			create format.make
			format.set_font (f)
			format.set_color (c)
			set_character_format (format)
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
			set_changed (True)
			{EV_RICH_TEXT} Precursor (a_text)
			set_changed (False)
		ensure then
			not_changed: not changed	
		end

feature -- Displaying

	display is
			-- Display the `image' to the text window.
		do
			set_editable (True)
			set_editable (False)
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

--	go_to (a_cursor: CURSOR) is
	go_to (a_cursor: INTEGER) is
			-- Go to `a_cursor) position
		local
--			cur: SCROLLED_WINDOW_CURSOR
			c: INTEGER
			last_cursor_position, last_top_position: INTEGER
		do
			last_cursor_position := a_cursor
--			cur ?= a_cursor
--			if cur /= Void then
--				last_cursor_position := cur.cursor_position
--				last_top_position := cur.top_character_position
				c := text_length
				if last_cursor_position > c then
					last_cursor_position := c
				end
--				if last_top_position > c then
--					last_top_position := c
--				end
				set_position (last_cursor_position)
--				set_top_character_position (last_top_position)
--			end
		end

feature -- Text manipulation

 	clear_window is
			-- Erase internal structures of Current.
			-- this feature is ugly
		do
			set_editable (True)
			disable_clicking
			struct_position := 1
			text_position := 1
			focus_start := 1
			focus_end := 1
			set_changed (True)
			set_text("")
			set_position (1)
			set_changed (False)
--			set_editable (False)
		ensure then
			struct_position = 1
			clickable_count = 0
			focus_start = 1
			focus_end = 1
			not changed
		end

	clear_text is
			-- Clear the text structures.
			-- this feature is ugly
		do
			set_text("")
			disable_clicking
			struct_position := 1
			text_position := 1
			focus_start := 1
			focus_end := 1
			set_changed (false)
		end

feature -- Update

	set_position (a_position: INTEGER) is
			-- Set position to `a_position' if the new position
			-- is not out of bounds.
		do
			if a_position <= text_length then
				{EV_RICH_TEXT} Precursor (a_position)
			end
		end

--	set_top_character_position (a_position: INTEGER) is
--			-- Set top_character_position to `a_position' if the new position
--			-- is not out of bounds.
--		do
--			if a_position <= text_length then
--				{EV_RICH_TEXT} Precursor (a_position)
--			end
--		end

	search_text (s: STRING; is_case_sensitive: BOOLEAN) is
			-- Highlight and show next occurence of `s'.
		local
--			start_position: INTEGER
		do
--				--| We start the search at the current position
--			start_position := find (s, is_case_sensitive, implementation.actual_cursor_position)
--			
--			if start_position = -1 then
--				start_position := find (s, is_case_sensitive, 0)
--			end			
--
--			if start_position /= -1 then
--				highlight_selected (start_position, start_position + s.count)
--				set_position (start_position + s.count)
--			else
--				eif_beep
--			end
		end
			
	replace_text (s, r: STRING replace_all, is_case_sensitive: BOOLEAN) is
			-- Replace next occurence of `s' with `r'.
		local
--			start_position: INTEGER
--			c_position: INTEGER
--			length_s, length_r: INTEGER
		do
--			if not replace_all then
--					--| The search start where the selection begins
--
--				if has_selection then
--					start_position := find (s, is_case_sensitive, begin_of_selection)
--				else
--					start_position := find (s, is_case_sensitive, implementation.actual_cursor_position)
--				end
--
--				if start_position /= -1 then
--					replace (start_position, start_position + s.count, r)
--					search_text (s, is_case_sensitive)
--				else
--					eif_beep
--				end
--			else
--				from
--					implementation.hide_selection
--					c_position := position
--					length_s := s.count
--					length_r := r.count
--					start_position := find (s, is_case_sensitive, 0)
--				until
--					start_position  = -1
--				loop
--					replace (start_position, start_position + length_s, r)
--					start_position := find (s, is_case_sensitive, start_position + length_r)
--				end
--				set_cursor_position (c_position)
--				implementation.show_selection
--				eif_beep
--			end
		end

feature -- Focus Access

--	initial_coord: COORD_XY is
--			-- Initial coordinate for drag
--		do
--			Result := coordinate (focus_start)
--			Result.set (Result.x + real_x, Result.y + real_y)
--		end

feature -- Update

	temp_freeze is do hide end
	temp_thaw is do show end

--	update_after_transport (but_data: BUTTON_DATA) is
--			-- Update Current stone and related information
--			-- before transport using button data `but_data'.
--		do	
--			deselect_all
--		end

--	update_before_transport (but_data: BUTTON_DATA) is
--			-- Update Current stone and related information
--			-- before transport using button data `but_data'.
--		local
--			cur_pos: INTEGER
--		do
--			if clickable_count /= 0 then
--				cur_pos := character_position (but_data.absolute_x - real_x, but_data.absolute_y - real_y)
--				update_focus (cur_pos)
--				highlight_focus
--			end
--		end

	redisplay_breakable_mark (f: E_FEATURE; index: INTEGER) is
			-- Redisplay the sign of the `index'-th breakable point.
		local
--			start_pos, end_pos: INTEGER
--			was_selection_active: BOOLEAN
--			status: APPLICATION_STATUS
--			cb: CLICK_BREAKABLE
--			bid: BODY_ID
--			bs: BREAKABLE_STONE
		do
--			cb := breakable_for (f, index)
--			if cb /= Void then
--				set_changed (True)
--				bs := cb.breakable
--				if has_selection then
--					was_selection_active := True
--					start_pos := selection_start
--					end_pos := selection_end
--					deselect_all
--				end
--				set_changed (True)
--				replace (cb.start_position, cb.end_position, bs.sign)
--				set_changed (False)
--				status := Application.status
--				if
--					status /= Void and status.is_stopped and
--					status.is_at (bs.routine, bs.index)
--				then
--						-- Execution stopped at that breakpoint.
--						-- Show the point on the screen (scroll if
--						-- necessary)
--					set_position (cb.end_position)
--				elseif was_selection_active then
--					set_selection (start_pos, end_pos)
--				end
--			end
		end

feature -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_BUTTON_EVENT_DATA) is
			-- Execute the command for Current.
		do
			if not changed then
				if arg = modify_event_action then
						-- If the text of a windows has been modified
						-- we need to remove the clickable action because
						-- of the strange graphical result
					disable_clicking
				else
					process_action (arg, data)
				end
			end
		end

	modify (arg: EV_ARGUMENT1 [EB_EDIT_TOOL]; data: EV_EVENT_DATA) is
			-- action performed when user changes the text.
		require
			arg_exists: arg /= Void
		do
			if not changed then
				set_changed (True)
				arg.first.update_save_symbol
			end
		ensure 
			changed: changed	
		end

feature {EB_TOOL} -- Objects in Current text area

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

feature {EB_OBJECT_TOOL} -- Settings

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

end -- class EB_CLICKABLE_RICH_TEXT
