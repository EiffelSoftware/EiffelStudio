note
	description: "File system filter."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FILE_SYSTEM_FILTER

inherit
	WSF_FILTER

create
	make_with_path

feature {NONE} -- Initialization

	make_with_path (fn: like path)
		do
			path := fn
		end

	path: PATH

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
		do
			if False then
			else
				execute_next (req, res)
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
