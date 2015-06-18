note
	description: "Operations that may return a result and can be copied across processors."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_COMPUTATION [RESULT_TYPE -> detachable separate ANY]

inherit

	CP_DEFAULT_TASK
		redefine
			promise
		end

feature -- Access

	promise: detachable separate CP_SHARED_RESULT_PROMISE [RESULT_TYPE, CP_IMPORT_STRATEGY[RESULT_TYPE]]
			-- <Precursor>

feature -- Basic operations

	run
			-- <Precursor>
		local
			l_result: RESULT_TYPE
		do
			l_result := computed
			if attached promise as l_token then
				put_result (l_token, l_result)
			end
		end

	computed: RESULT_TYPE
			-- The computed result.
		deferred
		end

feature {CP_COMPUTATION} -- Implementation

	put_result (a_token: attached like promise; a_result: RESULT_TYPE)
			-- Put `a_result' into `a_cell'.
		do
			a_token.set_item_and_terminate (a_result)
		end

end
