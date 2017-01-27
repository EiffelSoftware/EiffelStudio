note
	description: "[
			Request handler related to 
				/blog/{user}/ 
				or /blog/{user}?page={page}. 
				
			Displays all posts of the given user

		]"
	contributor: "Dario B�sch <daboesch@student.ethz.ch>"
	date: "$Date$"
	revision: "$Revision 96616$"
	fixme: "redesign pagination... see CMS_PAGINATION_GENERATOR."

class
	BLOG_USER_HANDLER

inherit
	BLOG_HANDLER
		redefine
			do_get,
			posts,
			total_entries,
			append_page_title_html_to,
			base_path
		end

create
	make

feature -- Global Variables

	user: detachable CMS_USER

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_error: NOT_FOUND_ERROR_CMS_RESPONSE
		do
			check user_void: user = Void end
			if attached user_from_request (req) as l_user then
				user := l_user
					-- Output the results, similar as in the blog hanlder (but with other queries)
				Precursor (req, res)
			else
					-- Throw a bad request error because the user is not valid
				create l_error.make (req, res, api)
				if attached user_parameter (req) as l_user_id then
					l_error.set_main_content ("<h1>Error</h1>User with id " + api.html_encoded (l_user_id) + " not found!</h1>")
				else
					l_error.set_main_content ("<h1>Error</h1>User not found!</h1>")
				end
				l_error.execute
			end
			user := Void
		end

feature -- Query

	user_from_request (req: WSF_REQUEST): detachable CMS_USER
			-- Eventual user with given id in the path of request `req'.
		local
			uid: INTEGER_64
		do
			if
				attached user_parameter (req) as l_user_id and then
				not l_user_id.is_whitespace
			then
				if l_user_id.is_integer_64 then
					uid := l_user_id.to_integer_64
					if uid > 0 then
						Result := api.user_api.user_by_id (uid)
					end
				else
					Result := api.user_api.user_by_name (l_user_id)
				end
			else
					-- Missing or invalid user id.
			end
		end

	user_parameter (req: WSF_REQUEST): detachable STRING_32
			-- User id from path /blog/{user}.
			-- Unsigned integer since negative ids are not allowed.
			-- If no valid id can be read it returns -1
		do
			if attached {WSF_STRING} req.path_parameter ("user") as l_user_id then
				Result := l_user_id.value
			end
		end

	posts: LIST [CMS_BLOG]
			-- Blog posts to display on given page.
			-- Filters out the posts of the current user.
		do
			if attached user as l_user then
				Result := blog_api.blogs_from_user_order_created_desc_limited (l_user, entries_per_page, entries_per_page * (page_number - 1))
			else
				create {ARRAYED_LIST [CMS_BLOG]} Result.make (0)
			end
		end

	total_entries : NATURAL_32
			-- Returns the number of total entries/posts of the current user
		do
			if attached user as l_user then
				Result := blog_api.blogs_count_from_user (l_user).to_natural_32
			else
				Result := Precursor
			end
		end

feature -- HTML Output

	append_page_title_html_to (a_output: STRING)
			-- Returns the title of the page as a html string. It shows the current page number and the name of the current user
		do
			a_output.append ("<h2>Posts from ")
			if attached user as l_user then
				a_output.append (html_encoded (l_user.name))
			else
				a_output.append ("unknown user")
			end
			if multiple_pages_needed then
				a_output.append (" (Page " + page_number.out + " of " + pages_count.out + ")")
					-- Get the posts from the current page (limited by entries per page)
			end
			a_output.append ("</h2>")
		end

	base_path : STRING
			-- Path to page listing all blogs.
			-- If user is logged in, include user id
		do
			if attached user as l_user then
				Result := "/blog/" + l_user.id.out
			else
				Result := Precursor
			end
		end

end
