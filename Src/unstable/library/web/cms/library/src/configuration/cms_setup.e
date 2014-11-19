note
	description: "Class that enable to set basic configuration, application layout, core modules and  themes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SETUP

feature -- Access

	configuration: CMS_CONFIGURATION
			-- cms configuration.

	layout: CMS_LAYOUT
			-- CMS layout.

	is_html: BOOLEAN
			--  api with progressive enhancements css and js, server side rendering.
		deferred
		end

	is_web: BOOLEAN
			-- web: Web Site with progressive enhancements css and js and Ajax calls.
		deferred
		end

	available_modules: CMS_MODULE_COLLECTION
			-- List of available modules.
		deferred
		end

	enabled_modules: CMS_MODULE_COLLECTION
			-- List of enabled modules.
		local
			l_module: CMS_MODULE
		do
			create Result.make (available_modules.count)
			across
				available_modules as ic
			loop
				l_module := ic.item
				if l_module.is_enabled then
					Result.extend (l_module)
				end
			end
		ensure
			only_enabled_modules: across Result as ic all ic.item.is_enabled end
		end

feature -- Access: Site

	site_id: READABLE_STRING_8

	site_name: READABLE_STRING_32
			-- Name of the site.

	site_email: READABLE_STRING_8
			-- Email for the site.

	site_url: detachable READABLE_STRING_8
			-- Optional base url of the site.

	front_page_path: detachable READABLE_STRING_8
			-- Optional path defining the front page.
			-- By default "" or "/".

feature -- Access: Theme	

	themes_location: PATH
			-- Path to themes.

	theme_location: PATH
			-- Path to a particular theme.

	theme_assets_location: PATH
			-- Path to a particular theme assets folder.

	theme_information_location: PATH
			-- theme informations.
		do
			Result := theme_location.extended ("theme.info")
		end

	theme_name: READABLE_STRING_32
			-- theme name.

end
