note
	description: "[
			Administrate cleanup functionality.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_CLEANUP_HANDLER

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
			if api.has_permission ({CMS_ADMIN_MODULE_ADMINISTRATION}.perm_admin_cleanup) then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := web_form (l_response)
				api.hooks.invoke_form_alter (f, Void, l_response)
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
			ctx: CMS_HOOK_CLEANUP_CONTEXT
			tb: STRING_TABLE [READABLE_STRING_GENERAL]
		do
			if api.has_permission ({CMS_ADMIN_MODULE_ADMINISTRATION}.perm_admin_cleanup) then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				f := web_form (l_response)
				api.hooks.invoke_form_alter (f, Void, l_response)
				f.process (l_response)
				if
					attached f.last_data as fd and then
					fd.is_valid
				then
					if attached fd.string_item ("op") as l_op and then l_op.same_string (text_cleanup) then
						if attached fd.table_item ("cleanup-params") as f_tb then
							create tb.make (f_tb.count)
							across
								f_tb as ic
							loop
								if attached {WSF_VALUE} ic.item as v then
									tb[ic.key] := v.string_representation
								end
							end
						end
						create ctx.make (tb)
						api.hooks.invoke_cleanup (ctx, l_response)
						l_response.add_notice_message ("Process cleanup operation (if allowed)!")
						create s.make_empty
						across
							ctx.logs as ic
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
				l_response.set_main_content (s)
				l_response.execute
			else
				send_access_denied (req, res)
			end
		end

feature -- Widget

	form_admin_cleanup_id: STRING = "admin-cleanup"

	web_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			but: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (a_response.request_url (Void), form_admin_cleanup_id)
			Result.extend_raw_text ("Process cleanup operation")
			create but.make_with_text ("op", text_cleanup)
			Result.extend (but)
		end

feature -- Interface text.		

	text_cleanup: STRING_32 = "Process Cleanup"

end
