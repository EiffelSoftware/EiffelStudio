note
	description: "Summary description for {CMS_WISH_CATEGORIES_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_CATEGORIES_HANDLER

inherit

	CMS_WISH_LIST_ABSTRACT_HANDLER

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end


feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			u: CMS_WISH_LIST_CATEGORY
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
			l_count: INTEGER
		do
				-- At the moment the template are hardcoded, but we can
				-- get them from the configuration file and load them into
				-- the setup class.

			create {FORBIDDEN_ERROR_CMS_RESPONSE} l_response.make (req, res, api)
			if l_response.has_permission ("create wish") then

				l_count := wish_api.categories_count

				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

				create s.make_empty
				if l_count > 1 then
					l_response.set_title ("Listing " + l_count.out + " Categories")
				else
					l_response.set_title ("Listing " + l_count.out + " Category")
				end

				create s_pager.make_empty
				create l_page_helper.make ("resources/wish/categories/?page={page}&size={size}", wish_api.categories_count.as_natural_32, 25) -- FIXME: Make this default page size a global CMS settings
				l_page_helper.get_setting_from_request (req)
				if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
					l_page_helper.append_to_html (l_response, s_pager)
					if l_page_helper.page_size > 25 then
						s.append (s_pager)
					end
				end

				if attached wish_api.recent_categories (create {CMS_DATA_QUERY_PARAMETERS}.make (l_page_helper.current_page_offset, l_page_helper.page_size)) as lst then
					s.append ("<ul class=%"cms-categories%">%N")
					across
						lst as ic
					loop
						u := ic.item
						s.append ("<li class=%"cms_category%">")
						s.append ("<a href=%"")
						s.append (req.absolute_script_url ("/resources/wish/category/"+u.id.out))
						s.append ("%">")
						s.append (u.synopsis)
						s.append (" - ")
						s.append (u.is_active.out)
						s.append ("</a>")
						s.append ("</li>%N")
					end
					s.append ("</ul>%N")
				end
					-- Again the pager at the bottom, if needed
				s.append (s_pager)

				s.append (l_response.link ("Add Category", "resources/wish/add/category", Void))

				l_response.set_main_content (s)
				l_response.execute
			else
				l_response.execute
			end
		end
end
