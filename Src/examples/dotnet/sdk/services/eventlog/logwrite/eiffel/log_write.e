note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	LOG_WRITE

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main (args: ARRAY [STRING])
			-- Program entry point
		local
			count: INTEGER
			log, source: SYSTEM_STRING
			event_log: EVENT_LOG
			retried: BOOLEAN
		do
			if not retried then
				count := args.count - 1
				if count /= 3 then
					{SYSTEM_CONSOLE}.write_line ("Usage: {0} <log> <message> <source>", {SYSTEM_PATH}.get_file_name (args[0]))
				else
					log := args[1]
					source := args[3]

						-- Create event source if it does not exists
					if create_event_source (log, source) then
						create event_log.make

						event_log.source := source
						if {SYSTEM_STRING}.compare (event_log.log, log, True, {CULTURE_INFO}.invariant_culture) /= 0 then
							{SYSTEM_CONSOLE}.write_line ("Some other application is using the source!")
						else
							event_log.write_entry (args[2], {EVENT_LOG_ENTRY_TYPE}.information)
							{SYSTEM_CONSOLE}.write_line ("Entry written succesfully!")
						end
					end
				end
			else
				{SYSTEM_CONSOLE}.write_line ("In order to execute this sample you must have permission to write to the system log.")
			end

			{SYSTEM_CONSOLE}.write_line
			{SYSTEM_CONSOLE}.write_line ("Please press Enter to continue...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
		rescue
			if {ISE_RUNTIME}.last_exception.get_type = {SECURITY_EXCEPTION} then
				retried := True
				retry
			end
		end

feature {NONE} -- Basic operations

	create_event_source (log, source: SYSTEM_STRING): BOOLEAN
			-- Creates an event source
		require
			not_log_is_empty: not {SYSTEM_STRING}.is_null_or_empty (log)
			not_source_is_empty: not {SYSTEM_STRING}.is_null_or_empty (source)
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := True
				if not {EVENT_LOG}.source_exists (source) then
					{EVENT_LOG}.create_event_source (source, log)
				end
			else
				Result := False
				{SYSTEM_CONSOLE}.write_line ("In order to execute this sample you must have permission to write to the system log.")
			end
		rescue
			if {ISE_RUNTIME}.last_exception.get_type = {SECURITY_EXCEPTION} then
				retried := True
				retry
			end
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software/Microsoft Corporation. All rights reserved."
	license: "[
			This file is part of the Microsoft .NET Framework SDK Code Samples.

			This source code is intended only as a supplement to Microsoft
			Development Tools and/or on-line documentation.  See these other
			materials for detailed information regarding Microsoft code samples.

			THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
			KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
			IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
			PARTICULAR PURPOSE.
		]"


end
