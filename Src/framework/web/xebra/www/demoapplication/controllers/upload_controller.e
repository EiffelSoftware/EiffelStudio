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
		do
			if attached current_request.upload_filename as l_tfn then
				if attached {STRING} process_upload_single_file (l_tfn, {XU_CONSTANTS}.Xebra_root + "/www/demoapplication/upload") as l_fn then
					Result := "Success! File was uploaded to " + l_fn
				else
					Result := "Error while processing uploaded file!"
				end
			else
				Result := "Error, no uploaded file found!"
			end
		end
end
