indexing

	description: "Shared Degrees during Eiffel compilation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_DEGREES

feature {NONE} -- Access

	Degree_5: DEGREE_5 is
			-- Degree 5
		once
			create Result.make
		end

	Degree_4: DEGREE_4 is
			-- Degree 4
		once
			create Result.make
		end

	Degree_3: DEGREE_3 is
			-- Degree 3
		once
			create Result.make
		end

	Degree_2: DEGREE_2 is
			-- Degree 2
		once
			create Result.make
		end

	Degree_1: DEGREE_1 is
			-- Degree 1
		once
			create Result.make
		end

end -- class SHARED_DEGREES


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
