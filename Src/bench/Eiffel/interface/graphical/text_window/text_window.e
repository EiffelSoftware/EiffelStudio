deferred class
	TEXT_WINDOW

inherit
	OUTPUT_WINDOW

	DRAG_SOURCE

	WINDOWS

	TAB_INFORMATION

	COMMAND
		redefine
			context_data_useful
		end

feature -- Initialization

	init_resource_values is
			-- Initialize the resource values.
		deferred
		end

feature -- Properties

	focus: STONE is
			-- The stone where the focus currently is
		deferred
		end

	is_editable: BOOLEAN is
			-- Is the Current text window able to edit text?
		do
			Result := True
		end

	is_graphical: BOOLEAN is
			-- Is the Current text window able to 	
			-- display the text graphically?
		do
		end

	text: STRING is
			-- Text of window
		deferred
		ensure 
			non_void_result: Result /= Void
		end

	count: INTEGER is
			-- Number of characters in `text'
		deferred
		end

	changed: BOOLEAN is
			-- Has the text been edited since last display?
		deferred
		end

	cursor: CURSOR is
			-- Current cursor position in text window
		deferred
		end

feature -- Setting

	set_font_to_default is
			-- Set font to its default font.
		do
		end

feature -- Access

	transported_stone: STONE is
			-- Stone to be transported
		do
			Result := focus
		end

	widget: WIDGET is
			-- Widget representing text window
		deferred
		end

	hole_target: WIDGET is
			-- Widget representing the hole
		deferred
		end

	current_line: INTEGER is
			-- Current line in text
		deferred
		end

	cursor_position: INTEGER is
			-- Cursor position of text
		deferred
		end

feature -- Text operations

	copy_text is
			-- Copy the highlighted text.
		deferred
		end

	cut_text is
			-- Cut the highlighted text.
		deferred
		end

	paste_text is
			-- Paste the highlighted text.
		deferred
		end

	deselect_all is
		deferred
		end

	set_cursor_position (a_position: INTEGER) is
			-- Set cursor_position to `a_position' if the new position
			-- is not out of bounds.
		deferred	
		end

	set_top_character_position (a_position: INTEGER) is
			-- Set top_character_position to `a_position' if the new position
			-- is not out of bounds.
		require
			is_editable: is_editable
		deferred	
		end

	highlight_selected (a, b: INTEGER) is
			-- Highlight between positions `a' and `b' using reverse video.
		require
			first_fewer_than_last: a <= b
		do
			if b <= count and then b > a then
					-- Does not highlight if `b' is beyond the
					-- bounds of the text.
				set_selection (a, b)
			end
		end

feature -- Status setting

	set_changed (b: BOOLEAN) is
			-- Set `changed' to b.
		deferred
		end

	set_text (an_image: STRING) is
			-- Set `image' to `an_image'.
		require	
			is_editable: is_editable
		deferred
		end

	disable_clicking is
			-- Disable the ability to drag and drop stones
			-- and set `changed' to False.
		do
		end

	set_read_only is
			-- Set the mode of editing to read_only.
		deferred
		end

	set_editable is
			-- Allow editing of text.
		require
			is_editable: is_editable
		deferred
		end

	clear_text is
			-- Clear the text structures.
		deferred
		end

	reset is
			-- Reset the contents of the text window.
		do
			clear_window
		end

	set_selection (first, last: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require
			first_positive_not_null: first >= 0
			last_fewer_than_count: last <= count
			first_fewer_than_last: first <= last
		deferred
		end

feature -- Update

	search_stone (a_stone: STONE) is
			-- Search for `stone' in the click list and
			-- highlight it if found.
		deferred
		end

	search_text (s: STRING; is_case_sensitive: BOOLEAN) is
			-- Highlight and show next occurrence of text `s'.
		require
			valid_s: s /= Void
			s_not_empty: not s.is_empty
		deferred
		end

	replace_text (s, r: STRING; replace_all, is_case_sensitive: BOOLEAN) is
			-- Replace next occurrence of `s' with `r'.
		require
			valid_s: s /= Void
			valid_r: r /= Void
		deferred
		end

	update_clickable_from_stone (a_stone: STONE) is
			-- Update the clickable information from tool's stone.
			-- click list if text uses character position.
		require
			valid_stone: a_stone /= Void
		do
		end

feature -- Cursor movement

	go_to (a_cursor: CURSOR) is
			-- Go to cursor position 
		deferred
		end

feature {TOOL_W} -- Updating

	redisplay_breakable_mark (body_index: INTEGER; index: INTEGER) is
			-- Redisplay the sign of the `index'-th breakable point.
		require
			valid_body_index: body_index >= 1
			positive_index: index >= 1
		deferred
		end

	highlight_breakable (body_index: INTEGER; index: INTEGER) is
			-- Highlight the line containing the `index'-th breakable point.
		require
			valid_body_index: body_index >= 1
			positive_index: index >= 1
		deferred
		end

	hide is
			-- Hide the text window
		deferred
		end

	show is
			-- Show the text window
		deferred
		end

	shown: BOOLEAN is
			-- Is the text window shown?
		deferred
		end

feature {TOOL_W, OBJECT_W} -- Implementation

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects and
			-- objects kept in history
		deferred
		end

	hang_on is 
			-- Make object addresses unclickable
		deferred
		end

feature {NONE} -- Command arguments

	context_data_useful: BOOLEAN is True

	new_tooler_action: ANY is
			-- Callback value to indicate that a new tool should come up.
		once
			!! Result
		end

	retarget_tooler_action: ANY is
			-- Callback value to indicate that a tool need to change its
			-- content with the one selected by the user.
		once
			!! Result
		end

	insert_breakpoint_action: ANY is
			-- Callback value to indicate that a breakpoint will be put at
			-- the first call of the routine.
		once
			!! Result
		end

	modify_event_action: ANY is
			-- Callback value to indicate that the text has modified.
		once
			!! Result
		end

	process_action (arg: ANY) is
			-- Process an action based on `arg'.
		local
			insert_breakpoint_cmd: BREAKPOINT_INSERTER
			but_data: BUTTON_DATA
			st: STONE
			target: HOLE
			wid: WIDGET
			holes: LINKED_LIST [HOLE]
		do
			if arg = new_tooler_action then
				but_data ?= context_data
				update_before_transport (but_data)
				st := focus
				if st /= Void then
					Project_tool.receive (st)
					deselect_all
				end

			elseif arg = retarget_tooler_action then
				but_data ?= context_data
				update_before_transport (but_data)
				st := focus
				if st /= Void then
					from
						wid := widget.screen.widget_pointed
						holes := Transporter.holes
						holes.start
					until
						holes.after or else target /= Void
					loop
						if holes.item.target = wid then
							target := holes.item
						end
						holes.forth
					end

					if target /= Void then
						target.receive (st)
						deselect_all
					end
				end

			elseif arg = insert_breakpoint_action then
				but_data ?= context_data
				update_before_transport (but_data)
				st := focus
				if st /= Void then
					create insert_breakpoint_cmd.do_nothing
					insert_breakpoint_cmd.work (st)
					deselect_all
				end
				
			end
		end

end -- class TEXT_WINDOW
