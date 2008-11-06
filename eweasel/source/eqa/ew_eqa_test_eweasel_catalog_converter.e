indexing
	description: "Used by {EW_EQA_TEST_EWEASEL_TCF_CONVERTER} only"
	date: "$Date$"
	revision: "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";

class
	EW_EQA_TEST_EWEASEL_CATALOG_CONVERTER

feature -- Access


feature -- Command

	convert_catalog (a_input_file: STRING) is
			-- Convert `a_input_file' which is eweasel testing catalog file
		require
			not_void: a_input_file /= Void
		local

			l_factory: EW_EQA_TEST_FACTORY
		do
			create catalog_file.make (a_input_file)
			create l_factory
			catalog_file.parse (l_factory.environment)
		ensure
			ready: is_ready
		end

	append_related_setup (a_folder_name: STRING; a_content_to_append: STRING) is
			-- Append related setup line to `a_content_to_append'
		require
			ready: is_ready
			not_void: a_folder_name /= Void
			not_void: a_content_to_append /= Void
		local
			l_item: TUPLE [a_description, a_argument: STRING]
		do
			l_item := catalog_file.all_test_instructions.item (a_folder_name)
			if l_item /= Void then
				a_content_to_append.append ("%N%T%T%Ttest_setup.setup_one_test_case (")
				a_content_to_append.append ("%"" + l_item.a_description + "%", ")
				a_content_to_append.append ("%"" + a_folder_name + "%", ")
				a_content_to_append.append ("%"" + l_item.a_argument + "%")")
			else
				a_content_to_append.append ("%N%T%T%T--not found in catalog file")
			end
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

feature {NONE} -- Implementation

	catalog_file: EW_EQA_TEST_CATALOG_FILE
			-- Related catalog file

;indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
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
