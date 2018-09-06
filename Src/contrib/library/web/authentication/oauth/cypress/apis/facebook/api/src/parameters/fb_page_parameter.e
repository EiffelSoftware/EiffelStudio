note
	description: "Summary description for {FB_PAGE_PARAMETER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_PAGE_PARAMETER

-- TODO to be completed.

feature	-- Parameters

	include_about
		do
			include ("about")
		end

	include_access_token
		do
			include ("access_token")
		end

	include_affiliation
		do
			include ("affiliation")
		end

	include_description
		do
			include ("description")
		end

feature -- Access

	parameters: detachable STRING


feature {NONE} -- Implementation

	include (a_val: STRING)
		local
			l_parameters: STRING
		do
			l_parameters := parameters
			if l_parameters /= Void then
				l_parameters.append_character (',')
				l_parameters.append (a_val)
			else
				create l_parameters.make_from_string ("fields=")
				l_parameters.append (a_val)
			end
			parameters := l_parameters
		end
end
