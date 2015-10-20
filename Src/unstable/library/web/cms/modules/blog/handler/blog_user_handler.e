note
	description: "[
			Request handler related to 
				/blogs/user/{id}/ 
				or /blogs/user/{id}/page/{page}. 
				
			Displays all posts of the given user
		]"
	author: "Dario Bösch <daboesch@student.ethz.ch>"
	date: "$Date$"
	revision: "$Revision 96616$"

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

	user : detachable CMS_USER

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_error: NOT_FOUND_ERROR_CMS_RESPONSE
		do
			user := Void
			if attached user_from_request (req) as l_user then
				user := l_user
					-- Output the results, similar as in the blog hanlder (but with other queries)
				Precursor (req, res)
			else
					-- Throw a bad request error because the user is not valid
				create l_error.make (req, res, api)
				l_error.set_main_content ("<h1>Error</h1>User with id " + user_id_path_parameter (req).out + " doesn't exist!")
				l_error.execute
			end
		end

feature -- Query

	user_valid (req: WSF_REQUEST) : BOOLEAN
			-- Returns true if a valid user id is given and a user with this id exists,
			-- otherwise returns false.
		local
			user_id: INTEGER_32
		do
			user_id := user_id_path_parameter (req)

			if user_id <= 0 then
					-- Given user id is not valid
				Result := False
			else
					--Check if user with user_id exists
				Result := api.user_api.user_by_id (user_id) /= Void
			end
		end

	user_from_request (req: WSF_REQUEST): detachable CMS_USER
			-- Eventual user with given id in the path of request `req'.
		local
			uid: like user_id_path_parameter
		do
			uid := user_id_path_parameter (req)
			if uid > 0 then
				Result := api.user_api.user_by_id (uid)
			else
					-- Missing or invalid user id.
			end
		end

	user_id_path_parameter (req: WSF_REQUEST): INTEGER_32
			-- User id from path /blogs/{user}.
			-- Unsigned integer since negative ids are not allowed.
			-- If no valid id can be read it returns -1
		do
			Result := -1
			if attached {WSF_STRING} req.path_parameter ("user") as l_user_id then
				if l_user_id.is_integer then
					Result := l_user_id.integer_value
				end
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
				Result := "/blogs/user/" + l_user.id.out
			else
				Result := precursor
			end
		end

end
