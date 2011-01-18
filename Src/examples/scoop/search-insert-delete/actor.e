note
	description	: "Class representing a generic actor."
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

deferred class
	ACTOR

inherit
	SHARED_RANDOM
	redefine
		out
	end

feature {SEARCH_INSERT_DELETE} -- Creation procedure

	make_with_list (a_id: INTEGER; a_randomness: BOOLEAN; a_list: separate SHARED_LIST)
			-- Creation procedure.
		do
			randomness := a_randomness
			id := a_id
			list := a_list
			create random.set_seed (a_id)
		end

feature -- Access

	out: STRING
			-- How to print this?
		once
			Result := type + "-" + id.out
		end

feature {SEARCH_INSERT_DELETE} -- Basic operations

	live
			-- Live.
		deferred
		end

feature {NONE} -- Implementation

	randomness: BOOLEAN

	id: INTEGER
			-- Id of the actor

	list: separate SHARED_LIST
			-- Reference to the separate index

	type: STRING
			-- What's the type of this actor?
		deferred
		end

invariant

	id_positive: id > 0

	list_not_void: list /= Void

end
