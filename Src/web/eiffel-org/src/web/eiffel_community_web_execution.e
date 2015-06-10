note
	description: "Summary description for {EIFFEL_COMMUNITY_WEB_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_WEB_EXECUTION

inherit
	CMS_EXECUTION

	EIFFEL_COMMUNITY_SITE_SERVICE

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make


feature {NONE} -- Implementation

	new_cms_environment: CMS_ENVIRONMENT
		do
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create Result.make_with_directory_name (l_dir)
			else
				create Result.make_default
			end
		end

end

