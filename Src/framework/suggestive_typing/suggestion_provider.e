note
	description: "Ancestor to all suggestion provider that given an expression returns a list of suggestion items matching that expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SUGGESTION_PROVIDER

feature -- Access

	query (a_expression: READABLE_STRING_GENERAL; a_termination: detachable PROCEDURE): ARRAYED_LIST [SUGGESTION_ITEM]
			-- Given a query `a_expression', provides a list of possible associated items.
			-- When list is fully built, `a_termination' will be called.
		require
			is_available: is_available
		do
			Result := query_with_cancellation (a_expression, a_termination, Void)
		end

	query_with_cancellation (a_expression: READABLE_STRING_GENERAL; a_termination: detachable PROCEDURE; a_cancel_request: detachable PREDICATE): like query
			-- Given a query `a_expression', provides a list of possible associated items up to the point where
			-- `a_cancel_request' returns True.
			-- When list is fully built, `a_termination' will be called regardless of the cancellation of the query.
		require
			is_available: is_available
		do
			create Result.make (1)
			query_with_callback_and_cancellation (a_expression, Void, agent (a_list: like query; a_suggestion: SUGGESTION_ITEM)
				do
					a_list.extend (a_suggestion)
				end (Result, ?), a_cancel_request)
		end

	query_with_callback_and_cancellation (a_expression: READABLE_STRING_GENERAL; a_termination: detachable PROCEDURE; a_callback: PROCEDURE [SUGGESTION_ITEM]; a_cancel_request: detachable PREDICATE)
			-- Given a query `a_expression', and for each result execute `a_callback' until all results have been
			-- obtained or if `a_cancel_request' returns True.
			-- When list is fully built, `a_termination' will be called regardless of the cancellation of the query.
		require
			is_available: is_available
		deferred
		end

feature -- Status Report

	is_concurrent: BOOLEAN
			-- Can `Current' be executed in a different thread/processor?
		deferred
		end

	is_available: BOOLEAN
			-- Is current able to serve a new query?
		deferred
		end

invariant

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
