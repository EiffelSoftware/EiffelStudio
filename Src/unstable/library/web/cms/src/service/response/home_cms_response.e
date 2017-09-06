note
	description: "Summary description for {HOME_CMS_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HOME_CMS_RESPONSE

inherit
	CMS_RESPONSE
		redefine
			custom_prepare
		end

create
	make

feature -- Generation

	custom_prepare (page: CMS_HTML_PAGE)
		do
			Precursor (page)
--			page.register_variable (api.recent_nodes (0, 5), "nodes")
		end

feature -- Execution

	process
			-- Computed response message.
		do
			set_title (Void)
			set_page_title (Void)
		end
note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

