note
	description: "Shared dialogs for customized formatter/tool setup"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_FORMATTER_DIALOGS

inherit
	EB_SHARED_MANAGERS

	EB_METRIC_TOOL_HELPER

feature -- Access

	formatter_dialog: EB_SETUP_CUSTOMIZED_FORMATTER_DIALOG
			-- Dialog to setup customized formatters
		once
			create Result.make (agent customized_formatter_manager.formatter_descriptors)
			Result.ok_actions.extend (agent on_ok_from_formatter_dialog)
		ensure
			result_attached: Result /= Void
		end

--	tools_dialog: EB_CUSTOMIZED_TOOL_DIALOG
--			-- Dialog to setup customized tools
--		once
--			create Result.make (agent customized_tool_manager.tool_descriptors)
--			Result.ok_actions.extend (agent on_ok_from_tool_dialog)
--		ensure
--			result_attached: Result /= Void
--		end

feature -- Display

	popup_formatter_dialog (a_develop_window: EB_DEVELOPMENT_WINDOW)
			-- Popup `formatter_dialog' in `a_develop_window'.
		require
			a_develop_window_attached: a_develop_window /= Void
		do
			if not formatter_dialog.is_displayed then
				load_metrics (False, metric_names.t_loading_metrics, a_develop_window)
				formatter_dialog.show_modal_to_window (a_develop_window.window)
			end
		end

	popup_tools_dialog (a_develop_window: EB_DEVELOPMENT_WINDOW)
			-- Popup `tools_dialog' in `a_develop_window'.
		require
			a_develop_window_attached: a_develop_window /= Void
		do
--			if not tools_dialog.is_displayed then
--				tools_dialog.show_modal_to_window (a_develop_window.window)
--			end
		end

feature{NONE} -- Actions

	on_ok_from_formatter_dialog
			-- Action to be performed when "OK" button is pressed in `formatter_dialog'
		do
			if formatter_dialog.has_changed then
				customized_formatter_manager.store_descriptors (formatter_dialog.descriptors)
				reload_customized_formatter (True)
			end
		end

	on_ok_from_tool_dialog
			-- Action to be performed when "OK" button is pressed in `tool_dialog'
		do
--			if tools_dialog.has_changed then
--				customized_tool_manager.store_descriptors (tools_dialog.descriptors)
--				reload_customized_tool (True)
--				reload_customized_formatter (True)
--			end
		end

feature{NONE} -- Implementation

	reload_customized_formatter (a_force: BOOLEAN)
			-- Reload customized formatters.
			-- If `a_force' is True, load customized formatters even if they are already loaded.
		local
			l_manager: like customized_formatter_manager
			l_dev_window: EB_WINDOW
			l_window: EV_WINDOW
		do
			l_manager := customized_formatter_manager
			if a_force or else not l_manager.is_loaded then
				l_dev_window := window_manager.last_focused_development_window
				if l_dev_window /= Void then
					l_window := l_dev_window.window
				end
				l_manager.load (agent show_error_message (agent l_manager.last_error, agent l_manager.clear_last_error, l_window))
			end
		end

--	reload_customized_tool (a_force: BOOLEAN)
--			-- Reload customized tools.
--			-- If `a_force' is True, load customized tools even if they are already loaded.
--		local
--			l_manager: like customized_tool_manager
--			l_dev_window: EB_WINDOW
--			l_window: EV_WINDOW
--		do
--			l_manager := customized_tool_manager
--			if a_force or else not l_manager.is_loaded then
--				l_dev_window := window_manager.last_focused_development_window
--				if l_dev_window /= Void then
--					l_window := l_dev_window.window
--				end
--				l_manager.load (agent show_error_message (agent l_manager.last_error, agent l_manager.clear_last_error, l_window))
--			end
--		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
