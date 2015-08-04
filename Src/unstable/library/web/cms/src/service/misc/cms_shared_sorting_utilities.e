note
	description: "Collection of sorters to help CMS dev."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SHARED_SORTING_UTILITIES

feature -- Helpers

	string_sorter: QUICK_SORTER [READABLE_STRING_GENERAL]
			-- New string sorter.
		once
			create Result.make (create {COMPARABLE_COMPARATOR [READABLE_STRING_GENERAL]})
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
