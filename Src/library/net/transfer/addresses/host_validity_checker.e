indexing
	description:
		"Facility to check the validity of hosts"

	status:	"See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	HOST_VALIDITY_CHECKER

feature -- Status report

	host_ok (h: STRING): BOOLEAN is
			-- Is `h' a valid host?
		do
			if h /= Void and then not h.is_empty then
				Result := Host_charset.contains_string (h)
			end
		end

feature {NONE} -- Implementation

	Host_charset: CHARACTER_SET is
			-- Character set for host names
		once
			create Result
			Result.define ("A-Za-z0-9.\-")
		end

end -- class HOST_VALIDITY_CHECKER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
