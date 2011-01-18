note
	description	: "Class representing an inserter."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	INSERTER

inherit
	ACTOR

create {SEARCH_INSERT_DELETE}

	make_with_list

feature {SEARCH_INSERT_DELETE} -- Basic operations

	live
			-- Live.
		do
			io.put_string (out + " created%N")
			start_insert (list)
			if randomness then
				random.forth;
				-- make some random delay to make it more real
				(create {EXECUTION_ENVIRONMENT}).sleep (random_integer (200, 500) * 1000000)
			end
			end_insert (list)
		end

feature {NONE} -- Implementation

	start_insert (a_list: separate SHARED_LIST)
			-- Start an insert operation.
		require
			a_list.can_insert
		do
			io.put_string (out + " starting insert%N")
			a_list.start_insert
		end

	end_insert (a_list: separate SHARED_LIST)
			-- End an insert operation.
		do
			io.put_string (out + " ending insert%N")
			a_list.end_insert
		end

feature {NONE} -- Implementation

	type: STRING = "Inserter"
			-- What's the type of this actor?

end
