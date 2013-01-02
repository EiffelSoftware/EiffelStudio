note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	BASIC_TEST

inherit
	EQA_TEST_SET

	EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

feature -- Test routines

	test_word
			-- New test routine
		local
			l_word_app: COM_OBJECT
		do
			create l_word_app.make_with_program_id ("Word.Application")
			assert ("Word Application not found", l_word_app.is_successful)

			l_word_app.call_property_put ("Visible", [True])
			assert ("Call failed", l_word_app.is_successful)

			create l_word_app.make_active_object_with_program_id ("Word.Application")
			assert ("Call failed", l_word_app.is_successful)

			l_word_app.call_method ("Activate", Void)
			assert ("Call failed", l_word_app.is_successful)

			l_word_app.call_property_get ("Documents", Void)
			if attached l_word_app.last_object as l_documents then
				l_documents.call_method ("Add", Void)
				assert ("Call failed", l_documents.is_successful)

				l_documents.call_method ("Open", [test_file_name])
				if attached l_documents.last_object as l_active_doc then
					l_active_doc.call_property_get ("Bookmarks", Void)
					if attached l_active_doc.last_object as l_bookmarks then
						l_bookmarks.call_method ("Item", [bookmark_name])
						if attached l_bookmarks.last_object as l_bookmark then
							l_bookmark.call_method ("Select", Void)
						else
							assert ("Call failed", l_bookmarks.is_successful)
						end
					else
						assert ("Call failed", l_active_doc.is_successful)
					end

					l_active_doc.call_property_get ("ActiveWindow", Void)
					if attached l_active_doc.last_object as l_active_window then
						l_active_window.call_property_get ("Selection", Void)
						if attached l_active_window.last_object as l_selection then
							l_selection.call_property_get ("Text", Void)
							assert ("Got selection", attached l_selection.last_string as l_str and then l_str.is_equal ("test 2"))
						else
							assert ("Call failed", l_active_doc.is_successful)
						end
					else
						assert ("Call failed", l_active_doc.is_successful)
					end

					l_active_doc.call_method ("Close", Void)
					assert ("Call failed", l_active_doc.is_successful)
				else
					assert ("Call failed", l_documents.is_successful)
				end

				l_word_app.call_method ("Quit", Void)
				assert ("Call failed", l_word_app.is_successful)
			else
				assert ("Call failed", l_word_app.is_successful)
			end
		end

feature {NONE} -- Access

	test_file_name: STRING
		once
			if attached get ("EIFFEL_SRC") as l_str then
				Result := l_str
				Result.append_character (Operating_environment.directory_separator)
				Result.append_string ("framework")
				Result.append_character (Operating_environment.directory_separator)
				Result.append_string ("com_light")
				Result.append_character (Operating_environment.directory_separator)
				Result.append_string ("tests")
				Result.append_character (Operating_environment.directory_separator)
				Result.append_string (file_name)
			else
				Result := file_name
			end
		end

	file_name: STRING = "test.docx"

	bookmark_name: STRING = "test2"

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


