indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WORKER_THREAD

inherit
	THREAD
		rename
			execute as execute_procedure
		end

create 

	make, make_with_procedure

feature {NONE} -- Initialization

	make, make_with_procedure (a_action: PROCEDURE [ANY, TUPLE]) is
		do
			thread_procedure := a_action
		end

feature {NONE} -- Implementation

	thread_procedure: PROCEDURE [ANY, TUPLE]

	execute_procedure is
		do
			thread_procedure.call (Void)
		end

end -- class WORKER_THREAD
