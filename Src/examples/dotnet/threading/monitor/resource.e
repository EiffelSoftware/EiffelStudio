indexing
	description: "Class simulating a resource."
	
class
	RESOURCE

create
	default_create

feature -- Implementation

	access_resource (thread_num: INTEGER) is
			-- Access to resource.
		do
			feature {MONITOR}.enter (Current)	-- lock access to resource.
			
			io.put_string ("Start Resource access (Thread = " + thread_num.out + ")")
			io.put_new_line
			feature {THREAD}.sleep_integer (1000)
			io.put_string ("Stop  Resource access (Thread = " + thread_num.out + ")")
			io.put_new_line
		end

end -- Class Resource
