note
	description: "[
			Object that represents a Facebook Page
			The /{page-id} node returns a single page.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Facebook Page", "https://developers.facebook.com/docs/graph-api/reference/page/", "protocol=uri"

class
	FB_PAGE

inherit

	DEBUG_OUTPUT

feature -- Access

	id: detachable STRING
			-- Page ID


	about: detachable STRING_32
			-- Information about the Page.


	description: detachable STRING_32
			-- The description of the Page	.	

feature -- Change Element

	set_id (a_id: like id)
			-- Set  `id' with `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_about (a_about: like about)
			-- Set `about' with `a_about'.
		do
			about := a_about
		ensure
			about_set: about = a_about
		end

	set_description (a_description: like description)
			-- Set `description' with `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>.
		local
			l_result: STRING
		do
			create l_result.make_empty

			if attached id as l_id then
				l_result.append_string ("PAGE id: ")
				l_result.append_string (l_id)
				l_result.append_string ("%"")
				l_result.append ("%N")
			end

			if attached about as l_about  then
				l_result.append_string (" %"about: ")
				l_result.append_string (l_about)
				l_result.append_string ("%"")
				l_result.append ("%N")
			end

			if attached description as l_description  then
				l_result.append_string (" %"description: ")
				l_result.append_string (l_description)
				l_result.append_string ("%"")
				l_result.append ("%N")
			end

			Result := l_result
		end



end
