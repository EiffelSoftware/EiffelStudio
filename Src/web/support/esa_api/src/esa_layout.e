note
	description: "Summary description for {ESA_LAYOUT}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LAYOUT

create
	make_default,
	make_with_path

feature {NONE} -- Initialization

	make_default
		local
			p: PATH
		do
			create p.make_current
			p := p.extended ("esa_folder")
			make_with_path (p)
		end

	make_with_path (p: PATH)
		do
			path := p.absolute_path.canonical_path
		end

feature -- Access

	path: PATH

feature -- Access: internal

	config_path: PATH
			-- Configuration file path.
		once
			Result := path.extended ("config")
		end

	application_config_path: PATH
			-- Database Configuration file path.
		once
			Result := config_path.extended ("esa_application_configuration.json")
		end


	logs_path: PATH
		once
			Result := path.extended ("logs")
		end

	documentation_path: PATH
			-- directory for iron documentation	
		once
			Result := path.extended ("doc")
		end

	www_path: PATH
		once
			Result := path.extended ("www")
		end

	html_template_path: PATH
		once
			Result := www_path.extended ("template").extended ("html")
		end

	cj_template_path: PATH
		once
			Result := www_path.extended ("template").extended ("cj")
		end

end
