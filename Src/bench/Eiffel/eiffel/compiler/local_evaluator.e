indexing
	description: "Evalauator of local type"
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_EVALUATOR 

inherit
	TYPE_EVALUATOR

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end
	
feature -- Acess

	local_name: INTEGER
			-- Local name involved in an error

	new_error: VTAT1L is
			-- New error message
		do
			create Result
		end

feature -- Settings

	set_local_name (s: INTEGER) is
			-- Assign `s' to `local_name'.
		do
			local_name := s
		end

feature -- Element change

	update (error_msg: VTAT1L) is
			-- Update error message
		do
			error_msg.set_local_name (Names_heap.item (local_name))
		end

end
