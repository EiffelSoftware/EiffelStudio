note
	description: "[
		Tool descriptor for EiffelStudio's errors and warnings reporting tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

frozen class
	ES_ERROR_LIST_TOOL

inherit
	ES_TOOL [ES_ERROR_LIST_TOOL_PANEL]
		redefine
			shortcut_preference_name,
			is_tool_instantiated_immediate
		end

	ES_ERROR_LIST_COMMANDER_I
		undefine
			out
		end

create {NONE}
	default_create

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_errors_list_with_errors_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_errors_list_with_errors_icon
		end

	title: attached STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

	shortcut_preference_name: attached STRING
			-- <Precursor>
		do
			Result := "show_errors_and_warnings_tool"
		end

feature {ES_DOCKABLE_TOOL_PANEL} -- Status report

	is_tool_instantiated_immediate: BOOLEAN = True
			-- <Precursor>

feature -- Basic operations

	frozen go_to_next_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_tool_instantiated then
				panel.go_to_next_error (a_cycle)
			end
		end

	frozen go_to_previous_error (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_tool_instantiated then
				panel.go_to_previous_error (a_cycle)
			end
		end

	frozen go_to_next_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_tool_instantiated then
				panel.go_to_next_warning (a_cycle)
			end
		end

	frozen go_to_previous_warning (a_cycle: BOOLEAN)
			-- <Precursor>
		do
			if is_tool_instantiated then
				panel.go_to_previous_warning (a_cycle)
			end
		end

feature {NONE} -- Factory

	new_tool: attached ES_ERROR_LIST_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "Error List"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
