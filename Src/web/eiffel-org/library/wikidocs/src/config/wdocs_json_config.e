note
	description: "Summary description for {WDOCS_JSON_CONFIG}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_JSON_CONFIG

inherit
	WDOCS_DEFAULT_CONFIG
		rename
			make as old_make
		end

create
	make

feature {NONE} -- Initialization

	make (p: PATH)
		local
			cfg: CONFIG_READER
		do
			make_default
			if attached p.extension as e and then e.is_case_insensitive_equal_general ("ini") then
				create {INI_CONFIG} cfg.make_from_file (p)
			else
				create {JSON_CONFIG} cfg.make_from_file (p)
			end

			if attached cfg.text_item ("layout.root") as l_root then
				create root_dir.make_from_string (l_root)
			end
			if attached cfg.text_item ("layout.tmp") as l_tmp then
				create temp_dir.make_from_string (l_tmp)
			end
			if attached cfg.text_item ("layout.documentation") as l_documentation_dir then
				create documentation_dir.make_from_string (l_documentation_dir)
			end
			if attached cfg.text_item ("layout.documentation_default_version") as l_version then
				create documentation_default_version.make_from_string (l_version)
			end
			if
				attached cfg.text_item ("settings.cache_duration") as l_duration and then
				l_duration.is_integer
			then
				cache_duration := l_duration.to_integer
			end
		end
end
