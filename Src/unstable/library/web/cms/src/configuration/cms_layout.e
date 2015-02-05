note
	description: "[
				CMS Layout providing file system locations for
						- config 
						- application 
						- logs 
						- documentation 
						- themes
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_LAYOUT

inherit

	APPLICATION_LAYOUT

create
	make_default,
	make_with_path,
	make_with_directory_name

feature -- Access

	theme_path: PATH
			-- Directory for templates (HTML, etc).
		local
			p: detachable PATH
		do
			p := internal_theme_path
			if p = Void then
				p := www_path.extended ("theme")
				internal_theme_path := p
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
				p := config_path.extended ("cms.ini")
				internal_cms_config_ini_path := p
			end
			Result := p
		end

feature {NONE} -- Implementation

	internal_theme_path: detachable like theme_path

	internal_cms_config_ini_path: detachable like cms_config_ini_path

end
