indexing
	description:	
		"EiffelBench notion of a formatted text"

deferred class
	EB_FORMATTED_TEXT

inherit
	OUTPUT_WINDOW

--	WINDOWS

	EB_SHARED_INTERFACE_TOOLS

--	TAB_INFORMATION

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
		deferred
--		do
--			Result := True
		end

	text: STRING is
			-- Text of window
		deferred
		ensure 
			non_void_result: Result /= Void
		end

	text_length: INTEGER is
			-- Number of characters in `text'
		deferred
		end

	changed: BOOLEAN is
			-- Has the text been edited since last display?
		deferred
		end

--	cursor: CURSOR is
--			-- Current cursor position in text window
--		deferred
--		end

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

	widget: EV_WIDGET is
			-- Widget representing text window
		deferred
		end

	hole_target: EV_WIDGET is
			-- Widget representing the hole
		deferred
		end

	current_line: INTEGER is
			-- Current line in text
		deferred
		end

	position: INTEGER is
			-- Cursor position of text
		deferred
		end

feature -- Text operations

	copy_selection is
			-- Copy the highlighted text.
		deferred
		end

	cut_selection is
			-- Cut the highlighted text.
		deferred
		end

	paste (pos: INTEGER) is
			-- Paste the highlighted text.
		deferred
		end

	deselect_all is
		deferred
		end

	set_position (a_position: INTEGER) is
			-- Set cursor_position to `a_position' if the new position
			-- is not out of bounds.
		deferred	
		end

--	set_top_character_position (a_position: INTEGER) is
--			-- Set top_character_position to `a_position' if the new position
--			-- is not out of bounds.
--		require
--			is_editable: is_editable
--		deferred	
--		end

	highlight_selected (a, b: INTEGER) is
			-- Highlight between positions `a' and `b' using reverse video.
		require
			first_fewer_than_last: a <= b
		do
			if b <= text_length and then b > a then
					-- Does not highlight if `b' is beyond the
					-- bounds of the text.
				select_region (a, b)
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


	set_editable (flag: BOOLEAN) is
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

	select_region (first, last: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require
			valid_start: first >= 1 and first <= text_length
			valid_end: last >= 1 and last <= text_length
		deferred
		end

feature -- Update

	search_stone (a_stone: STONE) is
			-- Search for `stone' in the click list and
			-- highlight it if found.
		deferred
		end

	search_text (s: STRING is_case_sensitive: BOOLEAN) is
			-- Highlight and show next occurence of text `s'.
		require
			valid_s: s /= Void
			s_not_empty: not s.empty
		deferred
		end

	replace_text (s, r: STRING replace_all, is_case_sensitive: BOOLEAN) is
			-- Replace next occurence of `s' with `r'.
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

--	go_to (a_cursor: CURSOR) is
	go_to (a_cursor: INTEGER) is
			-- Go to cursor position 
		deferred
		end

feature {EB_TOOL} -- Updating

	redisplay_breakable_mark (f: E_FEATURE index: INTEGER) is
			-- Redisplay the sign of the `index'-th breakable point.
		require
			valid_f: f /= Void
			positive_index: index >= 1
		deferred
		end

	highlight_breakable (f: E_FEATURE index: INTEGER) is
			-- Highlight the line containing the `index'-th breakable point.
		require
			valid_f: f /= Void
			positive_index: index >= 1
		deferred
		end

feature -- Updating

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

feature {EB_TOOL, EB_OBJECT_TOOL} -- Implementation

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

	new_tooler_action: EV_ARGUMENT1 [ANY] is
			-- Callback value to indicate that a new tool should come up.
		once
			create Result.make (Void)
		end

	retarget_tooler_action: EV_ARGUMENT1 [ANY] is
			-- Callback value to indicate that a tool need to change its
			-- content with the one selected by the user.
		once
			create Result.make (Void)
		end

	super_melt_action: EV_ARGUMENT1 [ANY] is
			-- Callback value to indicate that the feature will be super melted.
		once
			create Result.make (Void)
		end

	insert_breakpoint_action: EV_ARGUMENT1 [ANY] is
			-- Callback value to indicate that a breakpoint will be put at
			-- the first call of the routine.
		once
			create Result.make (Void)
		end

	modify_event_action: EV_ARGUMENT1 [ANY] is
			-- Callback value to indicate that the text has modified.
		once
			create Result.make (Void)
		end

	process_action (arg: EV_ARGUMENT1 [ANY]; data: EV_BUTTON_EVENT_DATA) is
			-- Process an action based on `arg'.
		local
			super_melt_cmd: EB_SUPER_MELT_CMD
			insert_breakpoint_cmd: EB_INSERT_BREAKPOINT_CMD
			st: STONE
--			target: HOLE
			wid: EV_WIDGET
--			holes: LINKED_LIST [HOLE]
		do
			if arg = new_tooler_action then
--				update_before_transport (data)
				st := focus
				if st /= Void then
--					Project_tool.receive (st)
					deselect_all
				end

			elseif arg = retarget_tooler_action then
--				update_before_transport (data)
				st := focus
				if st /= Void then
--					from
--						wid := widget.screen.widget_pointed
--						holes := Transporter.holes
--						holes.start
--					until
--						holes.after or else target /= Void
--					loop
--						if holes.item.target = wid then
--							target := holes.item
--						end
--						holes.forth
--					end

--					if target /= Void then
--						target.receive (st)
--						deselect_all
--					end
				end

			elseif arg = super_melt_action then
--				update_before_transport (data)
				st := focus
				if st /= Void then
--					create super_melt_cmd.do_nothing
--					super_melt_cmd.work (st)
--					deselect_all
				end

			elseif arg = insert_breakpoint_action then
--				update_before_transport (data)
				st := focus
				if st /= Void then
--					create insert_breakpoint_cmd.do_nothing
--					insert_breakpoint_cmd.work (st)
--					deselect_all
				end
				
			end
		end

end -- class EB_FORMATTED_TEXT
