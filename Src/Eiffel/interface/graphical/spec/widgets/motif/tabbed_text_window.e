indexing

	description:	
		"Text windows where tabulation characters are expanded %
			%to `tablength' blank characters. Widget that is able %
			%to edit text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	TABBED_TEXT_WINDOW

inherit

	TABBED_TEXT
		rename
			lower as lower_window,
			make as text_create,
			set_text as st_set_text,
			cursor as widget_cursor,
			set_cursor_position as st_set_cursor_position,
			set_top_character_position as st_set_top_character_position
		undefine
			is_equal, set_background_color, set_font
		redefine
			implementation
		end;

	SCROLLED_TEXT_WINDOW
		undefine 
			make_word_wrapped, text_create,
			create_ev_widget_ww, create_ev_widget,
			copy, set_tab_length
		redefine
			implementation
		end

create
	make,
	make_from_tool

feature -- Access

	implementation: TABBED_TEXT_I;

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

end -- class TABBED_TEXT_WINDOW
