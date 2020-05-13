note
	description: "Summary description for {IRON_NODE_LOGGING_OBSERVER}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_LOGGING_OBSERVER

inherit
	IRON_NODE_OBSERVER

create
	make

feature {NONE} -- Initialization

	make (a_logging: like logging; a_level: like level)
			-- Create logging observer using agent `a_logging' and level `a_level'.
		do
			logging := a_logging
			level := a_level
		end

	logging: PROCEDURE [IRON_NODE_LOG]

	level: NATURAL_8
			-- logging level

feature -- Log

	log_event (a_title, a_message: READABLE_STRING_32; a_type: detachable READABLE_STRING_8)
		local
			l_log: IRON_NODE_LOG
		do
			create l_log.make_now (a_title, a_message)
			if a_type /= Void then
				l_log.set_type (a_type)
			end
			logging.call ([l_log])
		end

	user_log_type: STRING = "user"

	package_log_type: STRING = "package"

	download_log_type: STRING = "download"

feature -- Event

	on_user_event (a_user: IRON_NODE_USER; a_title: READABLE_STRING_32; a_message: READABLE_STRING_32)
		do
		end

	on_user_updated (a_user: IRON_NODE_USER; flag_is_new: BOOLEAN)
		local
			l_title, l_message: STRING_32
		do
			if flag_is_new then
				l_title := {STRING_32} "New user [" + a_user.name + {STRING_32} "]"
				l_message := {STRING_32} "User [" + a_user.name + {STRING_32} "] has just been created.%N"
				log_event (l_title, l_message, user_log_type)
			else
				if attached {READABLE_STRING_GENERAL} a_user.data_item ("reset_password.url") as l_url then
					l_title := {STRING_32} "User [" + a_user.name + {STRING_32} "] requested password reset"
					l_message := l_title + {STRING_32} ".%N"
					l_message.append_string_general ("Please follow the link to login and change your password")
					l_message.append_string_general (l_url)
					l_message.append_string_general (" . %N")
					log_event (l_title, l_message, user_log_type)
				end
			end
		end

	on_package_updated (p: IRON_NODE_PACKAGE; flag_is_new: BOOLEAN)
		local
			utf: UTF_CONVERTER
			l_body: STRING_32
			l_title: STRING_32
		do
			if flag_is_new then
				l_title := {STRING_32} "[Iron] New package [" + p.human_identifier + {STRING_32} "]"
				l_body := l_title + {STRING_32} "%N"
			else
				l_title := {STRING_32} "[Iron] Updated package [" + utf.utf_32_string_to_utf_8_string_8 (p.human_identifier) + "]"
				l_body := l_title + {STRING_32} "%N"
			end
			log_event (l_title, l_body, package_log_type)
		end

	on_version_package_updated (p: IRON_NODE_VERSION_PACKAGE; flag_is_new: BOOLEAN)
		local
			l_body: STRING_32
			l_title: STRING_32
			l_version_value: READABLE_STRING_32
		do
			l_version_value := p.version.value.to_string_32
			if flag_is_new then
				l_title := {STRING_32} "[Iron:" + l_version_value + {STRING_32} "] New version package [" +  p.human_identifier + {STRING_32} "]"
				l_body := l_title + {STRING_32} "%N"
			else
				l_title := {STRING_32} "[Iron:" + l_version_value + {STRING_32} "] Updated version package [" + p.human_identifier + {STRING_32} "]"
				l_body := l_title + {STRING_32} "%N"
			end
			log_event (l_title, l_body, package_log_type)
		end

	on_version_package_downloaded (p: IRON_NODE_VERSION_PACKAGE)
			-- <Precursor>
		local
			l_body: STRING_32
			l_title: STRING_32
		do
			l_title := {STRING_32} "[Iron:"+ p.version.value.to_string_32 + {STRING_32} "] package [" +  p.human_identifier + {STRING_32} "] downloaded"
			l_body := l_title + {STRING_32} "%N"
			log_event (l_title, l_body, download_log_type)
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
