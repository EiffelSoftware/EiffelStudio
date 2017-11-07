note
	description: "[
			Request path info is associated with existing file or folder.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTING_PATH_EXISTS_CONDITION

inherit
	WSF_ROUTING_CONDITION

create
	make

feature {NONE} -- Creation

	make (a_parent_location: PATH)
		do
			parent_location := a_parent_location
		end

feature -- Access

	parent_location: PATH

feature -- Status report

	path_exists (p: PATH): BOOLEAN
		local
			fut: FILE_UTILITIES
		do
			Result := fut.file_path_exists (p) or fut.directory_path_exists (p)
		end

	accepted (req: WSF_REQUEST): BOOLEAN
			-- Does `req` satisfy Current condition?
		local
			l_path: READABLE_STRING_GENERAL
			p: PATH
		do
			l_path := req.path_info
			if not l_path.is_empty then
				if l_path[1] = '/' then
					l_path := l_path.substring (2, l_path.count)
				end
				p := parent_location.extended (l_path)
				Result := path_exists (p)
			end
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
