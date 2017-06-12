note
	description: "[
			Administrate export functionality.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_EXPORT_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
		do
			if api.has_permission ("admin export") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := exportation_web_form (l_response)
				create s.make_empty
				f.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
				l_response.execute
			else
				send_access_denied (req, res)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			l_exportation: CMS_EXPORT_CONTEXT
		do
			if api.has_permission ("admin export") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := exportation_web_form (l_response)
				f.process (l_response)
				if
					attached f.last_data as fd and then
					fd.is_valid
				then
					if attached fd.string_item ("op") as l_op and then l_op.same_string (text_export_all_data) then
						if attached fd.string_item ("folder") as l_folder then
							create l_exportation.make (api.site_location.extended ("export").extended (l_folder))
						else
							create l_exportation.make (api.site_location.extended ("export").extended ((create {DATE_TIME}.make_now_utc).formatted_out ("yyyy-[0]mm-[0]dd---hh24-[0]mi-[0]ss")))
						end
						api.hooks.invoke_export_to (Void, l_exportation, l_response)
						l_response.add_notice_message ("All data exported (if allowed)!")
						create s.make_empty
						across
							l_exportation.logs as ic
						loop
							s.append (ic.item)
							s.append ("<br/>")
							s.append_character ('%N')
						end
						l_response.add_notice_message (s)
					else
						fd.report_error ("Invalid form data!")
					end
				end
				create s.make_empty
				f.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
				l_response.execute
			else
				send_access_denied (req, res)
			end
		end

feature -- Widget

	exportation_web_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			f_name: WSF_FORM_TEXT_INPUT
			but: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (a_response.request_url (Void), "export_all_data")
			Result.extend_raw_text ("Export CMS data to ")
			create f_name.make_with_text ("folder", (create {DATE_TIME}.make_now_utc).formatted_out ("yyyy-[0]mm-[0]dd---hh24-[0]mi-[0]ss"))
			f_name.set_label ("Export folder name")
			f_name.set_description ("Folder name under 'exports' folder.")
			f_name.set_is_required (True)
			Result.extend (f_name)
			create but.make_with_text ("op", text_export_all_data)
			Result.extend (but)
		end

feature -- Interface text.		

	text_export_all_data: STRING_32 = "Export all data"

end
