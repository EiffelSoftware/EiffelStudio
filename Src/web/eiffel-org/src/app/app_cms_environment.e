note
	description: "Summary description for {APP_CMS_ENVIRONMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APP_CMS_ENVIRONMENT

inherit
	CMS_ENVIRONMENT
		redefine
			cms_config_ini_name
		end

create
	make_default,
	make_with_path,
	make_with_directory_name

feature -- Access	

	cms_config_ini_name: STRING
		do
			Result := "app.ini"
		end

end
