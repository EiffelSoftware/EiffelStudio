indexing
	description:
		"Objects that might contain a random number generator"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	RANDOMIZABLE

feature -- Access

	seed: INTEGER is
			-- Random seed
		require
			has_generator: has_random_generator
		deferred
		end
	 
feature -- Status report

	has_random_generator: BOOLEAN is
			-- Does current object have access to a random number generator?
		deferred
		end
	 
feature -- Status setting

	set_seed (s: INTEGER) is
			-- Set seed to `s'.
		require
			has_generator: has_random_generator
			non_negative_seed: s >= 0
		deferred
		ensure
			seed_set: seed = s
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




end -- class RANDOMIZABLE

