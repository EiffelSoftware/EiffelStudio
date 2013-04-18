note
	description: "Summary description for {WSF_CUSTOM_HEADER_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_CUSTOM_HEADER_FILTER

inherit
	WSF_FILTER

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			create custom_header.make_with_count (n)
		end

feature -- Access

	custom_header: HTTP_HEADER

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		do
			res.put_header_lines (custom_header)
			execute_next (req, res)
		end

note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
