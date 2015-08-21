note
	description: "Summary description for {EIFFEL_COMMUNITY_SITE_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_COMMUNITY_SITE_SERVICE

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature -- Implementation: CMS

	initial_cms_setup: EIFFEL_COMMUNITY_SITE_CMS_SETUP
			-- CMS setup.
		do
			create Result.make (new_cms_environment)
		end

	new_cms_environment: CMS_ENVIRONMENT
		deferred
--			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
--				create Result.make_with_directory_name (l_dir)
--			else
--				create Result.make_default
--			end
		end


end
