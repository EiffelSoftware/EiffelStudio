indexing
	description:	
		"$EiffelGraphicalCompiler$ notion of a formatted text"

deferred class
	EB_FORMATTED_TEXT

inherit
	OUTPUT_WINDOW

feature -- Properties

	is_editable: BOOLEAN is
			-- Is the Current text window able to edit text?
		deferred
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

feature -- Setting

	set_font_to_default is
			-- Set font to its default font.
		do
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing text window
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

	deselect_all is
		deferred
		end

	set_position (a_position: INTEGER) is
			-- Set cursor_position to `a_position'.
		require
			valid_position: a_position >= 1
		deferred
		ensure
			position_set: position = a_position
		end

	highlight_selected (a, b: INTEGER) is
			-- Highlight between positions `a' and `b' using reverse video.
		require
			first_fewer_than_last: a <= b
		do
			if --b <= text_length and then 
				b > a then
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

	disable_clicking is
			-- Disable the ability to drag and drop stones
			-- and set `changed' to False.
		do
		end

	enable_editable is
			-- Allow editing of text.
		deferred
		end

	disable_editable is
			-- Allow editing of text.
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

--	update_clickable_from_stone (a_stone: STONE) is
--			-- Update the clickable information from tool's stone.
--			-- click list if text uses character position.
--		require
--			valid_stone: a_stone /= Void
--		do
--		end


feature {NONE} -- Command arguments

	context_data_useful: BOOLEAN is True

	new_tooler_action: ANY is
			-- Callback value to indicate that a new tool should come up.
		once
			create Result
		end

	retarget_tooler_action: ANY is
			-- Callback value to indicate that a tool need to change its
			-- content with the one selected by the user.
		once
			create Result
		end

	super_melt_action: ANY is
			-- Callback value to indicate that the feature will be super melted.
		once
			create Result
		end

	insert_breakpoint_action: ANY is
			-- Callback value to indicate that a breakpoint will be put at
			-- the first call of the routine.
		once
			create Result
		end

	modify_event_action: ANY is
			-- Callback value to indicate that the text has modified.
		once
			create Result
		end

end -- class EB_FORMATTED_TEXT
