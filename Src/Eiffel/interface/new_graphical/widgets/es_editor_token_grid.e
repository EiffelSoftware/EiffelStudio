indexing
	description: "ES grid that enables basic preferenced editor colors."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_TOKEN_GRID

inherit
	ES_GRID
		redefine
			initialize
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_RECYCLABLE
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	initialize
			-- Initialize editor colors and sync with the editor preference.
		do
			Precursor {ES_GRID};
			set_colors_and_redraw_agent := agent set_colors_and_redraw
			preferences.editor_data.post_update_actions.extend (set_colors_and_redraw_agent)
			set_editor_colors
		end

feature {NONE} -- Memory management

	internal_recycle
			-- <precursor>
		do
			if set_colors_and_redraw_agent /= Void then
				preferences.editor_data.post_update_actions.prune_all (set_colors_and_redraw_agent)
			end
		end

feature {NONE} -- Implementation

	set_editor_colors
			-- Set editor colors.
		do
			set_background_color (preferences.editor_data.normal_background_color)
			set_focused_selection_color (preferences.editor_data.selection_background_color)
			set_non_focused_selection_color (preferences.editor_data.focus_out_selection_background_color)
			set_foreground_color (preferences.editor_data.normal_text_color)
		end

	set_colors_and_redraw
			-- Set new editor colors and redraw the grid.
		do
			set_editor_colors
			redraw
		end

	set_colors_and_redraw_agent: ?PROCEDURE [ANY, TUPLE];
			-- Saved agent to be recycled.

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

end
