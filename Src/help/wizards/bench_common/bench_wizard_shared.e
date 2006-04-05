indexing
	description	: "This class is inherited by all the application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BENCH_WIZARD_SHARED

inherit
	ARGUMENTS

feature -- Shared variables

	callback_content: STRING is
			-- Content of the filename used as callback.
		local
			file: PLAIN_TEXT_FILE
		once
			if callback_filename /= Void then
				create file.make_open_read (callback_filename)
		
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

	callback_filename: STRING is
			-- Filename used as callback.
		once
			Result := separate_word_option_value ("callback")
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		ensure
			Result_void_or_not_empty: Result = Void or else not Result.is_empty
		end

	write_bench_notification_cancel is
			-- Write onto the file given as argument that the wizard has been aborded.
		local
			file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				if callback_content /= Void then
						-- Modify the fields
					callback_content.replace_substring_all ("<SUCCESS>", "no")

					if callback_filename /= Void then
						create file.make_open_write (callback_filename)
						file.put_string (callback_content)
						file.close
					end
				end
			end
		rescue
			rescued := True
			retry
		end

	write_bench_notification_ok (wizard_information: BENCH_WIZARD_INFORMATION) is
			-- Write onto the file given as argument the project ace file, directory, ...
			-- found in `information'.
		local
			file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				if callback_content /= Void then
						-- Modify the fields
					callback_content.replace_substring_all ("<SUCCESS>", "yes")
					callback_content.replace_substring_all ("<ACE>", wizard_information.ace_location)
					callback_content.replace_substring_all ("<DIRECTORY>", wizard_information.project_location)
					if wizard_information.compile_project then
						callback_content.replace_substring_all ("<COMPILATION>", "yes")
					else
						callback_content.replace_substring_all ("<COMPILATION>", "no")
					end

					if callback_filename /= Void then
						create file.make_open_write (callback_filename)
						file.put_string (callback_content)
						file.close
					end
				end
			end
		rescue
			rescued := True
			retry
		end
		
	Eiffel_projects_directory: STRING is
			-- Directory where projects are created
		once
			Result := (create {EXECUTION_ENVIRONMENT}).get ("ISE_PROJECTS")
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end -- class BENCH_WIZARD_SHARED
