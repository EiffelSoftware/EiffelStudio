indexing
	description: "[
		Interface containing a list of items of type {TAGABLE_I}
		
		Interface inherits {ACTIVE_COLLECTION_I} and extends it with
		a change event. That enabled observers to be notified also 
		when a item has modified changed in some way.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAGABLE_COLLECTION_I [G -> TAGABLE_I]

inherit
	ACTIVE_COLLECTION_I [G]

feature -- Factory

	new_filter: !FILTERED_COLLECTION_I [G]
			-- New filter connected to `Current'
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_usable: Result.is_interface_usable
			result_has_no_expression: not Result.is_expression_set
			result_connected: is_connected (Result)
		end

end
