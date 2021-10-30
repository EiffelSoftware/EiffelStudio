note
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_SCAN_VISITOR

inherit
	PACKAGE_NULL_VISITOR
		redefine
			visit_folder
		end

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Change

	reset
		do
		end

feature -- Visitor

	visit_folder (p: PATH)
		local
			l_scanner: LIBRARY_ECF_SCANNER
		do
			create l_scanner.make
			l_scanner.process_directory (p)
			across l_scanner.items as ic loop
				visit_ecf_file (ic)
			end
		end

	visit_folder_with_depth (p: PATH; a_max_depth: INTEGER)
		local
			l_scanner: LIBRARY_ECF_SCANNER
		do
			create l_scanner.make_with_depth (a_max_depth)
			l_scanner.process_directory (p)
			across l_scanner.items as ic loop
				visit_ecf_file (ic)
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
