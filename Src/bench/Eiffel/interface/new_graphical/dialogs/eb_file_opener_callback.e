indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FILE_OPENER_CALLBACK

feature {EB_FILE_OPENER} -- Callbacks

	save_file (f: RAW_FILE) is deferred end

end -- class EB_FILE_OPENER_CALLBACK
