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
	default_create

feature -- Status Change

	upload: STRING
			-- Process the uploaded file
		do
		
			if attached {STRING} process_uploaded_single_file ("$XEBRA_DEV/www/demoapplication/upload") as l_fn then
				Result := "Success! File was uploaded to " + l_fn
			else
				Result := "Error while processing uploaded file!"
			end
		end
end
