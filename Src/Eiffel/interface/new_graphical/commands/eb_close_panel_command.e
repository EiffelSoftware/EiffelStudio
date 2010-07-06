note
	description: "[
					Ancestor for all closing panel/tab related commands
																		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLOSE_PANEL_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_SHARED_WINDOW_MANAGER

feature -- Query

	current_focused_content: SD_CONTENT
			-- Current focused content

feature -- Command

	set_current_focused_content (a_content: detachable SD_CONTENT)
			-- Set `current_focused_content' with `a_content'
		do
			current_focused_content := a_content
		end

feature {NONE} -- Implementation

	disable_all_focus_command
			-- Disable all close panel related commands
		local
			l_commands: ARRAYED_LIST [EB_CLOSE_PANEL_COMMAND]
			l_item: EB_CLOSE_PANEL_COMMAND
		do
			from
				l_commands := window_manager.last_focused_development_window.commands.focus_commands
				l_commands.start
			until
				l_commands.after
			loop
				l_item := l_commands.item
				l_item.set_current_focused_content (void)
				l_item.disable_sensitive

				l_commands.forth
			end
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
