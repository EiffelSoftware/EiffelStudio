note
	description: "Summary description for {WDOCS_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_CONFIG

feature -- Access

	theme_name: IMMUTABLE_STRING_32

	root_dir: PATH

feature -- Initialization

	initialize
		do
		end

end
