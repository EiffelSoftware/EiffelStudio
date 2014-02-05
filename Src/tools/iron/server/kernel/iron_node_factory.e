note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_FACTORY

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature -- Access

	iron_node: IRON_NODE
		local
			db: IRON_NODE_DATABASE
			obs: IRON_NODE_OBSERVER
			mailer: NOTIFICATION_MAILER
			ext_mailer: NOTIFICATION_EXTERNAL_MAILER
			lay: IRON_NODE_LAYOUT
		do
			if attached execution_environment.item ({IRON_NODE_CONSTANTS}.IRON_REPO_variable_name) as s then

				create lay.make_with_path (create {PATH}.make_from_string (s))
			else
				create lay.make_default
			end
			if {PLATFORM}.is_windows then
				create ext_mailer.make (lay.binaries_path.extended ("sendmail.bat").name, Void)
				mailer := ext_mailer
			else
				create {NOTIFICATION_SENDMAIL_MAILER} mailer
			end
			create {IRON_NODE_FS_DATABASE} db.make_with_layout (lay)
			create Result.make (db, lay)
			
				-- FIXME: do not hardcode email address.
			create {IRON_NODE_MAILER_OBSERVER} obs.make_with_mailer (mailer, "jfiat@eiffel.com")
			Result.register_observer (obs)

			create {IRON_NODE_LOGGING_OBSERVER} obs.make (agent db.save_log, 1)
			Result.register_observer (obs)

			db.register_observer (Result)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
