indexing
	description:
		"Objects that might contain a random number generator"

	status:	"See note at end of class"
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

end -- class RANDOMIZABLE

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
