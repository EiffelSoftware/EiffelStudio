note
	description: "Summary description for {SCM_STATUS_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_STATUS_LIST

inherit
	ARRAYED_LIST [SCM_STATUS]

create
	make

feature -- Status

	changes_count: INTEGER
		do
			Result := count - unversioned_count
		end

	unversioned_count: INTEGER
		do
			across
				Current as ic
			loop
				if attached {SCM_STATUS_UNVERSIONED} ic.item then
					Result := Result + 1
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
