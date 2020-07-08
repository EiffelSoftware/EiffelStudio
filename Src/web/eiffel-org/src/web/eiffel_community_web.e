note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_WEB

inherit
	WSF_LAUNCHABLE_SERVICE
		rename
			make_and_launch as make_and_launch_service
		redefine
			initialize
		end

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

	SHARED_LOGGER

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		do
			create launcher
			make_and_launch_service
		end

	initialize
			-- Initialize current service.
		local
			env: CMS_ENVIRONMENT
		do
			Precursor
			-- Default listening port for standalone|nino connector: 9090
			set_service_option ("port", 9090)

				-- Options can be set in ewf.ini config file		
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("ewf.ini")
			create env.make_default
			env.set_name ("eiffel_org")
			initialize_logger (env)
		end

feature {NONE} -- Launch operation

	launcher: APPLICATION_LAUNCHER [EIFFEL_COMMUNITY_WEB_EXECUTION]

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			l_retry: BOOLEAN
			l_message: STRING
		do
			if not l_retry then
				launcher.launch (opts)
			else
					-- error hanling.
				create l_message.make (1024)
				if attached (create {EXCEPTION_MANAGER}).last_exception as l_exception then
					if attached l_exception.description as l_description then
						l_message.append (l_description.as_string_32)
						l_message.append ("%N%N")
					elseif attached l_exception.trace as l_trace then
						l_message.append (l_trace)
						l_message.append ("%N%N")
					else
						l_message.append (l_exception.out)
						l_message.append ("%N%N")
					end
				else
					l_message.append ("The application crash without available information")
					l_message.append ("%N%N")
				end
				-- send email shutdown
			end
		rescue
			l_retry :=  True
			retry
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

