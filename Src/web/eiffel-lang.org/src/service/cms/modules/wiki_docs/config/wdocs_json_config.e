note
	description: "Summary description for {WDOCS_JSON_CONFIG}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_JSON_CONFIG

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
			json: JSON_CONFIG
		do
			make_default

			create JSON.make_from_file (p)

			if attached json.layout_root as l_root then
				create root_dir.make_from_string (l_root)
			end
			if attached json.layout_wiki as l_wiki then
				create wiki_dir.make_from_string (l_wiki)
			end
			if
				attached json.settings_cache_duration as l_duration and then
				l_duration.is_integer
			then
				cache_duration := l_duration.to_integer
			end
		end
end
