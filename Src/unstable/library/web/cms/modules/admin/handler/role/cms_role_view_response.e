note
	description: "Summary description for {CMS_ROLE_VIEW_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ROLE_VIEW_RESPONSE

inherit
	CMS_RESPONSE
		redefine
			make,
			initialize
		end

create
	make


feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api;)
		do
			create {WSF_NULL_THEME} wsf_theme.make
			Precursor (req, res, a_api)
		end

	initialize
		do
			Precursor
			create {CMS_TO_WSF_THEME} wsf_theme.make (Current, theme)
		end

	wsf_theme: WSF_THEME

feature -- Query

	role_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- Role id passed as path parameter for request `req'.
		local
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end


feature -- Execution

	process
			-- Computed response message.
		local
			uid: INTEGER_64
			user_api : CMS_USER_API
		do
			user_api := api.user_api
			uid := role_id_path_parameter (request)
			if uid > 0 and then attached user_api.user_role_by_id (uid.to_integer) as l_role then
				append_html_to_output (l_role, Current)
			else
				set_main_content ("Missing Role")
			end
		end


	append_html_to_output (a_role: CMS_USER_ROLE; a_response: CMS_RESPONSE )
		local
			lnk: CMS_LOCAL_LINK
			s: STRING
		do
			a_response.set_value (a_role, "role")
			create lnk.make (a_response.translation ("View", Void), "admin/role/" + a_role.id.out)
			lnk.set_is_active (True)
			lnk.set_weight (1)
			a_response.add_to_primary_tabs (lnk)
			create lnk.make (a_response.translation ("Edit", Void), "admin/role/" + a_role.id.out  + "/edit")
			lnk.set_weight (2)
			a_response.add_to_primary_tabs (lnk)

			if a_role /= Void and then a_role.id > 0 then
				create lnk.make (a_response.translation ("Delete", Void), "admin/role/" + a_role.id.out  + "/delete")
				lnk.set_weight (3)
				a_response.add_to_primary_tabs (lnk)
			end

			create s.make_empty
			s.append ("<div class=%"info%"> ")
			s.append ("<h4>Role Information</h4>")
			s.append ("<p>Role:")
			s.append (a_role.name)
			s.append ("</p>")

			s.append ("<h4>Permissions:</h4>")
			if
				not a_role.permissions.is_empty
			then
				s.append ("<ul class=%"cms-permissions%">%N")
				across a_role.permissions as ic loop
					s.append ("<li class=%"cms-permission%">"+ ic.item + "</li>%N")
				end
				s.append ("</ul>%N")

			end

			s.append ("</div>")
			a_response.set_title (a_role.name)
			a_response.set_main_content (s)
		end

end
