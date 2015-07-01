note
	description: "Third-party controller used to signal a stop message."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTROLLER

feature
	is_downloader_over: BOOLEAN
	is_viewer_over: BOOLEAN

feature
	stop_downloader
			-- Record request to stop downloader operation	
		do
			is_downloader_over := True
		end


feature
	stop_viewer
			-- Record request to stop viewer operation	
		do
			is_viewer_over := True
		end
end
