deferred class TEXT_WINDOW

inherit

	OUTPUT_WINDOW;
	DRAG_SOURCE;
	WINDOWS;
	SHARED_TABS

feature -- Properties

	tool: TOOL_W;
			-- Tool window to which Current belongs.

	tab_length: INTEGER is
			-- Length of tabs in spaces
		do
			Result := tool.tab_length
		end

	focus: STONE is
			-- The stone where the focus currently is
		deferred
		end;

	is_editable: BOOLEAN is
			-- Is the Current text window able to edit text?
		do
			Result := True
		end;

	is_graphical: BOOLEAN is
			-- Is the Current text window able to 	
			-- display the text graphically?
		do
		end;

	text: STRING is
			-- Text of window
		deferred
		ensure 
			non_void_result: Result /= Void
		end;

	changed: BOOLEAN is
			-- Has the text been edited since last display?
		deferred
		end;

	cursor: CURSOR is
			-- Current cursor position in text window
		deferred
		end;

feature -- Access

	transported_stone: STONE is
			-- Stone to be transported
		do
			Result := focus
		end;

	widget: WIDGET is
			-- Widget representing text window
		deferred
		end;

	hole_target: WIDGET is
			-- Widget representing the hole
		deferred
		end;

	current_line: INTEGER is
			-- Current line in text
		deferred
		end

feature -- Text operations

	deselect_all is
		deferred
		end;

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position' if the new position
			-- is not out of bounds.
		require
			is_editable: is_editable
		deferred	
		end;

	highlight_selected (a, b: INTEGER) is
			-- Highlight between positions `a' and `b' using reverse video.
		require
			first_fewer_than_last: a <= b
		deferred
		end

feature -- Status setting

	set_changed (b: BOOLEAN) is
			-- Set `changed' to b.
		deferred
		end;

	set_text (an_image: STRING) is
			-- Set `image' to `an_image'.
		require	
			is_editable: is_editable
		deferred
		end;

	disable_clicking is
			-- Disable the ability to drag and drop stones
			-- and set `changed' to False.
		do
			set_changed (True)
		end;

	set_read_only is
			-- Set the mode of editing to read_only.
		deferred
		end;

	set_editable is
			-- Allow editing of text.
		require
			is_editable: is_editable
		deferred
		end;

	clear_text is
			-- Clear the text structures.
		deferred
		end

feature -- Element change

	put_breakpoint_stone (a_stone: BREAKABLE_STONE; stone_string: STRING) is
			-- Add breakpoint stone `a_stone' with image `stone_string'.
		deferred
		end

feature -- Update

	search_stone (a_stone: STONE) is
			-- Search for `stone' in the click list and
			-- highlight it if found.
		deferred
		end;

	search (s: STRING) is
			-- Highlight and show next occurence of `s'.
		require
			valid_s: s /= Void
		deferred
		end

	update_clickable_from_stone is
			-- Update the clickable information from tool's stone.
			-- click list if text uses character position.
		require
			stone_exists: tool.stone /= Void;
			stone_is_clickable: tool.stone.clickable
		do
		end;

feature -- Cursor movement

	go_to (a_cursor: CURSOR) is
			-- Go to cursor position 
		deferred
		end

feature {TOOL_W} -- Updating

	redisplay_breakable_mark (f: E_FEATURE; index: INTEGER) is
			-- Redisplay the sign of the `index'-th breakable point.
		require
			valid_f: f /= Void;
			positive_index: index >= 1
		deferred
		end

	highlight_breakable (f: E_FEATURE; index: INTEGER) is
			-- Highlight the line containing the `index'-th breakable point.
		require
			valid_f: f /= Void;
			positive_index: index >= 1
		deferred
		end;

	hide is
			-- Hide the text window
		deferred
		end;

	show is
			-- Show the text window
		deferred
		end;

	shown: BOOLEAN is
			-- Is the text window shown?
		deferred
		end;

	set_tab_length_to_default is
			-- Set `tab_length' to the default tab length.
		local
			was_changed: BOOLEAN
		do
			if tab_length /= default_tab_length.item then
				was_changed := changed;
				set_tab_length (default_tab_length.item);
				set_changed (changed)
			end
		end;

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		require
			valid_length: new_length > 1
		deferred
		ensure
			assigned: tab_length = new_length
		end;

feature {TOOL_W, OBJECT_W} -- Implementation

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects and
			-- objects kept in history
		deferred
		end;

	hang_on is 
			-- Make object addresses unclickable
		deferred
		end;

feature {NONE} -- Command arguments

	new_tooler: ANY is
			-- Callback value to indicate that a new tool should come up.
		once
			!! Result
		end;

	modify_event: ANY is
			-- Callback value to indicate that the text has modified.
		once
			!! Result
		end;

end -- class TEXT_WINDOW
