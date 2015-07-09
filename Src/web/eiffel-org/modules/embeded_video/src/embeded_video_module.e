note
	description: "[
		Module that allows you to embed videos from YouTube and Vimeo in a web page.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EMBEDED_VIDEO_MODULE

inherit

	CMS_MODULE
		redefine
			initialize
		end

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Embeded video module"
			package := "embeded video"
		end

feature -- Access

	name: STRING = "embeded_video"
			-- <Precursor>

feature {CMS_API} -- Module Initialization

	initialize (api: CMS_API)
			-- <Precursor>
		local
			ut: FILE_UTILITIES
			p: PATH
			f: CMS_FORMAT
		do
			Precursor (api)
			create f.make_from_format (create {VIDEO_HTML_CONTENT_FORMAT})
			api.formats.extend (f)
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
		end

end
