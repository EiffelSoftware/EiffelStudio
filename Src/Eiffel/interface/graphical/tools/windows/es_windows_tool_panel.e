indexing
	description	: "[
		A tool to view all the opened development windows.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	ES_WINDOWS_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EB_WINDOW_MANAGER_LIST]
		redefine
			create_mini_tool_bar_items
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- User interface initialization

	build_tool_interface (a_widget: EB_WINDOW_MANAGER_LIST)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		do
		end

feature -- Access: Help

	help_context_id: !STRING_GENERAL
			-- <Precursor>
		once
			Result := "57B14A4B-8694-12F6-06C8-24411E331559"
		end

feature {NONE} -- Factory

	create_widget: EB_WINDOW_MANAGER_LIST
			-- Create a new container widget upon request.
			-- Note: You may build the tool elements here or in `build_tool_interface'
		local
			l_manager: EB_SHARED_WINDOW_MANAGER
		do
			create l_manager
			Result := l_manager.window_manager.new_widget
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
			-- No tool bar items
		end

	create_mini_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display on the window title
		do
			create Result.make (2)
			Result.put_last (develop_window.new_development_window_cmd.new_mini_sd_toolbar_item)
		ensure then
			result_attached: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
