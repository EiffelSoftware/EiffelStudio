note
	description: "[
		The ecosystem's default implementation for the {CODE_ANALYZER_S} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_SESSION_STATISTICS

inherit
	PROJECT_SESSION_STATISTICS_S

	DISPOSABLE_SAFE

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Creation.

	make
			-- Initialize event service.
		do
			create project_session_statistics.make
				-- Initialize events.
				-- Initialize events.
			create update_event
			auto_dispose (update_event)
		end

feature -- Installation

	install
		do
			eiffel_project.manager.compile_stop_agents.extend (agent on_project_recompiled)
		end

feature -- Access

	project_session_statistics: EB_PROJECT_SESSION_STATISTICS

feature -- Event

	on_project_recompiled (a_is_successfull: BOOLEAN)
		local
			l_stats: like project_session_statistics
		do
			l_stats := project_session_statistics
			debug ("PROJECT_STATISTICS")
				if attached {LOGGER_S} (create {SERVICE_CONSUMER [LOGGER_S]}).service as l_logger_service then
					l_logger_service.put_message_format (
							"[
								Number of compilations: {1}
								Number of successful compilations: {2}
								Number of failed compilations: {3}
								Number of successful compilations in a row: {4}
							]", [
								l_stats.compilations,
								l_stats.successful_compilations,
								l_stats.failed_compilations,
								l_stats.consecutive_successful_compilations
							],
							{ENVIRONMENT_CATEGORIES}.compilation
						)
				end
			end

			l_stats.on_project_recompiled (a_is_successfull)
			on_update
		end

	update_event: EVENT_TYPE [TUPLE [service: PROJECT_SESSION_STATISTICS_S]]
			-- <Precursor>

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

	statistics_connection: EVENT_CONNECTION_I [PROJECT_SESSION_STATISTICS_OBSERVER, PROJECT_SESSION_STATISTICS_S]
			-- <Precursor>
		do
			Result := internal_connection
			if Result = Void then
				create {EVENT_CONNECTION [PROJECT_SESSION_STATISTICS_OBSERVER, PROJECT_SESSION_STATISTICS_S]} Result.make (
					agent (o: PROJECT_SESSION_STATISTICS_OBSERVER):
						ARRAY [TUPLE
							[event: EVENT_TYPE [PROJECT_SESSION_STATISTICS_S];
							action: PROCEDURE [PROJECT_SESSION_STATISTICS_S]]]
						do
							Result :=
								<<
									[update_event, agent o.on_update]
								>>
						end)
				automation.auto_dispose (Result)
				internal_connection := Result
			end
		end

feature {NONE} -- Events

	on_update
			-- Called after code statistics are updated.
		require
			is_interface_usable: is_interface_usable
		do
			if update_event.is_interface_usable then
				update_event.publish (Current)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_connection: detachable like statistics_connection
			-- Cached version of `statistics_connection`.
			-- Note: Do not use directly!

invariant

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
