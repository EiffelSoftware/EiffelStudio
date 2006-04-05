indexing
	description: "Event manager, used to raise and handle errors, warnings and informational events"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EVENT_MANAGER

inherit
	CODE_CONFIGURATION
		export
			{NONE} all
		end

feature -- Basic Operations

	raise_event (an_id: INTEGER; a_context: TUPLE) is
			-- Raises event with id `an_id' and given context.
			-- Actual behavior is dictated by configuration file.
		local
			l_events: CODE_EVENTS
			l_event: CODE_EVENT
		do
			create l_events
			if not l_events.is_event_id (an_id) then
				raise_event ({CODE_EVENTS_IDS}.Invalid_event_identifier, [an_id.out])
			elseif not l_events.is_valid_context (an_id, a_context) then
				raise_event ({CODE_EVENTS_IDS}.Invalid_event_context, [l_events.event_name (an_id), a_context.count.out, l_events.event_arguments_count (an_id).out])
			else
				create l_event.make (an_id, a_context)
				if l_event.is_error then
					if fail_on_error then
						(create {EXCEPTIONS}).raise (l_event.message)
					elseif log_level > No_log then
						log (l_event)
					end
				elseif l_event.is_warning then
					if log_level > Default_log then
						log (l_event)
					end
				else
					if log_level = Full_log then
						log (l_event)
					end
				end
			end
		end

	process_exception is
			-- Log last raised exception or stop execution
			-- depending on configuration.
		do
			raise_event ({CODE_EVENTS_IDS}.Rescued_exception, [{ISE_RUNTIME}.last_exception])
		end

feature {NONE} -- Implementation

	source_ready: BOOLEAN
			-- Is logging source ready?
			-- i.e. do we have access rights to log?

	log (an_event: CODE_EVENT) is
			-- Log `an_event' to windows event log
		require
			non_void_event: an_event /= Void
		local
			l_event_log: SYSTEM_DLL_EVENT_LOG
			l_event_type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE
		do
			check_source
			if source_ready then
				create l_event_log.make
				l_event_log.set_source (log_source_name)
				l_event_log.set_machine_name (log_server_name)
				l_event_log.set_log (log_name)
				if an_event.is_error then
					l_event_type := {SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE}.error
				elseif an_event.is_warning then
					l_event_type := {SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE}.warning
				else
					l_event_type := {SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE}.information
				end
				l_event_log.write_entry (an_event.message, l_event_type, an_event.id)
				l_event_log.close
			end
		end
	
	check_source is
			-- Create event source if not already created.
		local
			l_retried: BOOLEAN
		once
			source_ready := not l_retried
			if not l_retried then
				if not {SYSTEM_DLL_EVENT_LOG}.source_exists (log_source_name) then
					{SYSTEM_DLL_EVENT_LOG}.create_event_source (log_source_name, log_name)
				end
			end
		rescue
			l_retried := True
			retry
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


end -- class CODE_ERROR_MANAGER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------