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
			-- What's the current random integer between a_min and a_max?
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
			-- Reference to the random number generator

end
