note
	description: "Summary description for {FORBIDDEN_ERROR_CMS_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	FORBIDDEN_ERROR_CMS_RESPONSE

inherit
	CMS_RESPONSE
		redefine
			custom_prepare
		end

create
	make,
	make_with_permissions

feature {NONE} -- Initialization

	make_with_permissions (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_perms: ITERABLE [READABLE_STRING_8])
		do
			make (req, res, a_api)
			set_associated_permissions (a_perms)
		end

feature -- Generation

	custom_prepare (page: CMS_HTML_PAGE)
		do
			set_status_code ({HTTP_STATUS_CODE}.forbidden)
			page.register_variable (absolute_url (request.percent_encoded_path_info, Void), "request")
			page.set_status_code (status_code)
			page.register_variable (status_code.out, "code")
		end

feature -- Access

	associated_permissions: detachable ARRAYED_LIST [READABLE_STRING_8]

feature -- Basic operations

	set_associated_permissions (a_perms: ITERABLE [READABLE_STRING_8])
		local
			lst: like associated_permissions
		do
			lst := associated_permissions
			if lst = Void then
				create lst.make (1)
				associated_permissions := lst
			end
			across
				a_perms as ic
			loop
				lst.extend (ic.item)
			end
		end

	set_associated_permission (a_perm: READABLE_STRING_8)
		local
			lst: like associated_permissions
		do
			lst := associated_permissions
			if lst = Void then
				create lst.make (1)
				associated_permissions := lst
			end
			lst.extend (a_perm)
		end

feature -- Execution

	process
			-- Computed response message.
		local
			s: STRING
		do
			set_title ("Forbidden")
			set_page_title ("Forbidden")
			if attached main_content as l_main_content and then not l_main_content.is_whitespace then
					-- Keep existing content!
			else
				s := "<em>Access denied for resource <strong>" + html_encoded (request.request_uri) + "</strong>.</em>"
	--			TODO: add a form to ask for missing permissions.
	--			if
	--				attached user as u and
	--				attached associated_permissions as l_permissions and then
	--				not l_permissions.is_empty
	--			then
	--					-- User signed in
	--					-- Form to request access to this resource.
	--				s.append ("Request access ...")
	--				s.append (": ")
	--				across
	--					l_permissions as ic
	--				loop
	--					s.append_character ('"')
	--					s.append (ic.item)
	--					s.append_character ('"')
	--					s.append (" ")
	--				end
	--			end

				set_main_content (s)
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

