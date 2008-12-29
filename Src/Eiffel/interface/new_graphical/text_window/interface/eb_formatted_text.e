note
	description:
		"$EiffelGraphicalCompiler$ notion of a formatted text"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class
	EB_FORMATTED_TEXT

inherit
	OUTPUT_WINDOW

feature -- Properties

	is_editable: BOOLEAN
			-- Is the Current text window able to edit text?
		deferred
		end

	text: STRING_32
			-- Text of window
		deferred
		ensure
			non_void_result: Result /= Void
		end

	number_of_lines: INTEGER
			-- Number of lines in `text'
		deferred
		end

	changed: BOOLEAN
			-- Has the text been edited since last display?
		deferred
		end

feature -- Setting

	set_font_to_default
			-- Set font to its default font.
		do
		end

feature -- Access

	widget: EV_WIDGET
			-- Widget representing text window
		deferred
		end

	position: INTEGER
			-- Cursor position of text
		deferred
		end

feature -- Text operations

	copy_selection
			-- Copy the highlighted text.
		deferred
		end

	cut_selection
			-- Cut the highlighted text.
		deferred
		end

	deselect_all
		deferred
		end

	set_position (a_position: INTEGER)
			-- Set cursor_position to `a_position'.
		require
			valid_position: a_position >= 1
		deferred
		ensure
			position_set: position = a_position
		end

	highlight_selected (a, b: INTEGER)
			-- Highlight between lines `a' and `b' using reverse video.
		require
			first_fewer_than_last: a <= b
		do
			select_lines (a, b)
		end

feature -- Status setting

	set_changed (b: BOOLEAN)
			-- Set `changed' to b.
		deferred
		end

	disable_clicking
			-- Disable the ability to drag and drop stones
			-- and set `changed' to False.
		do
		end

	enable_editable
			-- Allow editing of text.
		deferred
		end

	disable_editable
			-- Allow editing of text.
		deferred
		end

	reset
			-- Reset the contents of the text window.
		do
			clear_window
		end

	select_lines (first, last: INTEGER)
			-- Select the text between `first' and `last' lines.
			-- This text will be physically highlightened on the screen.
		require
			valid_start: first >= 1 and first <= number_of_lines
			valid_end: last >= 1 and last <= number_of_lines
			range_valid: first <= last
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

	context_data_useful: BOOLEAN = True

	new_tooler_action: ANY
			-- Callback value to indicate that a new tool should come up.
		once
			create Result
		end

	retarget_tooler_action: ANY
			-- Callback value to indicate that a tool need to change its
			-- content with the one selected by the user.
		once
			create Result
		end

	super_melt_action: ANY
			-- Callback value to indicate that the feature will be super melted.
		once
			create Result
		end

	insert_breakpoint_action: ANY
			-- Callback value to indicate that a breakpoint will be put at
			-- the first call of the routine.
		once
			create Result
		end

	modify_event_action: ANY
			-- Callback value to indicate that the text has modified.
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FORMATTED_TEXT
