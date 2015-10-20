note
	description: "Summary description for {WDOCS_DEFAULT_SETUP}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_DEFAULT_SETUP

inherit
	WDOCS_SETUP

create
	make,
	make_default,
	make_with_configuration

feature {NONE} -- Initialization

	make_with_configuration (p: PATH)
			-- Create setup with configuration file located at path `p'.
		local
			cfg: CONFIG_READER
		do
			make_default
			if attached p.extension as e and then e.is_case_insensitive_equal_general ("ini") then
				create {INI_CONFIG} cfg.make_from_file (p)
			else
				create {JSON_CONFIG} cfg.make_from_file (p)
			end
			load_from_config (cfg)
		end

	make_default
		do
			make (create {PATH}.make_current, Void)
		end

	make (a_root_dir: PATH; a_default_version: detachable READABLE_STRING_GENERAL)
			-- Initialize Current with `a_root_dir' and default version to `a_default_version'.
		do
			set_root_dir (a_root_dir)
			set_temp_dir (a_root_dir.extended ("tmp"))
			set_documentation_dir (a_root_dir.extended ("data").extended ("documentation"))
			set_documentation_default_version (a_default_version)
			set_cache_duration (6 * 60 * 60) -- 6 hours
			create interwiki_mapping.make (0)
		end

feature -- Initialization via external configuration reader.

	load_from_config (cfg: CONFIG_READER)
			-- Initialize with config `cfg'.
		do
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
				create {IMMUTABLE_STRING_32} documentation_default_version.make_from_string (l_version)
			end
			if
				attached cfg.text_item ("settings.cache_duration") as l_duration and then
				l_duration.is_integer
			then
				cache_duration := l_duration.to_integer
			end

			if attached cfg.text_table_item ("interwiki.map") as tb then
				across
					tb as ic
				loop
					if ic.item.is_valid_as_string_8 then
						interwiki_mapping.force (ic.item.as_string_8, ic.key)
					else
						check valid_interwiki_url: False end
					end
				end
			end
		end

end
