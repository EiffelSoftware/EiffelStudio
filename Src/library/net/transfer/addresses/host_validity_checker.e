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
			Result.define ("A-Za-z0-9\-.")
		end

end -- class HOST_VALIDITY_CHECKER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

