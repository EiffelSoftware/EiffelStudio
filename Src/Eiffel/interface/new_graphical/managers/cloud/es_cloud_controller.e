note
	description: "Summary description for {ES_CLOUD_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_CONTROLLER

inherit
	ES_CLOUD_OBSERVER
		redefine
			on_account_logged_in,
			on_account_logged_out,
			on_account_updated,
			on_cloud_available
		end

	SHARED_ES_CLOUD_SERVICE

	EB_SHARED_WINDOW_MANAGER

feature -- Events

	on_cloud_available (a_is_available: BOOLEAN)
		do
			update_account_menu
		end

	on_account_logged_in (acc: ES_ACCOUNT)
		do
			on_account_changed (acc)
		end

	on_account_logged_out
		do
			on_account_changed (Void)
		end

	on_account_updated (acc: detachable ES_ACCOUNT)
		do
			on_account_changed (acc)
		end

feature -- Callbacks		

	on_account_changed (acc: detachable ES_ACCOUNT)
		do
			update_account_menu
		end

feature -- Operations

	update_account_menu
		local
			w: EB_DEVELOPMENT_WINDOW
		do
			if attached window_manager.development_windows as win_lst then
				across
					win_lst as ic
				loop
					w := ic.item
					w.menus.cloud_account_menu.update
					w.tools.cloud_account_tool.update
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
