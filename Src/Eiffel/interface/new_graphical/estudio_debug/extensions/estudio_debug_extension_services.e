note
	description: "Services extension for Estudio debug menu ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_EXTENSION_SERVICES

inherit
	ESTUDIO_DEBUG_EXTENSION
		redefine
			new_menu_item
		end

	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
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
			create l_menu_item.make_with_text_and_action ("Save preferences", agent on_save_preferences)
			a_menu.extend (l_menu_item)

			create l_menu_item.make_with_text_and_action ("Save All Session Data", agent on_save_session_data)
			a_menu.extend (l_menu_item)
			if session_manager.service = Void then
				l_menu_item.disable_sensitive
			end

			create l_menu_item.make_with_text_and_action ("Restore All Session Data", agent on_restore_session_data)
			a_menu.extend (l_menu_item)
			if session_manager.service = Void then
				l_menu_item.disable_sensitive
			end

			a_menu.extend (create {EV_MENU_SEPARATOR})
			create l_menu_item.make_with_text_and_action ("Export/Import Tabs ...", agent on_export_import_tabs)
			a_menu.extend (l_menu_item)
			if session_manager.service = Void then
				l_menu_item.disable_sensitive
			end
			a_menu.extend (create {EV_MENU_SEPARATOR})

			create l_menu_item.make_with_text_and_action ("Rescan Code Template Catalog", agent on_rescan_code_template_catalog)
			a_menu.extend (l_menu_item)
			if code_template_catalog.service = Void then
				l_menu_item.disable_sensitive
			end
		end

feature {NONE} -- Actions

	on_save_preferences
			-- Immediatly saves all the preferences.
		do
			if attached preferences as prefs then
				prefs.preferences.save_preferences
			end
		end

	on_save_session_data
			-- Immediatly saves all the session data.
		require
			is_service_available: session_manager.service /= Void
		do
			session_manager.service.store_all
		end

	on_restore_session_data
			-- Immediatly restores all the session data to the last saved state.
		require
			is_service_available: session_manager.service /= Void
		do
			session_manager.service.active_sessions.do_all (agent (session_manager.service).reload)
		end

	on_rescan_code_template_catalog
			-- Rescans the code template catalog to retrieve updated templates and any new templates.
		require
			is_service_available: code_template_catalog.service /= Void
		local
			l_window: ES_POPUP_TRANSITION_WINDOW
		do
			create l_window.make_with_icon (
				("Scanning catalog for changes...").as_string_32,
				(create {EB_SHARED_PIXMAPS}).icon_pixmaps.tool_search_icon_buffer)
			l_window.set_action (agent do
					code_template_catalog.service.rescan_catalog
					es_code_template_catalog.service.rescan_catalog
				end)
			l_window.show_relative_to_window (window)
		end

feature {NONE} -- Tabs operations

	on_export_import_tabs
		local
			dlg: ES_TABS_EXPORT_IMPORT_DIALOG
		do
			create dlg.make (window_manager)
			dlg.set_title_and_label ("Open editor tabs", "Share open editor tabs ...")
			dlg.set_is_modal (False)
			dlg.show_on_active_window
		end

feature {NONE} -- Services

	frozen session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service
		once
			create Result
		ensure
			result_attached: attached Result
		end

	frozen code_template_catalog: SERVICE_CONSUMER [CODE_TEMPLATE_CATALOG_S]
			-- Access to the code template catalog service
		once
			create Result
		ensure
			result_attached: attached Result
		end

	frozen es_code_template_catalog: SERVICE_CONSUMER [ES_CODE_TEMPLATE_CATALOG_S]
			-- Access to the code template catalog service
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature -- Access

	menu_path: ARRAY [STRING]
		do
			Result := <<"Services">>
		end

feature {NONE} -- Implementation

	new_menu_item (a_title: STRING): EV_MENU
		do
			Result := imp_new_menu_item (a_title)
			build_debug_sub_menu (Result)
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
