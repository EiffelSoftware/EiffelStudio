note
	description: "This class is inherited by all the application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]", "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	BENCH_WIZARD_SHARED

inherit
	ARGUMENTS_32

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Shared variables

	callback_content: detachable STRING
			-- Content of the filename used as callback.
		local
			file: PLAIN_TEXT_FILE
		once
			if attached callback_filename as n then
				create file.make_with_name (n)
				file.open_read
					-- Read the file.
				create Result.make (0)
				from
				until
					file.end_of_file
				loop
					file.read_line
					Result.append (file.last_string+"%N")
				end
				file.close
			end
		end

	callback_filename: detachable STRING_32
			-- Filename used as callback.
		once
			if attached separate_word_option_value ("callback") as s and then not s.is_empty then
				Result := s.as_string_32
			end
		ensure
			Result_void_or_not_empty: Result = Void or else not Result.is_empty
		end

	write_bench_notification_cancel
			-- Write onto the file given as argument that the wizard has been aborded.
		local
			file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if
				not rescued and then
				attached callback_content as c and then
				attached callback_filename as n
			then
					-- Modify the fields
				c.replace_substring_all ("<SUCCESS>", "no")
				create file.make_with_name (n)
				file.open_write
				file.put_string (c)
				file.close
			end
		rescue
			rescued := True
			retry
		end

	write_bench_notification_ok (wizard_information: BENCH_WIZARD_INFORMATION)
			-- Write onto the file given as argument the project ace file, directory, ...
			-- found in `information'.
		local
			file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
			u: UTF_CONVERTER
		do
			if
				not rescued and then
				attached callback_content as c and then
				attached callback_filename as n
			then
					-- Modify the fields
				c.replace_substring_all ("<SUCCESS>", "yes")
				c.replace_substring_all ("<ACE>", u.string_32_to_utf_8_string_8 (wizard_information.ace_location.name))
				c.replace_substring_all ("<DIRECTORY>", u.string_32_to_utf_8_string_8 (wizard_information.project_location.name))
				if wizard_information.compile_project then
					c.replace_substring_all ("<COMPILATION>", "yes")
				else
					c.replace_substring_all ("<COMPILATION>", "no")
				end
				if wizard_information.freeze_required then
					c.replace_substring_all ("<COMPILATION_TYPE>", "freeze")
				else
					c.replace_substring_all ("<COMPILATION_TYPE>", "melt")
				end
				create file.make_with_name (n)
				file.open_write
				file.put_string (c)
				file.close
			end
		rescue
			rescued := True
			retry
		end

feature {NONE} -- Implementation

	pixmap_icon_location: PATH
			-- Icon for the Eiffel Wel Wizard.
		once
			create Result.make_from_string ("eiffel_wizard_icon" + (create {WIZARD_SHARED}).pixmap_extension)
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
