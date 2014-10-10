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
	make,
	make_default

feature {NONE} -- Initialization

	make_default
		do
			make (create {PATH}.make_current, Void)
		end

	make (a_root_dir: PATH; a_default_version: detachable READABLE_STRING_8)
			-- Initialize Current with `a_root_dir' and default version to `a_default_version' if set, otherwise "current".
		do
			set_root_dir (a_root_dir)
			set_documentation_dir (a_root_dir.extended ("data").extended ("documentation"))
			if a_default_version /= Void then
				set_documentation_default_version (a_default_version)
			else
				set_documentation_default_version ("current")
			end
			set_cache_duration (6 * 60 * 60) -- 6 hours
		end

end
