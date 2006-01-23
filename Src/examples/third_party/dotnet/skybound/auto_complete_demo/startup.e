indexing
	description: "Applcation entry point for Skybound AutoComplete example"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class APPLICATION_STA
