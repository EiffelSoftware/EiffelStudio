indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class WORKER_THREAD

