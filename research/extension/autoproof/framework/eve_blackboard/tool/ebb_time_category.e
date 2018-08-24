note
	description: "Summary description for {EBB_TIME_CATEGORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_TIME_CATEGORY

feature -- Access

	unknown: INTEGER = 0
			-- Unknown running time.

	immediate: INTEGER = 1
			-- Immediate running time (<20 seconds).

	short: INTEGER = 2
			-- Short running time (20 - 90 seconds).

	medium: INTEGER = 3
			-- Medium running time (90 seconds - 10 minutes).

	long: INTEGER = 4
			-- Long running time (10 minutes - 1 hour).

	very_long: INTEGER = 5
			-- Very long running time (>1 hour).

feature -- Status report

	is_valid_category (a_category: INTEGER): BOOLEAN
			-- Is `a_category' a valid category?
		do
			Result := unknown <= a_category and a_category <= very_long
		end

end
