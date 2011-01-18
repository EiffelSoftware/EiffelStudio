note
	description	: "Class representing a searcher."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	SEARCHER

inherit
	ACTOR

create {SEARCH_INSERT_DELETE}
	make_with_list

feature {SEARCH_INSERT_DELETE} -- Basic operations

	live
			-- Live.
		do
			io.put_string (out + " created%N")
			start_search (list)
			if randomness then
				random.forth;
				-- make some random delay to make it more real
				(create {EXECUTION_ENVIRONMENT}).sleep (random_integer (200, 500) * 1000000)
			end
			end_search (list)
		end

feature {NONE} -- Implementation

	start_search (a_list: separate SHARED_LIST)
			-- Start a search operation.
		require
			a_list.can_search
		do
			io.put_string (out + " starting search%N")
			a_list.start_search
		end

	end_search (a_list: separate SHARED_LIST)
			-- End a search operation.
		do
			io.put_string (out + " ending search%N")
			a_list.end_search
		end

feature {NONE} -- Implementation

	type: STRING = "Searcher"
			-- What's the type of this actor?

end
