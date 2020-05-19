note
	description: "Used by {EW_EQA_TEST_EWEASEL_TCF_CONVERTER} only"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_EQA_TEST_EWEASEL_CATALOG_CONVERTER

feature -- Command

	convert_catalog (a_input_file: PATH)
			-- Convert `a_input_file' which is eweasel testing catalog file
		require
			not_void: a_input_file /= Void
		do
			create catalog_file.make (a_input_file)
			catalog_file.parse ((create {EW_EQA_TEST_FACTORY}).environment)
		ensure
			ready: is_ready
		end

	append_related_setup (a_folder_name: READABLE_STRING_32; a_content_to_append: STRING_32)
			-- Append related setup line to `a_content_to_append'
			-- Set `test_arguments' if possible
		require
			ready: is_ready
			not_void: a_folder_name /= Void
			not_void: a_content_to_append /= Void
			cleared: test_arguments = Void
		local
			l_item: TUPLE [a_description, a_argument: READABLE_STRING_32]
		do
			l_item := catalog_file.all_test_instructions.item (a_folder_name)
			if l_item /= Void then
				a_content_to_append.append ("%N%T%T%Tinit (")
				a_content_to_append.append ({STRING_32} "%"" + a_folder_name + "%")")

				test_arguments := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_item.a_argument)
			else
				a_content_to_append.append ("%N%T%T%T--not found in catalog file")
			end
		end

	clear_test_arguments
			-- Set `test_arguments' with void
		do
			test_arguments := Void
		ensure
			cleared: test_arguments = Void
		end

feature -- Query

	is_ready: BOOLEAN
			-- If ready for append string?
		do
			Result := catalog_file /= Void
		end

	has_folder_name (a_test_folder_name: STRING): BOOLEAN
			-- If `a_test_folder_name' can be found in catalog file?
		require
			is_ready: is_ready
		do
			Result := catalog_file.all_test_instructions.has (a_test_folder_name)
		end

	test_arguments: detachable STRING
			-- Test arguments if available

feature {NONE} -- Implementation

	catalog_file: EW_EQA_TEST_CATALOG_FILE
			-- Related catalog file

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

end
