note
	description: "[
				Directory and File visitor
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIRECTORY_VISITOR

feature -- Visitor

	process_directory (dn: PATH)
			-- Visit directory `dn'	
		require
			dn_exists: (create {DIRECTORY}.make_with_path (dn)).exists
		deferred
		end

	process_file (fn: PATH)
			-- Visit file `fn'
		require
			fn_exists: (create {RAW_FILE}.make_with_path (fn)).exists
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
