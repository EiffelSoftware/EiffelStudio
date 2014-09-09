note
	description: "Summary description for {WDOCS_INI_CONFIG}."
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
			if attached ini.text_item ("documentation") as l_doc then
				create documentation_dir.make_from_string (l_doc)
			end
			if attached ini.text_item ("documentation_default_version") as l_version then
				create documentation_default_version.make_from_string (l_version)
			end
			if
				attached ini.text_item ("cache_duration") as l_duration and then
				l_duration.is_integer
			then
				cache_duration := l_duration.to_integer
			end
		end

end
