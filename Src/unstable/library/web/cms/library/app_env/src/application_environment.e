note
	description: "[
			Application environment (layout, ...)
			Related to file system locations such as 
				- configuration locations
				- application
				- log
				- documentation
				- www
				- assets 
				- templates (html, Collection+JSON, ...)
				- ...
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_ENVIRONMENT

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make_default,
	make_with_path,
	make_with_directory_name

feature {NONE} -- Initialization

	make_default
			-- Create a default layout based on current working directory.
		local
			p: PATH
		do
			create p.make_current
			p := p.extended ("site")
			make_with_path (p)
		end

	make_with_path (p: PATH)
			-- Create a layout based on a path `p'.
		do
			path := p.absolute_path.canonical_path
			initialize_name
		end

	make_with_directory_name (a_dirname: READABLE_STRING_GENERAL)
			-- Create a layout based on directory name  `a_dirname'.
		do
			make_with_path (create {PATH}.make_from_string (a_dirname))
		end

	initialize_name
			-- Initialize `name'.
		local
			p: PATH
			s: STRING_32
		do
			create p.make_from_string (execution_environment.arguments.command_name)
			if attached p.entry as e then
				p := e
			end
			create s.make_from_string (p.name)
			if attached p.extension as l_extension then
				s.remove_tail (l_extension.count + 1)
			end
			if s.is_whitespace then
				set_name ({STRING_8} "app")
			else
				set_name (s)
			end
		end

feature -- Access

	path: PATH
			-- Root location.

	name: IMMUTABLE_STRING_32
			-- Application name, default is "app"

feature -- Change

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Set `name' from `a_name'.
		do
			create name.make_from_string_general (a_name)
		end

feature -- Access: internal

	config_path: PATH
			-- Configuration file path.
		local
			p: detachable PATH
		do
			p := internal_config_path
			if p = Void then
				p := path.extended ("config")
				internal_config_path := p
			end
			Result := p
		end

	application_config_path: PATH
			-- Database Configuration file path.
		local
			p,p_dft: detachable PATH
			fut: FILE_UTILITIES
		do
			p := internal_application_config_path
			if p = Void then
				p := config_path.extended (name + ".json")
				if not fut.file_path_exists (p) then
					p_dft := config_path.extended ("env.json")
					if fut.file_path_exists (p_dft) then
						p := p_dft
					end
				end
				internal_application_config_path := p
			end
			Result := p
		end

	logs_path: PATH
			-- Directory for logs.
		local
			p: detachable PATH
		do
			p := internal_logs_path
			if p = Void then
				p := path.extended ("logs")
				internal_logs_path := p
			end
			Result := p
		end

	documentation_path: PATH
			-- Directory for API documentation.
		local
			p: detachable PATH
		do
			p := internal_documentation_path
			if p = Void then
				p := path.extended ("doc")
				internal_documentation_path := p
			end
			Result := p
		end

	www_path: PATH
			-- Directory for www.
		local
			p: detachable PATH
		do
			p := internal_www_path
			if p = Void then
				p := path.extended ("www")
				internal_www_path := p
			end
			Result := p
		end

	assets_path: PATH
			-- Directory for public assets.
			-- css, images, js.
		local
			p: detachable PATH
		do
			p := internal_assets_path
			if p = Void then
				p := www_path.extended ("assets")
				internal_assets_path := p
			end
			Result := p
		end

	template_path: PATH
			-- Directory for templates (HTML, etc).
		local
			p: detachable PATH
		do
			p := internal_template_path
			if p = Void then
				p := www_path.extended ("template")
				internal_template_path := p
			end
			Result := p
		end

feature {NONE} -- Implementation

	internal_config_path: detachable like config_path
			-- Configuration file path.

	internal_application_config_path: detachable like application_config_path
			-- Database Configuration file path.

	internal_logs_path: detachable like logs_path
			-- Directory for logs.

	internal_documentation_path: detachable like documentation_path
			-- Directory for API documentation.

	internal_www_path: detachable like www_path
			-- Directory for www.

	internal_assets_path: detachable like assets_path
			-- Directory for public assets.
			-- css, images, js.

	internal_template_path: detachable like template_path
			-- Directory for templates (HTML, etc).

;note
	copyright: "2011-2017, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
