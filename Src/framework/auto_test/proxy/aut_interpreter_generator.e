note

	description:

		"Objects that create interpreters"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_INTERPRETER_GENERATOR

inherit
	AUT_SHARED_PATHNAMES
		export {NONE} all end

	AUT_SHARED_FILE_SYSTEM_ROUTINES
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM

	REFACTORING_HELPER

	AUT_SHARED_INTERPRETER_INFO
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make (a_session: like session)
			-- Initialize `system' with `a_system'.
		require
			a_session_not_void: a_session /= Void
		do
			session := a_session
		ensure
			session_set: session = a_session
		end

feature -- Access

	system: SYSTEM_I
			-- <Precursor>
		do
			Result := session.system
		end

feature {NONE} -- Access

	session: TEST_GENERATOR
			-- Current session

feature -- Access

	last_interpreter: detachable AUT_INTERPRETER_PROXY
			-- Proxy for the last interpreter created

feature -- Generation

	generate_interpreter_skeleton (a_pathname: STRING)
			-- Generate skeleton (supporting files) of interpreter in location `a_pathname'.
			-- `a_pathname' should be an absolute path.
		require
			a_pathname_attached: a_pathname /= Void
			not_a_pathname_is_empty: not a_pathname.is_empty
			a_pathname_is_absolute: file_system.is_absolute_pathname (a_pathname)
		do
			file_system.recursive_create_directory (a_pathname)
			file_system_routines.copy_recursive (pathnames.runtime_dirname.name, file_system.pathname (a_pathname, "runtime"))
		end

	create_interpreter (a_log_dirname: READABLE_STRING_GENERAL)
			-- Create interpreter proxy based on executable found in `a_pathname'
			-- and make it available via `last_interpreter'.
			--
			-- TODO: use log dirname information from `session'
		require
			a_log_dirname_not_void: a_log_dirname /= Void
			a_log_dirname_not_empty: not a_log_dirname.is_empty
		local
			executable_filename: PATH
			l_new: like last_interpreter
			u: GOBO_FILE_UTILITIES
		do
			u.create_directory (a_log_dirname)
			executable_filename := system.eiffel_system.application_name (True)

			--compute_interpreter_root_class
			if u.file_path_exists (executable_filename) and interpreter_root_class /= Void then
				create l_new.make (
					executable_filename.name,
					system,
					u.make_file_name_in ("interpreter_log.txt", a_log_dirname),
					u.make_file_name_in ("proxy_log.txt", a_log_dirname),
					session.error_handler)
				l_new.add_observer (session.error_handler)
				l_new.set_timeout (session.proxy_time_out.as_integer_32)
			end
			last_interpreter := l_new
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
