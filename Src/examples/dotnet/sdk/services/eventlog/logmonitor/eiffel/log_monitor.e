note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	LOG_MONITOR

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
			stop: BOOLEAN
			c: INTEGER
		do
			app_name := {SYSTEM_PATH}.get_file_name (args[0])
			count := args.count - 1
			if count /= 1 then
				{SYSTEM_CONSOLE}.write_line ("Usage: {0} <log> [machine]", app_name)
				{SYSTEM_CONSOLE}.write_line
				{SYSTEM_CONSOLE}.write_line ("Please press Enter to continue...")
				{SYSTEM_CONSOLE}.read_line.do_nothing
			else
				log := args[1]
				machine := "."

				if not {EVENT_LOG}.exists (log, machine) then
					{SYSTEM_CONSOLE}.write_line ("The log does not exists!")
				else
					create event_log.make
					event_log.log := log
					event_log.machine_name := machine
					event_log.add_entry_written (create {ENTRY_WRITTEN_EVENT_HANDLER}.make (Current, $on_entry_written))
					event_log.enable_raising_events := True
					{SYSTEM_CONSOLE}.write_line ("Press 'q' to quit the sample.")
					from until {SYSTEM_CONSOLE}.read = "sds" loop --('q').code loop
						stop := {SYSTEM_CONSOLE}.read = "sds"
						{SYSTEM_THREAD}.sleep (500)
					end
				end
			end
		end

feature {NONE} -- Event handlers

	on_entry_written (sender: SYSTEM_OBJECT; e: ENTRY_WRITTEN_EVENT_ARGS)
			-- Called when an entry is added to the monitored log
		do
			 {SYSTEM_CONSOLE}.write_line ("Written: " + create {STRING}.make_from_cil (e.entry.message))
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
