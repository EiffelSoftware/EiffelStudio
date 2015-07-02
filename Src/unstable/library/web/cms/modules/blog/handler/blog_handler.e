note
	description: "Request handler related to /blogs and /blogs/{page}. Displays all posts in the blog."
	author: "Dario B�sch <daboesch@student.ethz.ch>"
	date: "$Date$"
	revision: "$9661667$"

class
	BLOG_HANDLER

inherit
	CMS_BLOG_HANDLER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

	CMS_API_ACCESS

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for any kind of mapping.
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for URI mapping.
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for URI-template mapping.
		do
			execute (req, res)
		end

feature -- Global Variables

	page_number: NATURAL_32
			-- Current page number.

feature -- HTTP Methods	

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
		do
				-- Read page number from path parameter.
			page_number := page_number_path_parameter (req)

				-- Responding with `main_content_html (l_page)'.
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			l_page.set_main_content (main_content_html (l_page))
			l_page.execute
		end

feature -- Query

	posts: LIST [CMS_NODE]
			-- Blog posts to display on given page ordered by date (descending).
		do
			Result := blog_api.blogs_order_created_desc_limited (
						entries_per_page,
						entries_per_page * (page_number - 1)
					)
		end

	multiple_pages_needed : BOOLEAN
			-- Return if more that one page is needed to display posts.
		do
			Result := entries_per_page < total_entries
		end

	pages_count: NATURAL_32
			-- Number of pages needed to display all posts.
		require
			entries_per_page > 0
		local
			tmp: REAL_32
		do
			tmp := total_entries.to_real_32 / entries_per_page.to_real_32;
			Result := tmp.ceiling.to_natural_32
		end

	page_number_path_parameter (req: WSF_REQUEST): NATURAL_32
			-- Page number from path /blogs/{page}.
			-- Unsigned integer since negative pages are not allowed.
		local
			s: STRING
		do
			Result := 1 -- default if not get variable is set
			if attached {WSF_STRING} req.path_parameter ("page") as p_page then
				s := p_page.value
				if s.is_natural_32 then
					if s.to_natural_32 > 1 then
						Result := s.to_natural_32
					end
				end
			end
		end

	total_entries: NATURAL_32
			-- Total number of entries/posts.
		do
			Result := blog_api.blogs_count.to_natural_32
		end

feature -- HTML Output

	frozen main_content_html (page: CMS_RESPONSE): STRING
			-- Content of the page as a html string.
		do
			create Result.make_empty
			append_main_content_html_to (page, Result)
		end

	append_main_content_html_to (page: CMS_RESPONSE; a_output: STRING)
			-- Append to `a_output, the content of the page as a html string.
		local
			n: CMS_NODE
			lnk: CMS_LOCAL_LINK
		do
				-- Output the title. If more than one page, also output the current page number
			append_page_title_html_to (a_output)

				-- Get the posts from the current page (given by page number and entries per page)
				-- Start list of posts
			a_output.append ("<ul class=%"cms_blog_nodes%">%N")
			across
				posts as ic
			loop
				n := ic.item
				lnk := blog_api.node_api.node_link (n)
				a_output.append ("<li class=%"cms_type_"+ n.content_type +"%">")

					-- Output the creation date
				append_creation_date_html_to (n, a_output)

					-- Output the author of the post
				append_author_html_to (n, a_output)

					-- Output the title of the post as a link (to the detail page)
				append_title_html_to (n, page, a_output)

					-- Output the summary of the post and a more link to the detail page
				append_summary_html_to (n, page, a_output)

				a_output.append ("</li>%N")
			end

				-- End of post list
			a_output.append ("</ul>%N")

				-- Pagination (older and newer links)
			append_pagination_html_to (a_output)
		end

	append_page_title_html_to (a_output: STRING)
			-- Append the title of the page as a html string to `a_output'.
			-- It shows the current page number.
		do
			a_output.append ("<h2>Blog")
			if multiple_pages_needed then
				a_output.append (" (Page " + page_number.out + " of " + pages_count.out + ")")
			end
			a_output.append ("</h2>")
		end

	append_creation_date_html_to (n: CMS_NODE; a_output: STRING)
			-- Append the creation date as a html string to `a_output'.
		local
			hdate: HTTP_DATE
		do
			if attached n.creation_date as l_modified then
				create hdate.make_from_date_time (l_modified)
				hdate.append_to_yyyy_mmm_dd_string (a_output)
				a_output.append (" ")
			end
		end

	append_author_html_to (n: CMS_NODE; a_output: STRING)
			-- Append to `a_output', the author of node `n' as html link to author's posts.
		do
			if attached n.author as l_author then
				a_output.append ("by ")
				a_output.append ("<a class=%"blog_user_link%" href=%"/blogs/user/" + l_author.id.out + "%">" + l_author.name + "</a>")
			end
		end

	append_title_html_to (n: CMS_NODE; page: CMS_RESPONSE; a_output: STRING)
			-- Append to `a_output', the title of node `n' as html link to detail page.
		local
			lnk: CMS_LOCAL_LINK
		do
			lnk := blog_api.node_api.node_link (n)
			a_output.append ("<span class=%"blog_title%">")
			a_output.append (page.link (lnk.title, lnk.location, Void))
			a_output.append ("</span>")
		end

	append_summary_html_to (n: CMS_NODE; page: CMS_RESPONSE; a_output: STRING)
			-- returns a html string with the summary of the node and a link to the detail page
		local
			lnk: CMS_LOCAL_LINK
		do
			if attached n.summary as l_summary then
				lnk := blog_api.node_api.node_link (n)
				a_output.append ("<p class=%"blog_list_summary%">")
				if attached api.format (n.format) as f then
					a_output.append (f.formatted_output (l_summary))
				else
					a_output.append (page.formats.default_format.formatted_output (l_summary))
				end
				a_output.append ("<br />")
				a_output.append (page.link ("See more...", lnk.location, Void))
				a_output.append ("</p>")
			end
		end

	append_pagination_html_to (a_output: STRING)
			-- Append to `a_output' with the pagination links (if necessary).
		local
			tmp: NATURAL_32
		do
			if multiple_pages_needed then
				a_output.append ("<div class=%"pagination%">")

					-- If exist older posts show link to next page
				if page_number < pages_count then
					tmp := page_number + 1
					a_output.append (" <a class=%"blog_older_posts%" href=%"" + base_path + "/page/" + tmp.out + "%"><< Older Posts</a> ")
				end

				-- Delimiter
				if page_number < pages_count AND page_number > 1 then
					a_output.append (" | ")
				end

				-- If exist newer posts show link to previous page
				if page_number > 1 then
					tmp := page_number -1
					a_output.append (" <a class=%"blog_newer_posts%" href=%"" + base_path + "/page/" + tmp.out + "%">Newer Posts >></a> ")
				end

				a_output.append ("</div>")
			end

		end

	base_path : STRING
			-- the path to the page that lists all blogs
		do
			Result := "/blogs"
		end

end
