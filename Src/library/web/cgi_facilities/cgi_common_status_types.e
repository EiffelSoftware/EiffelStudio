indexing
	description: "Common Status Types that may be returned to the browser."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	not_implemented_status: INTEGER is 501;

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




end -- class CGI_COMMON_STATUS_TYPES

