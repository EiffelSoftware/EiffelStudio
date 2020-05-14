note
	description: "Summary description for {CMS_SETUP_DEBUG_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SETUP_DEBUG_INFO

inherit
	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (api: CMS_API)
		do
			cms_api := api
		end

feature -- Access

	cms_api: CMS_API

feature -- Output

	out: STRING
		do
			create Result.make (0)
			append_to_string (Result)
		end

	append_to_string (s: STRING)
		local
			utf: UTF_CONVERTER
		do
			create utf
			if cms_api.has_error and then attached cms_api.string_representation_of_errors as errs then
				s.append ("Error: " + utf.utf_32_string_to_utf_8_string_8 (errs) + "%N")
			end
			if attached cms_api.storage as st then
				s.append ("Storage: " + st.out + "%N")
			end
			if attached cms_api.setup as l_setup then
				if attached l_setup.environment as l_env then
					s.append ("Env.path: " + l_env.path.utf_8_name + "%N")
					s.append ("Env.name: " + utf.utf_32_string_to_utf_8_string_8 (l_env.name) + "%N")
					s.append ("Env.application_config_path: " + l_env.application_config_path.utf_8_name + "%N")
				end
				s.append (l_setup.out)
			end
		end


note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
