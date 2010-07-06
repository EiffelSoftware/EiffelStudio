note
	description: "[
					Close all tabs in notebook except current focused one
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLOSE_ALL_BUT_CURRENT_COMMAND

inherit
	EB_CLOSE_PANEL_COMMAND
		redefine
			menu_name,
			execute
		end

	SD_ACCESS
		export
			{NONE} all
		end

feature -- Query

	menu_name: STRING_GENERAL
			-- <Precursor>
		do
			Result := interface_names.m_close_all_but_this
		end

feature -- Command

	execute
			-- <Precursor>
		local
			l_manager: EB_EDITORS_MANAGER
			l_smart_editor: EB_SMART_EDITOR
			l_content, l_item: like current_focused_content
			l_all_contents: ARRAYED_LIST [SD_CONTENT]
			l_win: EB_DEVELOPMENT_WINDOW
		do
			l_content := current_focused_content
			if l_content /= Void then

				l_win := window_manager.last_focused_development_window
				l_all_contents := l_win.docking_manager.zones.contents_in_same_zone (l_content)
				if l_all_contents /= Void and then l_all_contents.count > 0 then
					from
						l_all_contents.start
					until
						l_all_contents.after
					loop
						l_item := l_all_contents.item
						if l_content /= l_item then
							if l_item.type = {SD_ENUMERATION}.editor then
								l_manager := l_win.editors_manager
								l_smart_editor := l_manager.editor_with_content (l_item)
								if l_smart_editor /= Void then
									l_manager.close_editor (l_smart_editor)
								else
									check not_possible: False end
								end
							elseif l_item.type = {SD_ENUMERATION}.tool then
								l_item.hide
							end
						end

						l_all_contents.forth
					end
				end

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
