indexing
	description: "Common Status Types that may be returned to the browser."
	date: "$Date$"
	revision: "$Revision$"

class
	CGI_COMMON_STATUS_TYPES

feature -- Access

	success_status: INTEGER is 200

	no_response_status: INTEGER is 204

	document_moved_status: INTEGER is 301

	unauthorized_status: INTEGER is 401

	forbidden_status: INTEGER is 403

	not_found_status: INTEGER is 404

	internal_server_error_status: INTEGER is 500

	not_implemented_status: INTEGER is 501

end -- class CGI_COMMON_STATUS_TYPES


--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
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

