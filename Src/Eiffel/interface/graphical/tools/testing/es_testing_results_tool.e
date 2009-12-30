note
	description: "[
		Shim class for EiffelStudio's testing results tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_RESULTS_TOOL

inherit
	ES_TOOL [ES_TESTING_RESULTS_TOOL_PANEL]

	ES_TOOL_ICONS_PROVIDER_I [ES_TESTING_TOOL_ICONS]
		export
			{NONE} all
		redefine
			new_icons
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := icons.general_test_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := icons.general_test_icon
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

feature -- Basic operations

	show_result (a_result: EQA_RESULT)
			-- Display details for given result.
			--
			-- `a_result': Testing result.
		require
			a_result_attached: a_result /= Void
		do
			if is_tool_instantiated then
				panel.show_result (a_result)
			end
		end

	clear
			-- Remove any result details.
		do
			if is_tool_instantiated then
				panel.clear
			end
		end

feature {NONE} -- Factory

	new_tool: ES_TESTING_RESULTS_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
		end

	new_icons: ES_TESTING_TOOL_ICONS
			-- <Precursor>
		do
			create Result.make (window.shell_tools.tool ({ES_TESTING_TOOL}), once "icons")
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "AutoTest Results"

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
