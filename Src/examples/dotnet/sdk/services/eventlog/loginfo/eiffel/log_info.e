note
	status: "See notice at end of class."
	legal: "See notice at end of class."
	
class
	LOG_INFO

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main (args: ARRAY [STRING])
			-- Program entry point
		local
			app_name: SYSTEM_STRING
			count: INTEGER
			log, machine: SYSTEM_STRING
			event_log: EVENT_LOG
			entry: EVENT_LOG_ENTRY
			enum: IENUMERATOR
		do
			app_name := {PATH}.get_file_name (args[0])
			count := args.count - 1
			if count /= 1 and count /= 2 then
				{SYSTEM_CONSOLE}.write_line ("Usage: {0} <log> [machine]", app_name)
			else
				log := args[1]
				if count = 2 then
					machine := args[2]
				else
					machine := "." -- local machine
				end

				if not {EVENT_LOG}.exists (log, machine) then
					{SYSTEM_CONSOLE}.write_line ("The log does not exists!")
				else
					create event_log.make
					event_log.log := log
					event_log.machine_name := machine
					{SYSTEM_CONSOLE}.write_line ("There are {0} entry[y|ies] in the log", event_log.entries.count)
					from enum := event_log.entries.get_enumerator until not enum.move_next loop
						entry ?= enum.current_
						check entry_attached: entry /= Void end
						{SYSTEM_CONSOLE}.write_line ("%TEntry: {0}", entry.message)
					end
				end
			end
			{SYSTEM_CONSOLE}.write_line
			{SYSTEM_CONSOLE}.write_line ("Please press Enter to continue...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
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
