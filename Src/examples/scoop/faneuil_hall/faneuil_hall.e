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
			-- Create and launch actors.
		local
			l_judge: separate JUDGE
			l_spectator: separate SPECTATOR
			l_spectator_index: INTEGER
			l_immigrant: separate IMMIGRANT
			l_immigrant_index: INTEGER
			l_seed: INTEGER
		do
			l_seed := (create {TIME}.make_now).seconds
			create random.set_seed (max_actors + l_seed)
			create l_judge.make_with_hall (max_actors + 1, hall)
			launch_actor (l_judge)
			across (1 |..| max_actors) as ic
			from
				l_spectator_index := 1
				l_immigrant_index := 1
			loop
				random.forth
				inspect random_integer (1, 2)
				when 1 then
					create l_spectator.make_with_hall (l_spectator_index, hall)
					l_spectator_index := l_spectator_index + 1
					launch_actor (l_spectator)
				when 2 then
					create l_immigrant.make_with_hall (l_immigrant_index, hall)
					l_immigrant_index := l_immigrant_index + 1
					launch_actor (l_immigrant)
				end
			end
		end

feature {NONE} -- Implementation

	hall: separate HALL
		once
			create Result
		end

	max_actors: INTEGER = 5
			-- Maximum number of actors

	launch_actor (a_actor: separate ACTOR)
			-- Launch the actor.
		do
			a_actor.live
		end

end
