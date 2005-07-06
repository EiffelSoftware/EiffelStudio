indexing
	description: "Class simulating a resource."
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

end -- Class Resource
