note
	description: "Summary description for {ESA_CORS_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CORS_FILTER

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
			l_header.add_header_key_value ("Access-Control-Allow-Headers", "authorization")
			l_header.add_header_key_value ("Access-Control-Allow-Credentials", "true")
			res.put_header_lines (l_header)
			execute_next (req, res)
		end
end
