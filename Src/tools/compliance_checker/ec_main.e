indexing
	description: "[
		STA/MTA application entry point, required for .NET on Windows 2000.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"
	
frozen class
	EC_MAIN

inherit
	SYSTEM_OBJECT

create
	make,
	make_sta

feature {NONE} -- Initialization

	make is
			-- Launch application in default thread apartment.
		local
			l_app: EC_APPLICATION
		do
			create l_app.make_and_launch
		end

	make_sta is
			-- Launch application in a STA.
		local
			l_thread: SYSTEM_THREAD
			l_thread_start: THREAD_START
		do
			create l_thread_start.make (Current, $make)
			create l_thread.make (l_thread_start)
			l_thread.set_apartment_state (feature {APARTMENT_STATE}.sta)
			l_thread.start
			l_thread.join
		end
		
end -- class EC_MAIN
