note
	description: "Object with a `filter: WSF_FILTER' feature."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FILTERED

feature {NONE} -- Initialization

	initialize_filter
			-- Initialize `filter'
		do
			create_filter
			setup_filter
		end

	create_filter
			-- Create `filter'	
		deferred
		ensure
			filter_created: filter /= Void
		end

	setup_filter
			-- Setup `filter'
		require
			filter_created: filter /= Void
		deferred
		end

	append_filter (a_filter: WSF_FILTER)
			-- Append `a_filter' to the end of the `filter' chain.
		do
			filter.append (a_filter)
		end

	append_filters (a_filters: ITERABLE [WSF_FILTER])
			-- Append collection `a_filters' of filters to the end of the `filter' chain.
		local
			f: like filter
			l_next_filter: detachable like filter
		do
			f := filter.last
			across
				a_filters as ic
			loop
				l_next_filter := ic.item
				f.set_next (l_next_filter)
				f := l_next_filter
			end
		end

feature -- Access

	filter: WSF_FILTER
			-- Filter

end
