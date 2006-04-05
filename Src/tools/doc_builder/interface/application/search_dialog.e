indexing
	description: "Simple search dialog which performs searches on an EV_TEXT widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_DIALOG

inherit
	SEARCH_DIALOG_IMP
		redefine
			show_relative_to_window
		end

	SHARED_OBJECTS
		undefine
			copy, 
			default_create		
		end

create
	default_create

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			find_but.select_actions.extend (agent search)
			cancel_but.select_actions.extend (agent hide)
			search_text.key_release_actions.extend (agent key_released)
		end
	
feature -- Display

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show
		do
			Precursor (a_window)	
			search_text.set_focus
			if not search_text.text.is_empty then				
				search_text.select_all	
			end
		end		
		
feature -- Status Setting

	set_widget (a_widget: EV_TEXT) is
			-- Set `text_widget' to `a_widget'
		require
			widget_not_void: a_widget /= Void
		do
			text_widget := a_widget			
		end

feature -- Commands

	search is
			-- Search for text in 'search_text' and highlight in 
			-- `text_widget' if found.  If not found load message dialog
		local
			l_match_pos,
			l_last_position,
			l_string_length,
			l_text_length: INTEGER
			l_text,
			l_search_text: STRING
		do
			if not search_text.text.is_empty then 
				l_last_position := text_widget.caret_position
				l_string_length := search_text.text.count
				l_text_length := text_widget.text.count
				l_text := text_widget.text.substring (l_last_position, l_text_length)
				l_search_text := search_text.text.twin
				l_text.to_upper
				l_search_text.to_upper
						
				l_match_pos := l_text.substring_index (l_search_text, 1)
				
				if l_match_pos = 0 then
						-- If there was no match from the caret go back to the start
					l_last_position := 1
					l_text := text_widget.text.substring (l_last_position, l_text_length)
					l_text.to_upper
					l_match_pos := l_text.substring_index (l_search_text, 1)
				end
												
				if l_match_pos > 0 then
					l_match_pos := l_match_pos + l_last_position
					if not text_widget.has_focus then
						text_widget.set_focus
					end
					text_widget.select_region (l_match_pos - 1, l_match_pos + l_string_length - 2)
					text_widget.scroll_to_line (text_widget.current_line_number)
				end
			end
		end

feature {NONE} -- Implementation

	text_widget: EV_TEXT
			-- Widget

	start_position: INTEGER is
			-- Position from which to start search
		do
			Result := text_widget.caret_position
			if Result = 0 then
				Result := 1
			end
		end
	
	key_released (a_key: EV_KEY) is
			-- Key was released in search box
		do
			if (create {EV_KEY_CONSTANTS}).Key_enter = a_key.code and not search_text.text.is_empty then
				search
			end
		end		
	
indexing
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
end -- class SEARCH_DIALOG

