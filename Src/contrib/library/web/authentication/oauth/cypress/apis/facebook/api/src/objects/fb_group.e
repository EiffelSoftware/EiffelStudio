note
	description: "[
			Represents a Facebook group.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= Facebook Group", "src=https://developers.facebook.com/docs/graph-api/reference/v2.9/group", "protocol=uri"
class
	FB_GROUP

inherit

	DEBUG_OUTPUT

feature -- Access

	id: detachable STRING
			-- The group id.

	description: detachable STRING_32
			-- A brief description of the group.

	email: detachable STRING
			-- The email address to upload content to the group. Only current members of the group can use this.

feature -- Change Element

	set_id (a_id: like id)
			-- Set `id' with `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_description (a_description: like description)
			-- Set `description' with `description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_email (a_email: like email)
			-- Set `email' with `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- <Precursor>.
		local
			l_result: STRING
		do
			create l_result.make_empty

			if attached id as l_id then
				l_result.append_string ("GROUP id: ")
				l_result.append_string (l_id)
				l_result.append_string ("%"")
				l_result.append ("%N")
			end

			if attached email as l_email  then
				l_result.append_string (" %"email: ")
				l_result.append_string (l_email)
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
