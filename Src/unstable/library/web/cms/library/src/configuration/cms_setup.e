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

	enabled_modules: CMS_MODULE_COLLECTION
			-- List of enabled modules.
		local
			l_module: CMS_MODULE
		do
			create Result.make (modules.count)
			across
				modules as ic
			loop
				l_module := ic.item
				if l_module.is_enabled then
					Result.extend (l_module)
				end
			end
		ensure
			only_enabled_modules: across Result as ic all ic.item.is_enabled end
		end

feature {CMS_MODULE} -- Restricted access

	modules: CMS_MODULE_COLLECTION
			-- List of available modules.
		deferred
		end

feature -- Access: Site

	site_id: READABLE_STRING_8
			-- String identifying current CMS.
			-- This could be used in webform, for cookie name, ...

	site_name: READABLE_STRING_32
			-- Name of the site.

	site_email: READABLE_STRING_8
			-- Admin email address for the site.
			-- Mainly used for internal notification.

	site_url: detachable READABLE_STRING_8
			-- Optional base url of the site.

	front_page_path: detachable READABLE_STRING_8
			-- Optional path defining the front page.
			-- By default "" or "/".

	smtp: detachable READABLE_STRING_8
			-- 	Smtp server

feature -- Access: Theme	

	themes_location: PATH
			-- Path to themes.

	theme_location: PATH
			-- Path to a active theme.

	theme_assets_location: PATH
			-- Path to a active theme assets folder.

	theme_information_location: PATH
			-- Active theme informations.
		do
			Result := theme_location.extended ("theme.info")
		end

	theme_name: READABLE_STRING_32
			-- theme name.

feature -- Element change

	register_module (m: CMS_MODULE)
			-- Add module `m' to `modules'
		deferred
		ensure
			module_added: modules.has (m)
		end

end
