note
	description: "Summary description for {ES_CLOUD_ACCOUNT_MENU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ACCOUNT_MENU

inherit
	EV_MENU

	EB_RECYCLABLE
		undefine
			is_equal, default_create, copy
		end

	SHARED_ES_CLOUD_NAMES
		undefine
			is_equal, default_create, copy
		end

create
	make

feature {NONE} -- Initialize

	make (a_cloud_service: ES_CLOUD_S; a_text: READABLE_STRING_GENERAL; a_win: EB_DEVELOPMENT_WINDOW)
		do
			es_cloud := a_cloud_service
			develop_window := a_win
			make_with_text (a_text)
			disable_sensitive
		end

	es_cloud: ES_CLOUD_S

	develop_window: EB_DEVELOPMENT_WINDOW

feature -- Operation

	update
		local
			l_acc_menu_item: EB_COMMAND_MENU_ITEM
			mi: EV_MENU_ITEM
			t: EV_TIMEOUT
			acc: detachable ES_ACCOUNT
			cld: like es_cloud
		do
			wipe_out
			enable_sensitive

			cld := es_cloud

			l_acc_menu_item := develop_window.show_cloud_account_cmd.new_menu_item
			auto_recycle (l_acc_menu_item)
			extend (l_acc_menu_item)
			l_acc_menu_item.disable_sensitive

			if cld.is_available then
				acc := cld.active_account
				if acc /= Void then
						-- Show profile
					l_acc_menu_item.set_text (cloud_names.menu_my_account (acc.username))
					l_acc_menu_item.enable_sensitive

					create mi.default_create
					auto_recycle (mi)
					extend (mi)
					mi.set_text ("Sign out ...")
					mi.select_actions.extend (agent cld.sign_out)
				elseif cld.is_guest then
						-- Show profile
					l_acc_menu_item.set_text (cloud_names.menu_guest_account)
					l_acc_menu_item.enable_sensitive
				else
						-- Show profile
					l_acc_menu_item.set_text (cloud_names.menu_sign_in)
					l_acc_menu_item.enable_sensitive
				end
			else
					-- Try again	 ?
				create t
				t.actions.extend (agent cld.check_cloud_availability)
--					t.actions.extend (agent update)
				t.actions.extend (agent t.destroy)
				t.set_interval (60 * 1_000) -- 60 * 1000 ms

					-- Check availability
				create mi.make_with_text (cloud_names.menu_check)
				mi.select_actions.extend (agent t.destroy)
				mi.select_actions.extend (agent cld.check_cloud_availability)
				auto_recycle (mi)
				extend (mi)
			end
		end

feature {NONE} -- Clean up		

	internal_recycle
			-- To be called when the menu becomes useless.
		do
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
