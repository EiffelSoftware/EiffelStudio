note
	description: "Summary description for {REPOSITORY_LOG_GROUP_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_GROUP_FILTER

inherit
	REPOSITORY_LOG_FILTER

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			create filters.make (n)
		end

feature -- Access

	filters: ARRAYED_LIST [REPOSITORY_LOG_FILTER]

feature -- Element changes

	add_filter (f: REPOSITORY_LOG_FILTER)
		do
			filters.force (f)
		end

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		do
			from
				Result := True
				filters.start
			until
				filters.after or not Result
			loop
				Result := filters.item.matched (a_log)
				filters.forth
			end
		end

	to_string: STRING
		local
			n: INTEGER
		do
			Result := "("
			n := filters.count
			across
				filters as c
			loop
				n := n - 1
				Result.append_string (c.item.to_string)
				if n > 0 then
					Result.append_string (" + ")
				end
			end
			Result.append_string (")")
		end

end
