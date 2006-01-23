indexing
	description:
		"Facility for generating pseudo-random numbers"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	RANDOM_NUMBER_GENERATOR

feature {NONE} -- Initialization

	random_number_generator: RANDOM
			-- Random number generator instance

	refresh_random_seed is
			-- Set new time-dependent seed.
		require
			generator_created: random_number_generator /= Void
		local
			t: TIME
		do
			create t.make_now
			random_number_generator.set_seed (t.seconds)
		end
	
			
	random: RANDOM is
			-- Random generator
		do
			if random_number_generator = Void then
				create random_number_generator.make
				refresh_random_seed
				random_number_generator.start
			end
			Result := random_number_generator
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class RANDOM_NUMBER_GENERATOR

