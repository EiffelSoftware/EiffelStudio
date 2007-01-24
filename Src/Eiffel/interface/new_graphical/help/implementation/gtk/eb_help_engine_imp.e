indexing
	description: "Help engine, displays help context, GTK implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EB_HELP_ENGINE_IMP

inherit
	EB_HELP_ENGINE_I

	EB_SHARED_PREFERENCES

	EB_CONSTANTS

	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization

	make is
		do
		end

feature -- Access

	application_name: STRING is "ec";

feature -- Status Report

	last_show_successful: BOOLEAN
			-- Was last call to `show' successful?

	last_error_message: STRING_GENERAL
			-- Last error message, if any

feature -- Basic Operations

	show (a_help_context: EB_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		local
			cmd: STRING
			url: FILE_NAME
			root: STRING
			exists: BOOLEAN
		do
			cmd := preferences.misc_data.internet_browser_preference.string_value
			if cmd.is_empty then
				last_show_successful := False
			elseif cmd.substring_index ("$url", 1) <= 0 then
				last_show_successful := False
			else
				cmd.append_character (' ')
				root := eiffel_layout.docs_path.twin
				create url.make_from_string (root)
				url.set_file_name (a_help_context.url)
				if (create {DIRECTORY}.make (url)).exists then
					url.set_file_name ("index")
					url.add_extension ("html")
				end
				exists := (create {RAW_FILE}.make (url)).exists
				if exists then
					cmd.replace_substring_all ("$url", url)
					(create {EXECUTION_ENVIRONMENT}).launch (cmd)
					last_show_successful := True
				else
					last_show_successful := False

				end
			end
			if last_show_successful then
				last_error_message := Void
			else
				last_error_message := Warning_messages.w_help_topic_could_not_be_displayed
			end
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

end -- class EB_HELP_ENGINE_IMP
