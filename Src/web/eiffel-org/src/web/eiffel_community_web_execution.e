note
	description: "Summary description for {EIFFEL_COMMUNITY_WEB_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_WEB_EXECUTION

inherit
	CMS_EXECUTION
		redefine
			clean
		end

	EIFFEL_COMMUNITY_SITE_SERVICE

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature -- Cleaning

	clean
			-- Cleaning after request.
		do
			if attached api.storage as l_storage then
				l_storage.close
			end
			Precursor
		end

feature {NONE} -- Implementation

	new_cms_environment: CMS_ENVIRONMENT
		do
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create Result.make_with_directory_name (l_dir)
			else
				create Result.make_default
			end
			Result.set_name ("eiffel_org")
		end

end

