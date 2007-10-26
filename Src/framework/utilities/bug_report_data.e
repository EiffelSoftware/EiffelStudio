indexing
	description: "[
					The data used for filling a bug report.
					See: https://www2.eiffel.com/support/protected/problem_report_form.aspx (login required)
																											]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BUG_REPORT_DATA

feature -- Query

	username: STRING_GENERAL
			-- User name for login

	password: STRING_GENERAL
			-- Password for login

	release: STRING_GENERAL
			-- Eiffel Studio release version

	environment: STRING_GENERAL
			-- Environment

	synopsis: STRING_GENERAL
			-- Title

	description: STRING_GENERAL
			-- Detail

	to_reproduce: STRING_GENERAL
			-- Way to reproduce

	is_all_data_filled: BOOLEAN is
			-- Is all data filled?
		do
			Result :=	username /= Void and
						password /= Void and
						release /= Void and
						environment /= Void and
						synopsis /= Void and
						description /= Void and
						to_reproduce /= Void
		end

feature -- Command

	set_username (a_username: STRING_GENERAL) is
			-- Set `username' with `a_username'.
		do
			username := a_username
		ensure
			set: username = a_username
		end

	set_password (a_password: STRING_GENERAL) is
			-- Set `password' with `a_password'.
		do
			password := a_password
		ensure
			set: password = a_password
		end

	set_release (a_release: STRING_GENERAL) is
			-- Set `release' with `a_release'.
		do
			release := a_release
		ensure
			set: release = a_release
		end

	set_environment (a_environment: STRING_GENERAL) is
			-- Set `environment' with `a_environment'
		do
			environment := a_environment
		ensure
			set: environment = a_environment
		end

	set_synopsis (a_synopsis: STRING_GENERAL) is
			-- Set `synopsis' with `a_synopsis'
		do
			synopsis := a_synopsis
		ensure
			set: synopsis = a_synopsis
		end

	set_description (a_description: STRING_GENERAL) is
			-- Set `description' with `a_description'
		do
			description := a_description
		ensure
			set: description = a_description
		end

	set_to_reproduce (a_to_reproduce: STRING_GENERAL) is
			-- Set `to_reproduce' with `a_to_reproduce'
		do
			to_reproduce := a_to_reproduce
		ensure
			set: to_reproduce = a_to_reproduce
		end

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
