note
	description: "[
		No comment yet.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_UTILITIES

inherit
	EQA_TEST_SET

feature -- Test routines

	test_scan_for_files
			--
		local
			i: LINKED_LIST [STRING]
			e: LINKED_LIST [STRING]
			u: XU_FILE_UTILITIES
			r: LINKED_LIST [FILE_NAME]
		do
			create u
			create i.make
			create e.make
			create r.make

			i.force ("*.ecf")
			i.force ("*.e")

			e.force ("EIFGENs")
			e.force (".svn")

			r := u.scan_for_files ("C:\xebra", 5, i, e);


			assert ("Ok", True)
		end





end


