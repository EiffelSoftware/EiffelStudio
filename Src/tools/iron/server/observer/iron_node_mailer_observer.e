note
	description: "Summary description for {IRON_NODE_MAILER_OBSERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_MAILER_OBSERVER

inherit
	IRON_NODE_OBSERVER

create
	make_with_mailer

feature {NONE} -- Initialization

	make_with_mailer (a_mailer: NOTIFICATION_MAILER; a_admin_email: READABLE_STRING_8)
		do
			mailer := a_mailer
			admin_email := a_admin_email
		end

	mailer: NOTIFICATION_MAILER

	admin_email: READABLE_STRING_8
			-- Administrator email

feature -- Event

	on_user_event (a_user: IRON_NODE_USER; a_title: READABLE_STRING_32; a_message: READABLE_STRING_32)
		local
			m: NOTIFICATION_EMAIL
			utf: UTF_CONVERTER
			l_title, l_message: READABLE_STRING_8
		do
			if mailer.is_available then
				l_title := utf.utf_32_string_to_utf_8_string_8 (a_title)
				l_message := utf.utf_32_string_to_utf_8_string_8 (a_message)
				if attached a_user.email as l_email then
					create m.make (admin_email,
								utf.utf_32_string_to_utf_8_string_8 (l_email),
								l_title,
								l_message
							)
					mailer.process_email (m)
				end
				create m.make (admin_email, admin_email, "[Administration]" + l_title, l_message)
				mailer.process_email (m)
			end
		end

	on_user_updated (a_user: IRON_NODE_USER; flag_is_new: BOOLEAN)
		local
			utf: UTF_CONVERTER
			l_body: STRING_32
		do
			if flag_is_new then
				create l_body.make_empty
				l_body.append ("User %"" + utf.utf_32_string_to_utf_8_string_8 (a_user.name) + "%" has just been created.%N")
				if attached {READABLE_STRING_GENERAL} a_user.data_item ("activation.url") as l_url then
					l_body.append ("Please activate your account at ")
					l_body.append_string_general (l_url)
					l_body.append (" . %N")
				elseif attached {READABLE_STRING_GENERAL} a_user.data_item ("activation.code") as l_code then
					l_body.append ("Please activate your account with code [")
					l_body.append_string_general (l_code)
					l_body.append ("] . %N")
				end
				on_user_event (a_user, "[Iron] New user [" + utf.utf_32_string_to_utf_8_string_8 (a_user.name) + "]", l_body)
			else
				create l_body.make_empty
				if attached {READABLE_STRING_GENERAL} a_user.data_item ("reset_password.url") as l_url then
					l_body.append ("User %"" + utf.utf_32_string_to_utf_8_string_8 (a_user.name) + "%" requested password reset.%N")
					l_body.append ("Please follow the link to login and change your password ")
					l_body.append_string_general (l_url)
					l_body.append (" . %N")
					on_user_event (a_user, "[Iron] User %"" + utf.utf_32_string_to_utf_8_string_8 (a_user.name) + "%" requested password reset", l_body)
				end
			end
		end

	on_package_updated (p: IRON_NODE_PACKAGE; flag_is_new: BOOLEAN)
		local
			utf: UTF_CONVERTER
			l_body: STRING
			l_title: STRING
			m: NOTIFICATION_EMAIL
		do
			if flag_is_new then
				l_title := "[Iron] New package %"" + utf.utf_32_string_to_utf_8_string_8 (p.human_identifier) + "%""
				l_body := l_title + "%N"
			else
				l_title := "[Iron] Updated package %"" + utf.utf_32_string_to_utf_8_string_8 (p.human_identifier) + "%""
				l_body := l_title + "%N"
			end
			if mailer.is_available then
				create m.make (admin_email, admin_email, l_title, l_body)
				mailer.process_email (m)
			end
		end

	on_version_package_updated (p: IRON_NODE_VERSION_PACKAGE; flag_is_new: BOOLEAN)
		local
			utf: UTF_CONVERTER
			l_body: STRING
			l_title: STRING
			m: NOTIFICATION_EMAIL
		do
			if flag_is_new then
				l_title := "[Iron:"+ p.version.value +"] New version package %"" + utf.utf_32_string_to_utf_8_string_8 (p.human_identifier) + "%""
				l_body := l_title + "%N"
			else
				l_title := "[Iron:"+ p.version.value +"] Updated version package %"" + utf.utf_32_string_to_utf_8_string_8 (p.human_identifier) + "%""
				l_body := l_title + "%N"
			end
			if mailer.is_available then
				create m.make (admin_email, admin_email, l_title, l_body)
				mailer.process_email (m)
			end
		end

	on_version_package_downloaded (p: IRON_NODE_VERSION_PACKAGE)
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
