note
	description: "[
			Administrate import functionality.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_IMPORT_HANDLER

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
			if api.has_permission ("admin import") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := importation_web_form (l_response)
				create s.make_empty
				f.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} l_response.make (req, res, api)
			end
			l_response.execute
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			l_importation: CMS_IMPORT_CONTEXT
			p: PATH
		do
			if api.has_permission ("admin import") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := importation_web_form (l_response)
				f.process (l_response)
				if
					attached f.last_data as fd and then
					fd.is_valid
				then
					if attached fd.string_item ("op") as l_op and then l_op.same_string (text_import_all_data) then
						if attached fd.string_item ("folder") as l_folder then
							create p.make_from_string (l_folder)
							create l_importation.make (api.site_location.extended (import_folder_name).extended (l_folder))
							if l_importation.location_exists then
								l_response.add_notice_message ("Import all data (if permitted)!")
								api.hooks.invoke_import_from (Void, l_importation, l_response)
								create s.make_empty
								across
									l_importation.logs as ic
								loop
									s.append (ic.item)
									s.append ("<br/>")
									s.append_character ('%N')
								end
								l_response.add_notice_message (s)
							else
								l_response.add_error_message ("Specified import folder is not found!")
								fd.report_invalid_field ("folder", "Folder not found!")
							end
						else
							fd.report_error ("Invalid form data!")
						end
					else
						fd.report_error ("Invalid form data!")
					end
				end
				create s.make_empty
				f.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} l_response.make (req, res, api)
			end

			l_response.execute
		end

feature -- Widget

	importation_web_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			f_name: WSF_FORM_TEXT_INPUT
			but: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (a_response.url (a_response.location, Void), "import_all_data")
			Result.extend_raw_text ("Import CMS data from ")
			create f_name.make_with_text ("folder", "default")
			f_name.set_label ("Import folder name")
			f_name.set_description ("Folder name under '" + a_response.html_encoded (import_folder_name) + "' folder.")
			f_name.set_is_required (True)
			Result.extend (f_name)
			create but.make_with_text ("op", text_import_all_data)
			Result.extend (but)
		end

feature -- Interface text.

	import_folder_name: STRING_32 = "import"

	text_import_all_data: STRING_32 = "Import all data"

end
