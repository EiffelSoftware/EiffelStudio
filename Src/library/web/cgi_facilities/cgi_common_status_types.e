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
