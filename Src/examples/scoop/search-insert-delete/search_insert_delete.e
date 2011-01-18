note
	description	: "System's root class"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	SEARCH_INSERT_DELETE

inherit
	SHARED_RANDOM

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			-- actors(searchers, inserters, deleters)
			t_searcher: separate SEARCHER
			t_inserter: separate INSERTER
			t_deleter: separate DELETER
			i: INTEGER
		do
			create random.set_seed (max_actors + 1)
			-- Generate and launch actors
			from
				i := 1
			invariant
				i >= 1
				i <= max_actors + 1
			variant
				max_actors - i + 1
			until
				i > max_actors
			loop
				random.forth
				-- Decide which actor will be generated
				inspect random_integer (1, 3)
				when 1 then
					create t_searcher.make_with_list (i, randomness, list)
					launch_actor (t_searcher)
				when 2 then
					create t_inserter.make_with_list (i, randomness, list)
					launch_actor (t_inserter)
				when 3 then
					create t_deleter.make_with_list (i, randomness, list)
					launch_actor (t_deleter)
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	list: separate SHARED_LIST
			-- Reference to the separate list
		once
			create Result
		end

	max_actors: INTEGER = 30
			-- Maximum number of actors

	launch_actor (a_actor: separate ACTOR)
			-- Launch the actor.
		do
			a_actor.live
		end

	randomness: BOOLEAN = False

end
