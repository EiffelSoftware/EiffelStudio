indexing
	description:
		"[
			Objects that generate an Eiffel class text based on the
			current system built by the user. This version is for the demo version of Build,
			and therefore has its contents stripped out to avoid reverse engineering.
		]"	
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CODE_GENERATOR
	
	-- We currently only support two or less project locations per ace file.
	
inherit
	
	GB_XML_UTILITIES
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_EVENT_UTILITIES
	
	INTERNAL
	
	EIFFEL_ENV
	
	GB_FILE_CONSTANTS

feature -- Basic operation

	generate is
			-- Generate a new Eiffel class in `a_file_name',
			-- named `a_class_name'. The rest is built from the
			-- current state of the display_window.
		do
			-- Empty to prevent reverse engineering.
		end
		
	set_progress_bar (a_progress_bar: EV_PROGRESS_BAR) is
			--
		do
			-- Empty to prevent reverse engineering.
		end
		

end -- class GB_CODE_GENERATOR
