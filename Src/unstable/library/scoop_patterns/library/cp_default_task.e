note
	description: "A normal CP_TASK with a promise attribute."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_DEFAULT_TASK

inherit
	CP_TASK

feature -- Access

	promise: detachable separate CP_SHARED_PROMISE
			-- <Precursor>

feature -- Element change

	set_promise (a_promise: like promise)
			-- <Precursor>
		do
			promise := a_promise
		end
end
