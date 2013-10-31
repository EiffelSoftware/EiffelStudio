note
	description: "Summary description for {PACKAGE_SCAN_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_SCAN_VISITOR

inherit
	PACKAGE_NULL_VISITOR
		redefine
			visit_folder
		end

	SHARED_FILE_SYSTEM

create
	make,
	make_with_depth

feature {NONE} -- Initialization

	make
		do
			create ecf_scanner.make
		end

	make_with_depth (n: INTEGER)
		do
			create ecf_scanner.make_with_depth (n)
		end

feature {NONE} -- Implementation

	ecf_scanner: LIBRARY_ECF_SCANNER

feature -- Access

	maximum_depth: INTEGER
		do
			Result := ecf_scanner.max_depth
		end

feature -- Change

	reset
		do
			ecf_scanner.reset
		end

feature -- Visitor

	visit_folder (p: PATH)
		local
			l_scanner: LIBRARY_ECF_SCANNER
		do
			l_scanner := ecf_scanner
			l_scanner.process_directory (p)
			across l_scanner.items as ic loop
				visit_ecf_file (ic.item)
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
