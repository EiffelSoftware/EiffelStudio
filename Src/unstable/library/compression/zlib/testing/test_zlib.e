note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ZLIB

inherit
	EQA_TEST_SET

feature -- Test compress and uncompress

	test_compress
		local
			l_zlib: ZLIB
		do
		end

end


