indexing
	description: "Facility to find seperators in date or time strings" 
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	FIND_SEPARATOR_FACILITY

feature {NONE} -- Implementation

	find_separator (s: STRING; i: INTEGER): INTEGER is
			-- Position of the next separator in s starting at ith character.
			-- ":", "/", "-", ",", " ", "."
		require
			s_exists: s /= Void
			i_exists: i /= Void
			i_small: i <= s.count
		local
			int: ARRAY [INTEGER]
			j, int_tmp: INTEGER
		do
			create int.make (0, 5)
			int.put (s.index_of (':', i), 0)
			int.put (s.index_of ('/', i), 1)
			int.put (s.index_of ('-', i), 2)
			int.put (s.index_of (',', i), 3)
			int.put (s.index_of (' ', i), 4)
			int.put (s.index_of ('.', i), 5)
			Result := s.count + 1
			from 
				j := 0
			until 
				j > 5
			loop
				int_tmp := int.item (j)
				if int_tmp /= 0 and int_tmp < Result then
					Result := int_tmp
				end
				j := j + 1
			end
		ensure
			index_exists: Result /= Void
			next_index: Result > i
		end
		
end -- class FIND_SEPARATOR_FACILITY

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
