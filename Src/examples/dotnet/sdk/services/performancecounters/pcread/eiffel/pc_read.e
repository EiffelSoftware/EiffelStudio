note
	status: "See notice at end of class."
	legal: "See notice at end of class."

frozen class
	PC_READ

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main (args: ARRAY [STRING])
			-- Program entry point
		local
			count: INTEGER
			timer: SYSTEM_TIMER
		do
			count := args.count - 1
			if count /= 3 and count /= 2 then
				{SYSTEM_CONSOLE}.write_line ("Usage: {0} <object> <counter> [<instance>]", {PATH}.get_file_name ({ENVIRONMENT}.get_command_line_args.item (0)))
			else
				object_name := args[1]
				counter_name := args[2]
				if count = 3 then
					instance_name := args[3]
				else
					instance_name := {SYSTEM_STRING}.empty
				end

				if {PERFORMANCE_COUNTER_CATEGORY}.exists (object_name) then
					if {PERFORMANCE_COUNTER_CATEGORY}.counter_exists (counter_name, object_name) then
						create the_counter.make (object_name, counter_name, instance_name)
						create timer.make

						timer.add_elapsed (create {ELAPSED_EVENT_HANDLER}.make (Current, $on_timer))
						timer.interval := 500
						timer.enabled := True
						timer.auto_reset := False

						{SYSTEM_CONSOLE}.write_line ("Press 'q' and hit Enter to quit the sample.")
						from until {SYSTEM_CONSOLE}.read.to_character = 'q' loop
							{SYSTEM_THREAD}.sleep (500)
						end
					else
						{SYSTEM_CONSOLE}.write_line ("Counter '{0}' does not exist!", counter_name)
					end
				else
					{SYSTEM_CONSOLE}.write_line ("Object '{0}' does not exist!", object_name)
				end
			end
		end

feature {NONE} -- Access

	the_counter: PERFORMANCE_COUNTER

feature {NONE} -- Events

	on_timer (source: SYSTEM_OBJECT; e: ELAPSED_EVENT_ARGS)
			-- Called when a timer event is fired
		require
			the_counter_attached: the_counter /= Void
			source_attached: source /= Void
			source_is_timer: source.get_type = {SYSTEM_TIMER}
			instance_name_attached: instance_name /= Void
		local
			the_timer: SYSTEM_TIMER
			retried: BOOLEAN
		do
			if not retried then
				{SYSTEM_CONSOLE}.write ("Current value = ")
				{SYSTEM_CONSOLE}.write_line (the_counter.next_value)
			else
				{SYSTEM_CONSOLE}.write_line ("Instance '{0}' does not exists!", instance_name)
			end

			the_timer ?= source
			the_timer.enabled := True
		rescue
			retried := True
			retry
		end

feature {NONE} -- Constants

	object_name: SYSTEM_STRING
	counter_name: SYSTEM_STRING
	instance_name: SYSTEM_STRING;

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
