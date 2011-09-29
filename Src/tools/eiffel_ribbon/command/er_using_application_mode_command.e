note
	description: "[
					Using Application mode way or DLL way for multi Ribbon
					Windows in one applicaiton support?
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_USING_APPLICATION_MODE_COMMAND

inherit
	ER_COMMAND

create
	make

feature {NONE} -- Initialization

	make (a_menu: EV_CHECK_MENU_ITEM)
			-- Creation method
		do
			init
			create shared_singleton
			menu_items.extend (a_menu)
		end

feature -- Command

	execute
			-- <Precursor>
		local
			l_constants: ER_MISC_CONSTANTS
			l_old_value: BOOLEAN
		do
			create l_constants
			l_old_value := l_constants.is_using_application_mode
			l_constants.set_using_application_mode (not l_old_value)

			update_gui
		end

	update_gui
			-- Update GUI with current states
		local
			l_constants: ER_MISC_CONSTANTS
		do
			if attached shared_singleton.main_window_cell.item as l_main_window then
				create l_constants
				if l_constants.is_using_application_mode then
					l_main_window.using_application_mode.enable_select
				else
					l_main_window.using_application_mode.disable_select
				end
			end
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_TOOLS
			-- Shared singleton
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
