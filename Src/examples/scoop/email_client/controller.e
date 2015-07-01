note
	description: "Third-party controller used to signal a stop message."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

feature -- Status report

	is_downloader_over: BOOLEAN
			-- Should the downloader stop its execution?

	is_viewer_over: BOOLEAN
			-- Should the viewer stop its execution?

feature -- Basic operations

	stop_downloader
			-- Record request to stop the downloader.
		do
			is_downloader_over := True
		end

	stop_viewer
			-- Record request to stop the viewer.	
		do
			is_viewer_over := True
		end

end
