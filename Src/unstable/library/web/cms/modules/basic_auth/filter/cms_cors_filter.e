note
	description: "CORS filter"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CORS_FILTER

inherit

	WSF_FILTER

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			l_header: HTTP_HEADER
		do
			create l_header.make
--			l_header.add_header_key_value ("Access-Control-Allow-Origin", "localhost")
			l_header.add_header_key_value ("Access-Control-Allow-Headers", "*")
			l_header.add_header_key_value ("Access-Control-Allow-Methods", "*")
			l_header.add_header_key_value ("Access-Control-Allow-Credentials", "true")
			res.put_header_lines (l_header)
			execute_next (req, res)
		end
end
