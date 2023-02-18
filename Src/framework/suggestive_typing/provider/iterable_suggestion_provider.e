note
	date: "$Date$"
	revision: "$Revision$"

class
	ITERABLE_SUGGESTION_PROVIDER [G -> READABLE_STRING_GENERAL]

inherit
	SUGGESTION_PROVIDER

create
	make

feature {NONE} -- Initialization

	make (a_data: ITERABLE [G])
			-- Initialize storage of current with `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature -- Query

	query_with_callback_and_cancellation (a_expression: READABLE_STRING_GENERAL; a_termination: detachable PROCEDURE; a_callback: PROCEDURE [SUGGESTION_ITEM]; a_cancel_request: detachable PREDICATE)
			-- <Precursor>
		do
			if a_cancel_request /= Void then
				across data as l_data until a_cancel_request.item (Void) loop
					a_callback.call ([create {LABEL_SUGGESTION_ITEM}.make (l_data)])
				end
			else
				across data as l_data loop
					a_callback.call ([create {LABEL_SUGGESTION_ITEM}.make (l_data)])
				end
			end
			if a_termination /= Void then
				a_termination.call (Void)
			end
		end

feature -- Status report

	is_concurrent: BOOLEAN = False
			-- No concurrency allowed here.

	is_available: BOOLEAN = True
			-- Can current perform a query?

feature {NONE} -- Implementation

	data: ITERABLE [G]
			-- Storage for data.

	index: INTEGER
			-- Index of data.

invariant

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

