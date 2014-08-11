note
	description: "Summary description for {WDOCS_INI_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_INI_CONFIG

inherit
	WDOCS_DEFAULT_CONFIG
		rename
			make as make_default
		end

create
	make

feature {NONE} -- Initialization

	make (p: PATH)
		local
			ini: INI_CONFIG
		do
			make_default

			create ini.make_from_file (p)

			if attached ini.text_item ("root") as l_root then
				create root_dir.make_from_string (l_root)
			end
			if attached ini.text_item ("wiki") as l_wiki then
				create wiki_dir.make_from_string (l_wiki)
			end
			if attached ini.text_item ("theme") as l_theme then
				create theme_name.make_from_string (l_theme)
			end
			if
				attached ini.text_item ("cache_duration") as l_duration and then
				l_duration.is_integer
			then
				cache_duration := l_duration.to_integer
			end
		end

end
