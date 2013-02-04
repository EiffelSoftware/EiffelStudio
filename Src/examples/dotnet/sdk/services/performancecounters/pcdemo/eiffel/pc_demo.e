note
	status: "See notice at end of class."
	legal: "See notice at end of class."

frozen class
	PC_DEMO

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main (args: ARRAY [STRING])
			-- Program entry point
		local
			arg: SYSTEM_STRING
			cont: BOOLEAN
			command: CHARACTER
			timer: SYSTEM_TIMER
		do
			cont := args.count <= 1
			if not cont then
				arg := args.item (1)
				if arg.starts_with ("/inst") then
					cont := install_counters
					if cont then
						{SYSTEM_CONSOLE}.write_line ("Continuing with sample...")
						{SYSTEM_CONSOLE}.write_line
					end
				elseif arg.starts_with ("/del") then
					delete_counters
				else
					show_usage
				end
			end

			if cont then
				if create_counter then
					create timer.make
					timer.add_elapsed (create {ELAPSED_EVENT_HANDLER}.make (Current, $on_timer))
					timer.interval := 100
					timer.enabled := True
					timer.auto_reset := False

					{SYSTEM_CONSOLE}.write_line ("Press '+' to increase the interval")
					{SYSTEM_CONSOLE}.write_line ("Press '-' to decrease the interval")
					{SYSTEM_CONSOLE}.write_line ("Press 'q' to quite the sample")
					{SYSTEM_CONSOLE}.write_line ("Started")

					from until command = 'q' loop
						command := {SYSTEM_CONSOLE}.read.to_character
						if command = '+' then
							timer.interval := (timer.interval / 2).max (1)
						elseif command = '-' then
							timer.interval := timer.interval * 2
						end

						{SYSTEM_THREAD}.sleep (500)
					end
				end
			end
		end

	install_counters: BOOLEAN
			-- Returns True if we install the counters
		local
			ccd: COUNTER_CREATION_DATA
			ccds: COUNTER_CREATION_DATA_COLLECTION
			retried: BOOLEAN
		do
			if not retried then
				if  not{PERFORMANCE_COUNTER_CATEGORY}.exists (object_name) then
					{SYSTEM_CONSOLE}.write_line ("Installing category - " + create {STRING}.make_from_cil (object_name))
					create ccd.make
					ccd.counter_name := counter_name
					ccd.counter_type := {PERFORMANCE_COUNTER_TYPE}.rate_of_counts_per_second_32
					create ccds.make
					ccds.add (ccd).do_nothing
					{PERFORMANCE_COUNTER_CATEGORY}.create_ (object_name, "Sample Object", {PERFORMANCE_COUNTER_CATEGORY_TYPE}.unknown, ccds).do_nothing
					{SYSTEM_CONSOLE}.write_line ("Category has been successfully installed.")
					Result := True
				else
					{SYSTEM_CONSOLE}.write_line ("Category already installed!   ")
				end
			elseif {ISE_RUNTIME}.last_exception.get_type = {UNAUTHORIZED_ACCESS_EXCEPTION} then
				{SYSTEM_CONSOLE}.write_line ("You must have Administrator prevelages to run this sample.")
			end
		rescue
			retried := True
			retry
		end

	create_counter: BOOLEAN
			-- Creates a performance counter and assigns `the_counter'
		local
			retried: BOOLEAN
		do
			if not retried then
				create the_counter.make (object_name, counter_name, instance_name, False)
				Result := True
			else
				the_counter := Void
				Result := False

				{SYSTEM_CONSOLE}.write_line ("The performance counters are not installed.")
				{SYSTEM_CONSOLE}.write_line ("Please use '/inst' to install them.")
				{SYSTEM_CONSOLE}.write_line
				show_usage
			end
		ensure
			the_counter_attached: Result implies the_counter /= Void
		rescue
			retried := True
			retry
		end

feature {NONE} -- Clean up

	delete_counters
			-- Removes installed counters
		local
			retried: BOOLEAN
		do
			if not retried then
				if {PERFORMANCE_COUNTER_CATEGORY}.exists (object_name) then
					{PERFORMANCE_COUNTER_CATEGORY}.delete (object_name)
					{SYSTEM_CONSOLE}.write_line ("Category has been successfully deleted!   ")
				else
					{SYSTEM_CONSOLE}.write_line ("Category not installed!   ")
				end
			elseif {ISE_RUNTIME}.last_exception.get_type = {UNAUTHORIZED_ACCESS_EXCEPTION} then
				{SYSTEM_CONSOLE}.write_line ("You must have Administrator prevelages to run this sample.")
			end
		rescue
			retried := True
			retry
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
		local
			the_timer: SYSTEM_TIMER
			retried: BOOLEAN
		do
			if not retried then
				the_counter.increment.do_nothing
				the_timer ?= source
				the_timer.enabled := True
			else
				{SYSTEM_CONSOLE}.write_line ("You must have Administrator prevelages to run this sample.")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Output

	show_usage
			-- Show usage information
		local
			app_name: SYSTEM_STRING
		do
			app_name := {SYSTEM_PATH}.get_file_name ({ENVIRONMENT}.get_command_line_args.item (0))

			{SYSTEM_CONSOLE}.write_line ("Usage")
			{SYSTEM_CONSOLE}.write_line ("-----")
			{SYSTEM_CONSOLE}.write_line ("To install perf counter {0}: {1} /inst", object_name, app_name)
			{SYSTEM_CONSOLE}.write_line ("To apply changes to perf counter {0}: {1}", object_name, app_name)
			{SYSTEM_CONSOLE}.write_line ("To delete perf counter {0}: {1} /del", object_name, app_name)
		end

feature {NONE} -- Constants

	object_name: SYSTEM_STRING = "ACounterDemo"
	counter_name: SYSTEM_STRING = "CounterPerSecond"
	instance_name: SYSTEM_STRING = "_Total";

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
