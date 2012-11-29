note
	description	: "Random utility"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

deferred class
	SHARED_RANDOM

feature -- Access

	random_integer(a_min, a_max: INTEGER): INTEGER
			-- Random integer between `a_min' and `a_max'
		require
			a_max > a_min
			a_min > 0
			random /= Void
		do
			Result := a_min + (random.item \\ (a_max - a_min + 1))
		ensure
			Result >= a_min
			Result <= a_max
		end

	random: RANDOM
			-- Random sequence
		local
			l_seed: INTEGER
		once
			l_seed := ((create {TIME}.make_now).fine_seconds * 1000).truncated_to_integer
			create Result.set_seed (l_seed)
		end

end
