note
	description: "Project extension for Estudio debug menu ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_EXTENSION_PROJECT

inherit
	ESTUDIO_DEBUG_EXTENSION
		redefine
			new_menu_item
		end

create
	make

feature -- Execution

	execute
		do
		end

	build_debug_sub_menu (a_menu: EV_MENU)
			-- Builds the debug submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: EV_MENU_ITEM
		do
			create l_menu_item.make_with_text_and_action ("Replay Backup", agent on_replay_backup)
			a_menu.extend (l_menu_item)

			a_menu.extend (create {EV_MENU_SEPARATOR})

				--| Void safe helpers
			create l_menu_item.make_with_text_and_action ("Check all routines in system", agent on_check_routines)
			a_menu.extend (l_menu_item)

				--| Interface comparer
			create l_menu_item.make_with_text_and_action ("Compare libraries", agent on_compare_library_classes)
			a_menu.extend (l_menu_item)
		end

feature {NONE} -- Actions

	on_check_routines
			-- Window that let you see all features in a system in the feature tool.
		local
			dw: EB_DEVELOPMENT_WINDOW
			feature_checker_tool: EB_FEATURE_CHECKER_TOOL
		do
			dw := window_manager.last_focused_development_window
			if dw /= Void and then dw.eiffel_project.initialized then
				feature_checker_tool := feature_checker_window.item
				if feature_checker_tool = Void then
					create feature_checker_tool.make (dw)
					feature_checker_window.put (feature_checker_tool)
				else
					feature_checker_tool.set_development_window (dw)
				end
				feature_checker_tool.show
			end
		end

	on_compare_library_classes
			-- Window that let you specify two libraries and compare their classes.
		local
			dw: EB_DEVELOPMENT_WINDOW
			compile_library_tool: EB_COMPARE_LIBRARY_CLASSES_TOOL
		do
			dw := window_manager.last_focused_development_window
			if dw /= Void and then dw.eiffel_project.initialized then
				compile_library_tool := compare_library_classes_window.item
				if compile_library_tool = Void then
					create compile_library_tool.make (dw)
					compare_library_classes_window.put (compile_library_tool)
				else
					compile_library_tool.set_development_window (dw)
				end
				compile_library_tool.show
			end
		end

	on_replay_backup
			-- Launch tool that enables us to replay precisely a backup.
		do
			replay_window.window.raise
		end

feature -- Access

	menu_path: ARRAY [STRING]
		do
			Result := <<"Project">>
		end

feature {NONE} -- Access

	feature_checker_window: CELL [EB_FEATURE_CHECKER_TOOL]
			-- Link to window
		once
			create Result.put (Void)
		ensure
			feature_checker_window_not_void: Result /= Void
		end

	compare_library_classes_window: CELL [EB_COMPARE_LIBRARY_CLASSES_TOOL]
			-- Link to window
		once
			create Result.put (Void)
		ensure
			feature_checker_window_not_void: Result /= Void
		end

	replay_window: REPLAY_BACKUP_WINDOW
			-- Replace backup window
		once
			create Result.make
		ensure
			replay_window_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	new_menu_item (a_title: STRING): EV_MENU
		do
			Result := imp_new_menu_item (a_title)
			build_debug_sub_menu (Result)
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
