indexing
	description: "Applcation entry point for Skybound AutoComplete example"
	date       : "$Date$"
	revision   : "$Revision$"
	
frozen class
	STARTUP

inherit
	SYSTEM_OBJECT

create
	make,
	make_sta

feature {NONE} -- Initialization

	make is
			-- Launch application in default thread apartment.
		do
			{WINFORMS_APPLICATION}.run_form (create {FORM1})
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
		
end -- class APPLICATION_STA
