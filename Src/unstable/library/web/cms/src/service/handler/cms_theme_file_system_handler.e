note
	description: "Summary description for {CMS_THEME_FILE_SYSTEM_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_THEME_FILE_SYSTEM_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_cms_api: CMS_API)
		do
			api := a_cms_api
		end

	api: CMS_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding in `res'.
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			if attached {WSF_STRING} req.path_parameter ("theme_id") as l_theme_id then
				create fhdl.make_hidden_with_path (api.theme_assets_location_for (l_theme_id.value))
				fhdl.disable_index
				fhdl.set_not_found_handler (not_found_handler)
				fhdl.execute_starts_with (api.theme_path_for (l_theme_id.value), req, res)
--				a_router.handle (api.theme_path, fhdl, router.methods_GET)
			elseif attached not_found_handler as h then
				h.call (req.percent_encoded_path_info, req, res)
			else
				api.response_api.send_not_found (Void, req, res)
			end
		end

feature -- Not found handling

	not_found_handler: detachable PROCEDURE [READABLE_STRING_8, WSF_REQUEST, WSF_RESPONSE]

	set_not_found_handler (h: like not_found_handler)
		do
			not_found_handler := h
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
