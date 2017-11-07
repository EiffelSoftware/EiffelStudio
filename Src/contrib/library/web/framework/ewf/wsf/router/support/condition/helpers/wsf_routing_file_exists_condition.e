note
	description: "[
			Request path info is associated with existing file.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTING_FILE_EXISTS_CONDITION

inherit
	WSF_ROUTING_PATH_EXISTS_CONDITION
		redefine
			path_exists
		end

create
	make

feature -- Status report

	path_exists (p: PATH): BOOLEAN
		local
			fut: FILE_UTILITIES
		do
			Result := fut.file_path_exists (p)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
