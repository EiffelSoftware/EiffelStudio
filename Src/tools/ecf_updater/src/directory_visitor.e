note
	description: "Summary description for {DIRECTORY_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIRECTORY_VISITOR

feature -- Visitor

	process_directory (dn: READABLE_STRING_GENERAL)
		deferred
		end

	process_file (fn: READABLE_STRING_GENERAL)
		deferred
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
