note
	description: "[
		Module that allows you to embed videos from YouTube and Vimeo in a web page.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EMBEDDED_VIDEO_MODULE

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

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Embedded video module"
			package := "filters"
		end

feature -- Access

	name: STRING = "embedded_video"
			-- <Precursor>

feature {CMS_API} -- Module Initialization

	initialize (api: CMS_API)
			-- <Precursor>
		local
			f: CMS_FORMAT
		do
			Precursor {CMS_MODULE} (api)
			api.content_filters.extend (create {VIDEO_CONTENT_FILTER})
			f := api.new_format ("video_html", "Video HTML content", <<{VIDEO_CONTENT_FILTER}.name>>)
			api.formats.extend (f)
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
		end

end
