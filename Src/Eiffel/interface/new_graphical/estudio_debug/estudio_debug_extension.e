note
	description: "Extension for Estudio debug menu ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESTUDIO_DEBUG_EXTENSION

feature {NONE} -- Initialization

	make (m: ESTUDIO_DEBUG_MENU) is
			-- Initialize `Current'.
		do
			estudio_debug_menu := m
		end

	estudio_debug_menu: ESTUDIO_DEBUG_MENU

feature -- Status

	is_valid: BOOLEAN
		do
			Result := not menu_path.is_empty
		end

feature -- Execution

	execute
		deferred
		end

feature -- Access

	menu_path: ARRAY [STRING]
		deferred
		ensure
			Result /= Void and then Result.count > 0
		end

	menu_root_path: ARRAY [STRING]
		require
			is_valid: is_valid
			menu_path_not_empty: not menu_path.is_empty
		do
			Result := menu_path.subarray (menu_path.lower, menu_path.upper - 1)
		ensure
			result_attached: Result /= Void
		end

	frozen menu_title: STRING
		require
			is_valid: is_valid
			menu_path_not_empty: not menu_path.is_empty
		do
			Result := menu_path [menu_path.upper]
		ensure
			result_attached: Result /= Void
		end

	frozen attach_to_menu (a_menu: EV_MENU)
		require
			is_valid: is_valid
		local
			m: EV_MENU
			t: like menu_title
		do
			m := menu_with_title (menu_root_path, a_menu)
			t := menu_title
			m.extend (new_menu_item (menu_title))
		end

feature {NONE} -- Implementation

	new_menu_item (a_title: STRING): EV_MENU_ITEM
		do
			Result := imp_new_menu_item (a_title)
		end

	frozen imp_new_menu_item (a_title: STRING): like new_menu_item
		do
			create Result.make_with_text_and_action (a_title, agent execute)
		end

	menu_with_title (a_path: ARRAY [STRING]; a_base_menu: detachable EV_MENU): detachable EV_MENU
		local
			m,sm: EV_MENU
			s: STRING
			i: INTEGER
		do
			if a_base_menu /= Void then
				m := a_base_menu
			else
				m := estudio_debug_menu
			end

			if a_path.is_empty then
				Result := m
			else
				s := a_path [a_path.lower]
				from
					m.start
				until
					m.after or sm /= Void
				loop
					if m.item.text ~ s then
						sm ?= m.item
					end
					m.forth
				end
				if sm /= Void then
					Result := menu_with_title (a_path.subarray (a_path.lower + 1, a_path.upper), sm)
				else
					from
						i := a_path.lower
					until
						i > a_path.upper
					loop
						create sm.make_with_text (a_path [i])
						m.extend (sm)
						m := sm
						i := i + 1
					end
					Result := m
				end
			end
		end

	attached_string (s: detachable STRING): STRING
		do
			if s = Void then
				Result := ""
			else
				Result := s
			end
		end

feature {NONE} -- Dialog management

	kept_dialogs: LINKED_LIST [EV_DIALOG]
		once
			create Result.make
		end

	keep_dialog (a_dlg: EV_DIALOG)
		do
			kept_dialogs.extend (a_dlg)
		end

	release_dialog (a_dlg: EV_DIALOG)
		do
			a_dlg.destroy
			kept_dialogs.prune_all (a_dlg)
		end

	window: EV_WINDOW
		do
			Result := estudio_debug_menu.window
		end

	window_manager: EB_WINDOW_MANAGER
		do
			Result := estudio_debug_menu.window_manager
		end

note
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
