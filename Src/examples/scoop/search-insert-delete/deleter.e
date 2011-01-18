note
	description	: "Class representing a deleter."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	DELETER

inherit
	ACTOR

create {SEARCH_INSERT_DELETE}

	make_with_list

feature {SEARCH_INSERT_DELETE} -- Basic operations

	live
			-- Live.
		do
			io.put_string (out + " created%N")
			start_delete (list)
			if randomness then
				random.forth;
				-- make some random delay to make it more real
				(create {EXECUTION_ENVIRONMENT}).sleep (random_integer (200, 500) * 1000000)
			end
			end_delete (list)
		end

feature {NONE} -- Implementation

	start_delete (a_list: separate SHARED_LIST)
			-- Start delete operation.
		require
			a_list.can_delete
		do
			io.put_string (out + " starting delete%N")
			a_list.start_delete
		end

	end_delete (a_list: separate SHARED_LIST)
			-- End delete operation.
		do
			io.put_string (out + " ending delete%N")
			a_list.end_delete
		end

feature {NONE} -- Implementation

	type: STRING = "Deleter"
			-- What's the type of this actor?

end
