note
	description: "[
		Communicates with the support site to permit the submission of a bug report.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SUPPORT_BUG_REPORTER


inherit
	ESA_SUPPORT_LOGIN

create
	make

feature -- Basic operations

	report_bug (a_report: ESA_SUPPORT_BUG_REPORT)
			-- Report a bug.
			-- Note: A login must be performed before attempting to submit a report.
			--
			-- `a_report': Report to submit to the public bug report system.
		require
			is_support_accessible: is_support_accessible
			is_logged_in: is_logged_in
			a_report_attached: a_report /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				last_reported_uri := Void
				fill_bug_report (a_report)
			end
		rescue
			if
				attached (create {EXCEPTION_MANAGER}).last_exception as l_exception and then
				attached l_exception.description as l_description
			then
				create {STRING_32} last_error.make_from_string_general (l_description)
			end
			is_bad_request := True
			retried := True
			retry
		end

feature -- Access

	last_reported_uri: detachable STRING_8
			-- URI of the last reported issue.

feature {NONE} -- Basic operations

	fill_bug_report (a_report: ESA_SUPPORT_BUG_REPORT)
			-- Filling a bug report after login.
		require
			is_support_accessible: is_support_accessible
		local
			l_uri_confirm: STRING_GENERAL
			l_value: STRING_GENERAL
		do
				-- Post bug report and retrieve confirm uri
			l_uri_confirm := perform_preview (a_report)

				-- Get CJ confirm template
			if l_uri_confirm /= Void then
				create {STRING} l_value.make_empty
				l_uri_confirm := confirm_report_uri (l_uri_confirm, l_value)

					-- Final Submit
				if l_uri_confirm /= Void then
					perform_submit (l_uri_confirm, l_value)
				end
			end
		end

	perform_preview (a_report: ESA_SUPPORT_BUG_REPORT): detachable STRING_GENERAL
			-- Post bug report data, then we can go to the bug report preview page.
		require
			is_support_accessible: is_support_accessible
			a_report_attaced: a_report /= Void
		local
			l_tpl: CJ_TEMPLATE
			l_data: CJ_DATA
			lnk: CJ_LINK
			l_resp: ESA_SUPPORT_RESPONSE
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_found: BOOLEAN
		do
			create l_tpl.make

				-- category
			create l_data.make_with_name ("category")
			l_data.set_value (a_report.category.out) -- EiffelStudio
			l_tpl.add_data (l_data)

				-- severity
			create l_data.make_with_name ("severity")
			l_data.set_value (a_report.severity.out)
			l_tpl.add_data (l_data)

				-- priority
			create l_data.make_with_name ("priority")
			l_data.set_value (a_report.priority.out) -- High
			l_tpl.add_data (l_data)

				-- class
			create l_data.make_with_name ("class")
			l_data.set_value (a_report.class_issue.out) -- Bug
			l_tpl.add_data (l_data)

				-- Release
			create l_data.make_with_name ("release")
			l_data.set_value (a_report.release)
			l_tpl.add_data (l_data)

				-- confidential
			create l_data.make_with_name ("confidential")
			l_data.set_value (a_report.confidential.out)
			l_tpl.add_data (l_data)

				-- Synopsis
			create l_data.make_with_name ("synopsis")
			l_data.set_value (a_report.synopsis)
			l_tpl.add_data (l_data)

				-- Environment
			create l_data.make_with_name ("environment")
			if attached a_report.environment as env then
				l_data.set_value (env.as_string_32)
			end
			l_tpl.add_data (l_data)

				-- Description
			create l_data.make_with_name ("description")
			l_data.set_value (a_report.description)
			l_tpl.add_data (l_data)

				-- to_reproduce
			create l_data.make_with_name ("to_reproduce")
			if attached a_report.to_reproduce as l_to_reprod then
				l_data.set_value (l_to_reprod.as_string_32)
			end
			l_tpl.add_data (l_data)

				-- attachments
			create l_data.make_with_name ("attachments")
			l_data.set_value (a_report.attachments)
			l_tpl.add_data (l_data)

			create ctx.make
			if attached last_username as u and attached last_password as p then
				if attached basic_auth (u, p) as l_auth then
					ctx.add_header ("Authorization", l_auth)
				end
			end

			if attached report_form_uri as l_report_form_uri then
				l_resp := create_with_template (l_report_form_uri, l_tpl, ctx)
			else
				check has_report_form_uri: False end
			end

			if l_resp = Void then
				(create {EXCEPTIONS}).raise ("Connection error: missing URL for the report form.")
			elseif l_resp.status /= 200 then
				if attached l_resp.http_response as l_message then
					(create {EXCEPTIONS}).raise ("Connection error: HTTP " + l_message)
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status" + l_resp.status.out)
				end
			else
				if attached l_resp.collection as l_col and then attached l_col.links as l_links then
					across
						l_links as ic
					until
						l_found
					loop
						lnk := ic.item
						if lnk.rel.same_string ("create") then
							if
								attached lnk.prompt as lnk_prompt and then
								lnk_prompt.same_string("Confirm Report")
							then
								l_found := True
								create {STRING_32} Result.make_from_string (lnk.href)
							end
						end
					end
					if Result = Void then
						create {STRING_32} Result.make_empty
					end
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	 perform_submit (a_target_url: STRING_GENERAL; a_value: STRING_GENERAL)
	 		-- Performs final step of submitting a bug report.
	 	require
			is_support_accessible: is_support_accessible
	 		a_target_url_attached: a_target_url /= Void
	 		not_a_target_url_is_empty: not a_target_url.is_empty
	 		a_value_attached: a_value /= Void
	 		not_a_value_is_emoty: not a_value.is_empty
	 	local
			l_tpl: CJ_TEMPLATE
			l_data: CJ_DATA
			l_resp: ESA_SUPPORT_RESPONSE
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
		do
			create l_tpl.make

				-- confirm
			create l_data.make_with_name ("confirm")
			l_data.set_value (a_value) -- EiffelStudio
			l_tpl.add_data (l_data)


			create ctx.make
			if attached last_username as u and then attached last_password as p then
				if attached basic_auth (u, p) as l_auth then
					ctx.add_header ("Authorization", l_auth)
				end
			end

			l_resp := create_with_template (a_target_url, l_tpl, ctx)
			if l_resp.status /= 200 then
				if attached l_resp.http_response as l_message then
					(create {EXCEPTIONS}).raise ("Connection error: HTTP " + l_message)
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status" + l_resp.status.out)
				end
			else
				if attached l_resp.collection as l_col then
					if attached {ARRAYED_LIST [CJ_ITEM]} l_col.items as l_items and then
					   not l_items.is_empty and then l_items.count > 1
					then
						last_reported_uri := l_items.at (1).href
					end
				end

			end
		end

feature {NONE} -- Html contents

	confirm_report_uri (a_uri: STRING_GENERAL; a_value: STRING_GENERAL): detachable STRING_GENERAL
			-- Confirm report URI `a_uri' and set the value.
		require
			a_uri_not_void: a_uri /= Void
			not_a_uri_is_empty: not a_uri.is_empty
			is_support_accessible: is_support_accessible
		local
			ctx : HTTP_CLIENT_REQUEST_CONTEXT
			l_resp: ESA_SUPPORT_RESPONSE
			l_found: BOOLEAN
			l_data: CJ_DATA
		do
			create ctx.make
			if
				attached last_username as u and then attached last_password as p and then
				attached basic_auth (u, p) as l_auth
			then
				ctx.add_header ("Authorization", l_auth)
			end

			l_resp := get (a_uri, ctx)

			if l_resp.status /= 200 then
				if attached l_resp.http_response as l_message then
					(create {EXCEPTIONS}).raise ("Connection error: HTTP " + l_message)
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status" + l_resp.status.out)
				end
			else
				if attached l_resp.collection as l_col then
					create {STRING_32} Result.make_from_string (l_col.href)
					if
						attached l_col.template as l_template and then
					  	attached l_template.data as l_data_list
					then
						across
							l_data_list as ic
						until
							l_found
						loop
							l_data := ic.item
							if
								l_data.name.same_string ("confirm") and then
								attached l_data.value as val
							then
								a_value.append (val)
								l_found := True
							end
						end

					end
				end
			end
		end


feature -- Access

	report_form_uri: detachable STRING_8
			-- Report form URI.
		do
			Result := retrieve_url ("create_report_form", "Report a Problem")
		end

end
