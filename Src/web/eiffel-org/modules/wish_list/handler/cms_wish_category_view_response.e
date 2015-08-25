note
	description: "Summary description for {CMS_WISH_CATEGORY_VIEW_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_CATEGORY_VIEW_RESPONSE

inherit
	CMS_RESPONSE
		rename
			make as make_response
		redefine
			initialize
		end

create
	make


feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_wish_api: CMS_WISH_LIST_API)
		do
			wish_api := a_wish_api
			create {WSF_NULL_THEME} wsf_theme.make
			make_response (req, res, a_api)
		end

	initialize
		do
			Precursor
			create {CMS_TO_WSF_THEME} wsf_theme.make (Current, theme)
		end

	wsf_theme: WSF_THEME

	wish_api: CMS_WISH_LIST_API

feature -- Query

	category_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- Category id passed as path parameter for request `req'.
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
			cid: INTEGER_64
		do
			cid := category_id_path_parameter (request)
			if cid > 0 and then attached wish_api.category_by_id (cid) as l_category then
				append_html_to_output (l_category, Current)
			else
				set_main_content ("Missing Category")
			end
		end

	append_html_to_output (a_category: CMS_WISH_LIST_CATEGORY; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
			s: STRING
		do
			a_response.set_value (a_category, "category")
			create lnk.make (a_response.translation ("View", Void), "resources/wish/category/" + a_category.id.out)
			lnk.set_is_active (True)
			lnk.set_weight (1)
			a_response.add_to_primary_tabs (lnk)
			create lnk.make (a_response.translation ("Edit", Void), "resources/wish/category/" + a_category.id.out  + "/edit")
			lnk.set_permission_arguments (<<"manage admin", "manage users", "manage own user">>)
			lnk.set_weight (2)
			a_response.add_to_primary_tabs (lnk)

			if a_category /= Void and then a_category.id > 0 then
--				create lnk.make (a_response.translation ("Delete", Void), "resources/wish/category/" + a_category.id.out  + "/delete")
--				lnk.set_weight (3)
--				a_response.add_to_primary_tabs (lnk)
			end

				-- FIXME: [04/aug/2015] use a CMS_FORM rather than hardcoded html.
				-- So that other module may easily integrate them-selves to add information.
			create s.make_empty
			s.append ("<div class=%"info%"> ")
			s.append ("<h4>Category Information</h4>")
			s.append ("<p>Synopsis: ")
			s.append (a_category.synopsis)
			s.append ("</p>")
			if attached a_category.description as l_description then
				s.append ("<p>Description: ")
				s.append (l_description)
				s.append ("</p>")
			end
			s.append ("<p>Is Active?:")
			s.append (a_category.is_active.out)
			s.append ("</p>")
			s.append ("</div>")
			a_response.set_title (a_category.synopsis)
			a_response.set_main_content (s)
		end

end
