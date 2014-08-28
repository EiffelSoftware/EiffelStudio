note
	description: "Summary description for {LOG_VIEW_CMS_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOG_VIEW_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
		do
			if attached {WSF_STRING} request.path_parameter ("log-id") as p_id and then p_id.is_integer then
				create b.make_empty

				if attached storage.log (p_id.integer_value) as l_log then
					set_title ("Log #" + l_log.id.out)
					b.append (l_log.to_html (theme))
				else
					set_title ("Log [" + p_id.value + "] does not exists!")
				end
				set_main_content (b)
			else
				set_redirection ("/admin/logs")
				set_main_content ("not found")
			end
		end

end
