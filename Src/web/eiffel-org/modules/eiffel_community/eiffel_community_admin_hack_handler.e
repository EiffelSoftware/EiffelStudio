note
	description: "Summary description for {EIFFEL_COMMUNITY_ADMIN_HACK_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_ADMIN_HACK_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get, do_post
		end

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			r: CMS_RESPONSE
		do
			create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("manage " + {EIFFEL_COMMUNITY_MODULE}.name) then
				handle_admin_hack (api, req, res)
			else
				r.execute
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			r: CMS_RESPONSE
		do
			create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
			if r.has_permission ("manage " + {EIFFEL_COMMUNITY_MODULE}.name) then
				handle_admin_hack (api, req, res)
			else
				r.execute
			end
		end

feature {NONE} -- Handler: admin hack...

	handle_admin_hack (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING
			r: CMS_RESPONSE
			f: CMS_FORM
--			t: WSF_FORM_TEXT_INPUT
--			fe: WSF_FORM_EMAIL_INPUT
			fs: WSF_FORM_FIELD_SET
			f_submit: WSF_FORM_SUBMIT_INPUT
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)

			create f.make (req.percent_encoded_path_info, {EIFFEL_COMMUNITY_MODULE}.name + "_hack_form")
			create fs.make
			fs.set_legend ("No specific hack for now!")
			create f_submit.make_with_text ("op", "Apply")
			fs.extend (f_submit)
			f.extend (fs)

			if req.is_post_request_method then
				create s.make_empty
				f.validation_actions.extend (agent (fd: WSF_FORM_DATA; ia_api: CMS_API)
						do
						end(?, a_api)
					)
				f.submit_actions.extend (agent (fd: WSF_FORM_DATA; ia_api: CMS_API; a_output: STRING)
						do
--							if attached fd.string_item ("op") as f_op then
--							end
						end(?, a_api, s)
					)

				f.process (r)
				f.append_to_html (create {CMS_TO_WSF_THEME}.make (r, r.theme), s)
				r.set_main_content (s)
			elseif req.is_get_head_request_method then
				create s.make_empty
				f.append_to_html (create {CMS_TO_WSF_THEME}.make (r, r.theme), s)
				r.set_main_content (s)
			end
			r.execute
		end

end
