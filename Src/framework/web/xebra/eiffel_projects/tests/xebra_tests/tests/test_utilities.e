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

	test_encoding_facility
			--
		local
			code: XS_ENCODING_FACILITIES
			d: NATURAL
			b: BOOLEAN
			e: NATURAL
			t: TUPLE [value: NATURAL; flag: BOOLEAN]
		do
			d := 2147483647
			b := false
			create code.make
			e := code.encode_natural (d, b)
			io.new_line
			io.new_line
			assert ("decode ", equal (d, code.decode_natural (e)))
			assert ("decode ", equal (b, code.decode_flag (e)))
			e := code.change_flag (e, true)
			assert ("decode ", equal (d, code.decode_natural (e)))
			assert ("decode ", equal (code.decode_flag (e), true))
			t := code.decode_natural_and_flag (e)
			assert ("decode ", equal (t.value, d))
			assert ("decode ", equal (t.flag, true))
		end




end


