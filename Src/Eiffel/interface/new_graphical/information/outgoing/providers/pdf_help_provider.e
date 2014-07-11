note
	description: "Help provider to launch pdf files."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PDF_HELP_PROVIDER

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
			Result := {STRING_32} "PDF"
		end

	document_description: STRING_32
			-- Document short description
		once
			Result := {STRING_32} "PDF"
		end

feature -- Basic operations

	show_help (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I)
			-- <precursor>
		local
			l_file_type: BOOLEAN
			l_str: STRING_32
		do
			if attached {HELP_SECTION_EIS_ENTRY} a_section as lt_section then
				if attached lt_section.entry as lt_entry and then lt_entry.source /= Void and then attached lt_entry.source.twin as lt_src then
					last_entry := lt_entry
					format_uris (lt_src)
					if attached lt_entry.parameters as lt_parameters then
						lt_parameters.search (pdf_type_string)
						if lt_parameters.found then
							if lt_parameters.found_item.is_case_insensitive_equal (pdf_type_file_string) then
								l_file_type := True
							end
						end
					end
					if l_file_type then
						if {PLATFORM}.is_windows then
							lt_src.prepend (windows_file_protocol)
							append_acrobat_url_arguments (lt_src, lt_entry)
							launch_uri (lt_src)
						else
							create l_str.make (10)
							append_acrobat_command_arguments (lt_src, lt_entry)
							l_str.append (quoted_string (lt_src))
							launch_command (l_str)
						end
					else
							-- URL is the default solution.
						append_acrobat_url_arguments (lt_src, lt_entry)
						launch_uri (lt_src)
					end
				end
			end
		end

	append_acrobat_url_arguments (a_string: STRING_32; a_entry: EIS_ENTRY)
			-- Append acrobat url arguments to `a_string'.
		require
			a_string_not_void: a_string /= Void
			a_entry_not_void: a_entry /= Void
		do
			if attached pdf_arguments_from_entry (a_entry) as l_args then
				a_string.append (acrobat_url_sep)
				a_string.append (l_args)
			end
		end

	append_acrobat_command_arguments (a_string: STRING_32; a_entry: EIS_ENTRY)
			-- Append acrobat command arguments to `a_string'.
		require
			a_string_not_void: a_string /= Void
			a_entry_not_void: a_entry /= Void
		do
			a_string.append (acrobat_command_string)
			if attached pdf_arguments_from_entry (a_entry) as l_args then
				a_string.append (acrobat_action_string)
				a_string.append (quoted_string (l_args))
				a_string.append_character (' ')
			end
		end

	pdf_arguments_from_entry (a_entry: EIS_ENTRY): detachable STRING_32
			-- PDF arguments from `a_entry'
		require
			a_entry_not_void: a_entry /= Void
		local
			l_result: STRING_32
			l_found: BOOLEAN
		do
			if attached a_entry.parameters as lt_parameters then
				create l_result.make (5)
				lt_parameters.search (acrobat_page)
				if lt_parameters.found then
					l_result.append (acrobat_page)
					l_result.append (acrobat_attri_sep)
					l_result.append (lt_parameters.found_item)
					l_found := True
				end
				lt_parameters.search (acrobat_nameddest)
				if lt_parameters.found then
					if l_found then
						l_result.append (acrobat_sep)
					end
					l_result.append (acrobat_nameddest)
					l_result.append (acrobat_attri_sep)
					l_result.append (lt_parameters.found_item)
					l_found := True
				end
				if l_found then
					Result := l_result
				end
			end
		end

	quoted_string (a_string: READABLE_STRING_32): STRING_32
			-- Quoted string of `a_string'
		require
			a_string_not_void: a_string /= Void
		do
			create Result.make_from_string (a_string)
			Result.prepend_character ('"')
			Result.append_character ('"')
		ensure
			Result_not_void: Result /= Void
		end

	launch_command (a_command: READABLE_STRING_32)
			-- Launches a commdand
		require
			a_command_not_void: a_command /= Void
		do
			if attached (create {PROCESS_FACTORY}).process_launcher (a_command, Void, Void) as l_process then
				l_process.set_hidden (True)
				l_process.launch
			end
		end

feature {NONE} -- Constants

	pdf_type_string: STRING_32 = "type"

	pdf_type_file_string: STRING_32 = "file"

	windows_file_protocol: STRING_32 = "file:///"

	acrobat_url_sep: STRING_32 = "#"

	acrobat_sep: STRING_32 = "&"

	acrobat_attri_sep: STRING_32 = "="

	acrobat_command_string: STRING_32 = "acrobat "

	acrobat_action_string: STRING_32 = "/A "

	acrobat_page: STRING_32 = "page"

	acrobat_nameddest: STRING_32 = "nameddest";

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
