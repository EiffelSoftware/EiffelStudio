indexing
	description: "Class simulating a resource."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	RESOURCE

create
	default_create

feature -- Implementation

	access_resource (thread_num: INTEGER) is
			-- Access to resource.
		do
			{MONITOR}.enter (Current)	-- Lock access to resource.
			
			io.put_string ("Start Resource access (Thread = " + thread_num.out + ")")
			io.put_new_line
			{SYSTEM_THREAD}.sleep (1000)
			io.put_string ("Stop Resource access (Thread = " + thread_num.out + ")")
			io.put_new_line

			{MONITOR}.exit (Current)	-- Unlock access to resource.
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


end -- Class Resource
