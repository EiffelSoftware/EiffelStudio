indexing
	description: "COM GUID routines"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_GUID_ROUTINES

feature -- Status report

	is_valid_guid_string (s: STRING): BOOLEAN is
			-- Is `s' a valid GUID?
		require
			valid_string: s /= Void
		do
			Result := s.count = 38 and then
						s.item (1) = '{' and
						is_hexas (s.substring (2,9)) and
						s.item (10) = '-' and
						is_hexas (s.substring (11,14)) and
						s.item (15) = '-' and
						is_hexas (s.substring (16,19)) and
						s.item (20) = '-' and
						is_hexas (s.substring (21,24)) and
						s.item (25) = '-' and
						is_hexas (s.substring (26,37)) and
						s.item (38) = '}'
		end	

feature {NONE} -- Implementation

	is_hexas (s: STRING): BOOLEAN is
			-- Is `s' hexadecimal?
		require
			valid_string: s /= Void
		local
			i: INTEGER
		do
			from
				i := 1
				Result := True
			until
				i > s.count or not Result 
			loop
				Result := (s.item (i).is_digit or 
							(s.item (i).lower >= 'a' and s.item (i).lower <= 'f'))
				i := i + 1
			end
		end
		
end -- class ECOM_GUID_ROUTINES

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

