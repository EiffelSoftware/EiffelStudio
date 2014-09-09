note
	description: "Summary description for {WDOCS_CONFIG}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_CONFIG

feature {NONE} -- Initialization

	make
		do
		end

feature -- Access

	root_dir: PATH

	documentation_dir: PATH

	documentation_default_version: STRING

	cache_duration: INTEGER

end
