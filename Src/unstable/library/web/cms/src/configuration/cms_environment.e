note
	description: "[
				CMS Environment providing file system locations for
						- config 
						- application 
						- logs 
						- documentation 
						- themes
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ENVIRONMENT

inherit
	APPLICATION_ENVIRONMENT

create
	make_default,
	make_with_path,
	make_with_directory_name

feature -- Access

	site_path: PATH
			-- Directory containing the site.
			--| For now, an alias for `path'.
		do
			Result := path
		end

	modules_path: PATH
			-- Directory for templates (HTML, etc).
		local
			p: detachable PATH
		do
			p := internal_modules_path
			if p = Void then
				p := site_path.extended ("modules")
				internal_modules_path := p
			end
			Result := p
		end

	themes_path: PATH
			-- Directory for cms themes.
		local
			p: detachable PATH
		do
			p := internal_themes_path
			if p = Void then
				p := site_path.extended ("themes")
				internal_themes_path := p
			end
			Result := p
		end

	cms_config_ini_path: PATH
			-- CMS Configuration file path.
		local
			p: detachable PATH
		do
			p := internal_cms_config_ini_path
			if p = Void then
				p := config_path.extended (cms_config_ini_name)
				internal_cms_config_ini_path := p
			end
			Result := p
		end

	cms_config_ini_name: STRING
			-- CMS Configuration file name.
			-- Redefine to easily change the name.
		do
			Result := "cms.ini"
		end

feature {NONE} -- Implementation

	internal_modules_path: detachable like modules_path

	internal_themes_path: detachable like themes_path

	internal_cms_config_ini_path: detachable like cms_config_ini_path

end
