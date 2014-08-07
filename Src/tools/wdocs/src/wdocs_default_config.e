note
	description: "Summary description for {WDOCS_DEFAULT_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_DEFAULT_CONFIG

inherit
	WDOCS_CONFIG

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
			create root_dir.make_current
			wiki_dir := root_dir.extended ("_db").extended ("wiki")
			create theme_name.make_from_string_general ("default")
		end

end
