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

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

