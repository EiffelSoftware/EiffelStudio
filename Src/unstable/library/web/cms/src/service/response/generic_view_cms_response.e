note
	description: "Summary description for {NODE_VIEW_CMS_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERIC_VIEW_CMS_RESPONSE

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
			if attached variables as l_variables then
				across l_variables as c loop page.register_variable (c.item, c.key) end
			end
		end

feature -- Execution

	process
			-- Computed response message.
		do
		end
note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

