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
		do
			random.forth
			spectator_count := random_integer ((max_spectators // 2), max_spectators)
			print ("Number of spectators: " + spectator_count.out + "%N")
			random.forth
			immigrant_count := random_integer ((max_immigrants // 2), max_immigrants)
			print ("Number of immigrants: " + immigrant_count.out + "%N")
			set_immigrant_count_in_hall (hall)
			create l_judge.make (hall)
			launch_judge (l_judge)
			from
				l_spectator_index := 1
				l_immigrant_index := 1
			until
				(l_spectator_index > spectator_count)
					and (l_immigrant_index > immigrant_count)
			loop
				random.forth
				inspect random_integer (1, 2)
				when 1 then
					if l_spectator_index <= spectator_count then
						create l_spectator.make (l_spectator_index, hall)
						l_spectator_index := l_spectator_index + 1
						launch_spectator (l_spectator)
					end
				when 2 then
					if l_immigrant_index <= immigrant_count then
						create l_immigrant.make (l_immigrant_index, hall)
						l_immigrant_index := l_immigrant_index + 1
						launch_immigrant (l_immigrant)
					end
				end
			end
		end

feature -- Access

	spectator_count: INTEGER
			-- Number of spectators

	immigrant_count: INTEGER
			-- Number of immigrants

feature {NONE} -- Implementation

	hall: separate HALL
		once
			create Result
		end

	Max_spectators: INTEGER = 20
			-- Maximum number of spectators

	Max_immigrants: INTEGER = 20
			-- Maximum number of immigrants

	set_immigrant_count_in_hall (a_hall: separate HALL)
			-- Set expected immigrant count in `hall'
		do
			a_hall.set_expected_immigrant_count (immigrant_count)
		end

	launch_judge (a_judge: separate JUDGE)
			-- Launch the judge.
		do
			a_judge.act
		end

	launch_immigrant (a_immigrant: separate IMMIGRANT)
			-- Launch an immigrant.
		do
			a_immigrant.act
		end

	launch_spectator (a_spectator: separate SPECTATOR)
			-- Launch a spectator.
		do
			a_spectator.act
		end

end
