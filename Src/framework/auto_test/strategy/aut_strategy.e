note

	description:

		"Abstract strategy communicating with a interpreter"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


deferred class AUT_STRATEGY

inherit
	AUT_TASK

	AUT_SHARED_PATHNAMES

feature {NONE} -- Initialization

	make (a_interpreter: like interpreter; a_system: like system; an_error_handler: like error_handler)
			-- Create new strategy.
		require
			a_system_not_void: a_system /= Void
			an_error_handler_not_void: an_error_handler /= Void
		local
			l_dirname: DIRECTORY_NAME
		do
			interpreter := a_interpreter
			system := a_system
			error_handler := an_error_handler

				-- TODO: create a AUT_SESSION object and retrieve paths from there...
			create l_dirname.make_from_string (system.eiffel_project.project_directory.testing_results_path)
			l_dirname.extend ("auto_test")
			l_dirname.extend ("log")
			log_dirname := l_dirname
		ensure
			system_set: system = a_system
			error_handler_set: error_handler = an_error_handler
		end

feature -- Access

	system: SYSTEM_I
			-- system

	interpreter: AUT_INTERPRETER_PROXY
			-- Proxy to the interpreter used to execute tests

feature {NONE} -- Access

	log_dirname: STRING
			-- Logging directory

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

feature -- Execution

	start
			-- <Precursor>
		do
			if not interpreter.is_running then
				interpreter.start
			end
		end

	cancel
		do
		end

feature {NONE} -- Execution

invariant
	system_not_void: system /= Void
	interpreter_not_void: interpreter /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
