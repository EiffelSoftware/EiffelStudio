indexing
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

feature -- Access

	document_protocol: !STRING_32
			-- Document protocol used by a URI to navigate to the help accessible from the provider.
		once
			create Result.make_empty
			Result.append ("PDF")
		end

	document_description: !STRING_32
			-- Document short description
		once
			create Result.make_empty
			Result.append ("PDF")
		end

feature -- Basic operations

	show_help (a_context_id: !STRING_GENERAL; a_section: ?HELP_CONTEXT_SECTION_I)
			-- <precursor>
		local
			l_file_type: BOOLEAN
			l_str: !STRING
		do
			if {lt_section: HELP_SECTION_EIS_ENTRY}a_section then
				if {lt_entry: EIS_ENTRY}lt_section.entry and then lt_entry.source /= Void and then {lt_src: STRING}lt_entry.source.as_string_8.twin then
					last_entry := lt_entry
					format_uris (lt_src)
					if {lt_others: HASH_TABLE [STRING_32, STRING_32]}lt_entry.others then
						lt_others.search (pdf_type_string.as_string_32)
						if lt_others.found then
							if lt_others.found_item.is_case_insensitive_equal (pdf_type_file_string.as_string_32) then
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

	append_acrobat_url_arguments (a_string: !STRING; a_entry: !EIS_ENTRY) is
			-- Append acrobat url arguments to `a_string'.
		local
			l_args: ?STRING
		do
			l_args := pdf_arguments_from_entry (a_entry)
			if l_args /= Void then
				a_string.append (acrobat_url_sep)
				a_string.append (l_args)
			end
		end

	append_acrobat_command_arguments (a_string: !STRING; a_entry: !EIS_ENTRY) is
			-- Append acrobat command arguments to `a_string'.
		local
			l_args: ?STRING
		do
			l_args := pdf_arguments_from_entry (a_entry)
			a_string.append (acrobat_command_string)
			if {lt_args: STRING}l_args then
				a_string.append (acrobat_action_string)
				a_string.append (quoted_string (lt_args))
				a_string.append (" ")
			end
		end

	pdf_arguments_from_entry (a_entry: !EIS_ENTRY): ?STRING is
			-- PDF arguments from `a_entry'
		local
			l_result: STRING
			l_found: BOOLEAN
		do
			if {lt_others: HASH_TABLE [STRING_32, STRING_32]}a_entry.others then
				create l_result.make (5)
				lt_others.search (acrobat_page)
				if lt_others.found then
					l_result.append (acrobat_page)
					l_result.append (acrobat_attri_sep)
					l_result.append (lt_others.found_item)
					l_found := True
				end
				lt_others.search (acrobat_nameddest)
				if lt_others.found then
					if l_found then
						l_result.append (acrobat_sep)
					end
					l_result.append (acrobat_nameddest)
					l_result.append (acrobat_attri_sep)
					l_result.append (lt_others.found_item)
					l_found := True
				end
				if l_found then
					Result := l_result
				end
			end
		end

	quoted_string (a_string: !STRING): !STRING is
			-- Quoted string of `a_string'
		do
			create Result.make_from_string (a_string)
			Result.prepend ("%"")
			Result.append ("%"")
		end

	launch_command (a_command: !STRING_8) is
			-- Launches a command
		do
			if {l_process: !PROCESS} (create {PROCESS_FACTORY}).process_launcher (a_command, Void, Void) then
				l_process.set_hidden (True)
				l_process.launch
			end
		end

feature {NONE} -- Constants

	pdf_type_string: !STRING = "type"

	pdf_type_file_string: !STRING = "file"

	windows_file_protocol: !STRING = "file:///"

	acrobat_url_sep: !STRING = "#"

	acrobat_sep: !STRING = "&"

	acrobat_attri_sep: !STRING = "="

	acrobat_command_string: !STRING = "acrobat "

	acrobat_action_string: !STRING = "/A "

	acrobat_page: !STRING = "page"

	acrobat_nameddest: !STRING = "nameddest";

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
