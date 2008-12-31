note
	description: "[
		Objects representing notebook widgets displayed in testing tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TESTING_TOOL_NOTEBOOK_WIDGET

inherit
	ES_NOTEBOOK_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_notebook_widget
		end

	ES_SHARED_TEST_SERVICE
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_window: like development_window)
			-- Initialize `Current'.
		require
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			development_window := a_window
			make_notebook_widget
		end

feature {NONE} -- Access

	development_window: !EB_DEVELOPMENT_WINDOW
			-- Window in which `Current' is shown

	current_window: !EV_WINDOW
			-- <Precursor>
		local
			l_result: EV_WINDOW
		do
			l_result := development_window.window
			check l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Helpers

	icon_provider: !ES_TOOL_ICONS_PROVIDER [ES_TESTING_TOOL_ICONS, ES_TESTING_TOOL]
			-- Access to the icons provided by the testing tool.
		once
			create Result.make (development_window)
		end

feature {NONE} -- Factory

	create_notebook_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
			Result.set_data (Current)
		ensure then
			data_set: Result.data = Current
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
