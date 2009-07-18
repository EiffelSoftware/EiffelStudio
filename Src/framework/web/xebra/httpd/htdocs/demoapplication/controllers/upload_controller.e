note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	UPLOAD_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	make

feature -- Status Change

	upload: STRING
			-- Process the uploaded file
		local
			l_util: XU_FILE_UTILITIES
		do
			if attached current_request.upload_filename as l_fn then
				create l_util
				if	process_upload_single_file (l_fn, create {FILE_NAME}.make_from_string ("upload")) then
					Result := "Success!"
				else
					Result := "Error while processing!"
				end
			else
				Result := "No uploaded file found!"
			end
		end
end
