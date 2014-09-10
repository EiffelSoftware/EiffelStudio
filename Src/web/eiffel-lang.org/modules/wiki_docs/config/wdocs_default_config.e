note
	description: "Summary description for {WDOCS_DEFAULT_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_DEFAULT_CONFIG

inherit
	WDOCS_CONFIG
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			create root_dir.make_current
			documentation_dir := root_dir.extended ("data").extended ("documentation")
			documentation_default_version := "current"
			cache_duration := 6 * 60 * 60 -- 6 hours
		end

end
