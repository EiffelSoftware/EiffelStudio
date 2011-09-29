note
	description: "[
					Command to create a new ribbon (a new layout constructor)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_NEW_RIBBON_COMMAND


inherit
	ER_COMMAND

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			init
			create shared_singleton
		end

feature -- Command

	execute
			-- <Precursor>
		local
			layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			if attached main_window as l_win then
				if attached l_win.docking_manager as l_dock then
					create layout_constructor.make

					layout_constructor.attach_to_docking_manager (l_dock)
				end
			end
		end

	new_tool_bar_item: SD_TOOL_BAR_BUTTON
			-- Create a new tool bar item
		do
			create Result.make
			Result.set_text ("New Ribbon")
			Result.select_actions.extend (agent execute)
			tool_bar_items.extend (Result)
		end

	set_main_window (a_main_window: ER_MAIN_WINDOW)
			-- Set `main_window' with `a_main_window'
		do
			main_window := a_main_window
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_TOOLS
			-- Shared singleton

	main_window: detachable ER_MAIN_WINDOW
			-- Tool's main window

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
