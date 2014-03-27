note
	description: "Help provider to launch Microsoft .doc files"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_HELP_PROVIDER

inherit
	ES_EIS_ENTRY_HELP_PROVIDER
		redefine
			show_help
		end

create
	make

feature -- Access

	document_protocol: STRING_32
			-- Document protocol used by a URI to navigate to the help accessible from the provider.
		once
			Result := {STRING_32} "DOC"
		end

	document_description: STRING_32
			-- Document short description
		once
			Result := {STRING_32} "DOC"
		end

feature -- Basic operations

	show_help (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I)
			-- <precursor>
		local
			l_word: COM_OBJECT
			l_formatted_source: STRING_32
			l_bookmark: STRING_32
			l_succeed: BOOLEAN
			l_active_doc: COM_OBJECT
		do
			if attached {HELP_SECTION_EIS_ENTRY} a_section as l_section then
				if attached l_section.entry as l_entry and then attached l_entry.source as l_source and then not l_source.is_empty then
					last_entry := l_entry
					l_formatted_source := l_source
					format_uris (l_formatted_source)

					if {PLATFORM}.is_windows then
							-- Try to get the running object first.
						create l_word.make_active_object_with_program_id (word_application_string)
						if not l_word.is_successful then
							create l_word.make_with_program_id (word_application_string)
						end
						if l_word.is_successful then
								-- Show Word
							l_word.call_property_put ("Visible", [True])
							if l_word.is_successful then
								l_word.call_method ("Activate", Void)
							end
							if l_word.is_successful then
									-- Try to get the doc if it is alread open
								l_word.call_property_get ("Documents", [l_formatted_source])
								if l_word.is_successful then
									l_active_doc :=	l_word.last_object
								else
									l_word.call_property_get ("Documents", Void)
									if attached l_word.last_object as l_documents then
											-- Open the file
										l_documents.call_method ("Open", [l_formatted_source])
										l_succeed := l_documents.is_successful
											-- Get and go to bookmark if any.
										if l_succeed and then attached l_entry.parameters as l_parameters then
											l_parameters.search (bookmark_string)
											if l_parameters.found then
												l_bookmark := l_parameters.found_item
												if attached l_documents.last_object as l_doc then
													l_active_doc := l_doc
												end
											end
										end
									end
								end
								if l_active_doc /= Void then
									l_active_doc.call_property_get ("Bookmarks", Void)
									if attached l_active_doc.last_object as l_bookmarks then
										l_bookmarks.call_method ("Item", [l_bookmark])
											-- Go to the bookmark
										if attached l_bookmarks.last_object as l_bookmark_object then
											l_bookmark_object.call_method ("Select", Void)
										end
									end
								end
							end
						end
					end
				end
			end
			if not l_succeed then
						-- Word is not available or for Unix, go for the default
						-- Do not support properties like "bookmark"
				Precursor {ES_EIS_ENTRY_HELP_PROVIDER}(a_context_id, a_section)
			end
		end

feature {NONE} -- Constants

	bookmark_string: STRING_32 = "bookmark"
	word_application_string: STRING_32 = "Word.Application"

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
