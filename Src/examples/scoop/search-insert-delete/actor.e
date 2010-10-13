indexing
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

	make_with_list (a_id: INTEGER; a_randomness: BOOLEAN; a_list: attached separate SHARED_LIST) is
			-- Creation procedure.
		do
			randomness := a_randomness
			id := a_id
			list := a_list
			create random.set_seed (a_id)
		end

feature -- Access

	out: STRING is
			-- How to print this?
		once
			Result := type + "-" + id.out
		end

feature {SEARCH_INSERT_DELETE} -- Basic operations

	live is
			-- Live.
		deferred
		end

feature {NONE} -- Implementation

	randomness: BOOLEAN

	id: INTEGER
			-- Id of the actor

	list: attached separate SHARED_LIST
			-- Reference to the separate index

	type: STRING is
			-- What's the type of this actor?
		deferred
		end

invariant

	id_positive: id > 0

	list_not_void: list /= Void

end
