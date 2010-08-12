note
	description: "Summary description for {REPOSITORY_LOG_GROUP_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_GROUP_OR_FILTER

inherit
	REPOSITORY_LOG_GROUP_FILTER
		redefine
			matched, to_string
		end

create
	make

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		do
			from
				filters.start
			until
				filters.after
			loop
				Result := Result or filters.item.matched (a_log)
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
					Result.append_string (" | ")
				end
			end
			Result.append_string (")")
		end

end
