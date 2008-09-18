indexing
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
			shortcut_preference_name
		end

	ES_ERROR_LIST_COMMANDER_I
		undefine
			out
		end

create {NONE}
	default_create

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- Tool icon
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_errors_list_with_errors_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_errors_list_with_errors_icon
		end

	title: STRING_32
			-- Tool title.
			-- Note: Do not call `tool.title' as it will create the tool unnecessarly!
		do
			Result := interface_names.to_error_list_tool
		end

	shortcut_preference_name: STRING
			-- An optional shortcut preference name, for automatic preference binding.
			-- Note: The preference should be registered in the default.xml file
			--       as well as in the {EB_MISC_SHORTCUT_DATA} class.
		do
			Result := "show_errors_and_warnings_tool"
		end

feature -- Basic operations

	frozen go_to_next_error (a_cycle: BOOLEAN)
			-- Goes to next error in the list.
			--
			-- `a_cycle': Specify true to jump back to the beginning of the list when reaching the end, False to perform
			--            not action when the end has been reached.
		do
			if is_tool_instantiated then
				panel.go_to_next_error (a_cycle)
			end
		end

	frozen go_to_previous_error (a_cycle: BOOLEAN)
			-- Goes to previous error in the list.
			--
			-- `a_cycle': Specify true to jump to the end of the list when reaching the start, False to perform
			--            not action when the start has been reached.
		do
			if is_tool_instantiated then
				panel.go_to_previous_error (a_cycle)
			end
		end

	frozen go_to_next_warning (a_cycle: BOOLEAN)
			-- Goes to next warning in the list.
			--
			-- `a_cycle': Specify true to jump back to the beginning of the list when reaching the end, False to perform
			--            not action when the end has been reached.
		do
			if is_tool_instantiated then
				panel.go_to_next_warning (a_cycle)
			end
		end

	frozen go_to_previous_warning (a_cycle: BOOLEAN)
			-- Goes to previous warning in the list.
			--
			-- `a_cycle': Specify true to jump to the end of the list when reaching the start, False to perform
			--            not action when the start has been reached.
		do
			if is_tool_instantiated then
				panel.go_to_previous_warning (a_cycle)
			end
		end

feature {NONE} -- Factory

	create_tool: ES_ERROR_LIST_TOOL_PANEL
			-- Creates the tool for first use on the development `window'
		do
			create Result.make (window, Current)
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
