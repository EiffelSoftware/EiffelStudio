note
	description: "Summary description for {CP_TUPLE_IMPORTER_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CP_TUPLE_IMPORTER_TESTS

inherit
	EQA_TEST_SET

feature

	test_expanded_import
			-- Check if an import with a user-defined expanded attribute really fails.
		local
			support: separate SUPPORT
			importer: CP_TUPLE_IMPORTER
		do
			create support
			create importer

			assert ("importable", not importer.is_importable (support_new_tuple_with_expanded (support)))
		end

	test_truly_separate_import
			-- Check if an import succeeds with a truly separate attribute.
		local
			support: separate SUPPORT
			importer: CP_TUPLE_IMPORTER
			any: separate ANY
			imported: TUPLE
		do
			create support
			create importer
			create any

			assert ("not_importable", importer.is_importable (support_wrap (support, any)))
			
			imported := importer.import (support_wrap (support, any))
			assert ("not_equal", any = imported [1])
		end

feature {NONE} -- Implementation

	support_new_tuple_with_expanded (a_support: separate SUPPORT): separate TUPLE [ETEST]
		do
			Result := a_support.new_tuple_with_expanded
		end

	support_wrap (a_support: separate SUPPORT; obj: detachable separate ANY): separate TUPLE [detachable separate ANY]
		do
			Result := a_support.wrap (obj)
		end

end
