indexing
	description: "Object that filter out incomplete tagged assertions from a given tagged list"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASSERTION_FILTER

feature -- Filter

	filter_tagged_list (a_list: EIFFEL_LIST [TAGGED_AS]): EIFFEL_LIST [TAGGED_AS] is
			-- Filter out all incomplete tagged assertions (in form of "tag:")
			-- from `a_list', and return a list that only contains complete tagged assertions.
		do
			if a_list = Void or else a_list.is_empty then
				Result := Void
			else
				create Result.make (a_list.count)
				from
					a_list.start
				until
					a_list.after
				loop
					if a_list.item.is_complete then
						Result.extend (a_list.item)
					end
					a_list.forth
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

end
