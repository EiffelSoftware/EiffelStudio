indexing
	description:
		"Facility for generating pseudo-random numbers"

	status:	"See note at end of class"
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

end -- class RANDOM_NUMBER_GENERATOR

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
