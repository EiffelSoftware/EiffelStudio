note
	status: "See notice at end of class."
	legal: "See notice at end of class."
	
	dotnet_constructors:
		make

class
	SIMPLE_SERVICE

inherit
	SERVICE_BASE
		rename
			make as make_base
		redefine
			dispose_boolean,
			on_start,
			on_stop,
			on_continue,
			on_pause
		end

create {NONE}
	main

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize new simple service
		do
			initialize_component
		end

	initialize_component
			-- Required method for Designer support - do not modify
			-- the content of this method will the code editor.
		do
			create timer.make;
			(({ISUPPORT_INITIALIZE}) #? timer).begin_init
			--
			-- timer
			--
			timer.enabled := True
			timer.interval := 1000
			timer.add_elapsed (create {ELAPSED_EVENT_HANDLER}.make (Current, $on_timer))
			set_can_pause_and_continue (True)
			set_service_name (simple_service_name)
			(({ISUPPORT_INITIALIZE}) #? timer).end_init
		end

feature {NONE} -- Entry

	main
			-- Program entry point
		local
			services_to_run: NATIVE_ARRAY [SERVICE_BASE]
		do
				-- More than one user Service may run within the same process. To add
				-- another service to this process, change the following line to
				-- create a second service object. For example,
				--
				--    services_to_run := <<create {SERVICE_1}.make, create {MY_SECOND_USER_SERVICE}.make>>
				--
			services_to_run := ({ARRAY [SERVICE_BASE]}) [<<create {SIMPLE_SERVICE}.make>>]
			{SERVICE_BASE}.run (services_to_run)
		end

feature {NONE} -- Clean up

	dispose_boolean (disposing: BOOLEAN)
			-- Clean up any resource being used
		do
			if disposing then
				if components /= Void then
					components.dispose
				end
			end
			Precursor {SERVICE_BASE} (disposing)
		end

feature -- Access

	simple_service_name: SYSTEM_STRING = "Hello-World Service"

feature {NONE} -- Access

	timer: SYSTEM_TIMER
	components: SYSTEM_CONTAINER
	installer: PROJECT_INSTALLER

feature {SIMPLE_SERVICE} -- Events

	on_start (args: NATIVE_ARRAY [SYSTEM_STRING])
			-- Called when service is started
		do
			event_log.write_entry (simple_service_name + " started")
			timer.enabled := True
		end

	on_stop
			-- Called when service is stopped
		do
			event_log.write_entry (simple_service_name + " stopped")
			timer.enabled := False
		end

	on_continue
			-- Called when service is continued
		do
			event_log.write_entry (simple_service_name + " continued")
			timer.enabled := True
		end

	on_pause
			-- Called when service is paused
		do
			event_log.write_entry (simple_service_name + " paused")
			timer.enabled := False
		end

	on_timer (source: SYSTEM_OBJECT; e: ELAPSED_EVENT_ARGS)
			-- Called when `timer' expires
		do
			event_log.write_entry ("Hello World")
		end

invariant
	timer_attached: timer /= Void

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
