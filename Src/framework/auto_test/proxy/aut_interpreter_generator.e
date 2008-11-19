indexing

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

create

	make

feature {NONE} -- Initialization

	make (a_system: SYSTEM_I) is
			-- Initialize `system' with `a_system'.
		require
			a_system_not_void: a_system /= Void
		do
			system := a_system
		ensure
			system_set: system = a_system
		end

feature -- Access

	system: SYSTEM_I
			-- System

feature -- Access

	last_interpreter: AUT_INTERPRETER_PROXY
			-- Proxy for the last interpreter created

feature -- Generation

	generate_interpreter_skeleton (a_pathname: STRING) is
			-- Generate skeleton (supporting files) of interpreter in location `a_pathname'.
			-- `a_pathname' should be an absolute path.
		require
			a_pathname_attached: a_pathname /= Void
			not_a_pathname_is_empty: not a_pathname.is_empty
			a_pathname_is_absolute: file_system.is_absolute_pathname (a_pathname)
		do
			file_system.recursive_create_directory (a_pathname)
			file_system_routines.copy_recursive (pathnames.runtime_dirname, file_system.pathname (a_pathname, "runtime"))
		end

	create_interpreter (a_pathname: STRING; a_log_dirname: STRING; a_error_handler: AUT_ERROR_HANDLER) is
			-- Create interpreter proxy based on executable found in `a_pathname'
			-- and make it available via `last_interpreter'.
		require
			a_pathname_not_void: a_pathname /= Void
			a_pathname_not_empty: not a_pathname.is_empty
			a_log_dirname_not_void: a_log_dirname /= Void
			a_log_dirname_not_empty: not a_log_dirname.is_empty
			a_error_handler_not_void: a_error_handler /= Void
		local
			absolute_pathname: STRING
			executable_filename: STRING
		do
			last_interpreter := Void
			absolute_pathname := file_system.absolute_pathname (a_pathname)
			file_system.recursive_create_directory (a_log_dirname)
			executable_filename := system.eiffel_system.application_name (True)

			if file_system.file_exists (executable_filename) then
				create last_interpreter.make (
					executable_filename,
					system,
					file_system.pathname (a_log_dirname, "interpreter_log.txt"),
					file_system.pathname (a_log_dirname, "proxy_log.txt"),
					a_error_handler)
			end
		end

invariant
	system_attached: system /= Void

end
