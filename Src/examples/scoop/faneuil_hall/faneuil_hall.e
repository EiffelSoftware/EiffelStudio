note
	description	: "System's root class"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	FANEUIL_HALL

inherit
	SHARED_RANDOM

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			t_judge: separate JUDGE
			t_spectator: separate SPECTATOR
			t_immigrant: separate IMMIGRANT
			i: INTEGER
		do
			create random.set_seed (max_actors + 2)
			create t_judge.make_with_hall (max_actors + 1, hall)
			launch_actor (t_judge)
			from
				i := 1
			invariant
				min_i: i >= 1
				max_i: i <= max_actors + 1
			variant
				var_i: max_actors - i + 1
			until
				i > max_actors
			loop
				random.forth
				inspect random_integer (1, 2)
				when 1 then
					create t_spectator.make_with_hall (i, hall)
					launch_actor (t_spectator)
				when 2 then
					create t_immigrant.make_with_hall (i, hall)
					launch_actor (t_immigrant)
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	hall: separate HALL
		once
			create Result
		end

	max_actors: INTEGER = 3
			-- Maximum number of actors

	launch_actor (a_actor: separate ACTOR)
			-- Launch the actor.
		do
			a_actor.live
		end

end
