note
	description: "[
		Runs xebra_deployer.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XD_APPLICATION

inherit
	ARGUMENTS
	XU_SHARED_OUTPUTTER
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Run the application.
		local
			l_arg_parser: XD_ARGUMENT_PARSER
		do
			log.set_name ("DEPLOYER")
			log.set_debug_level (1)
			create install_dir.make
			create l_arg_parser.make
			l_arg_parser.execute (agent run (l_arg_parser))
		ensure
			install_dir_attached: install_dir /= Void
		end

feature -- Paths

	install_dir: FILE_NAME
			-- Read from argument

	dir_apache_conf: FILE_NAME
			-- The path to config files of apache
		do
			Result := dir_apache.twin
			Result.extend ("conf")
		ensure
			result_attached: Result /= Void
		end

	dir_apache: FILE_NAME
			-- The path to apache
		do
			Result := install_dir.twin
			Result.extend ("apache")
		ensure
			result_attached: Result /= Void
		end

--	dir_www: FILE_NAME
--			-- The path to the www folder
--		do
--			Result := install_dir.twin
--			Result.extend ("www")
--		ensure
--			result_attached: Result /= Void
--		end

	dir_library: FILE_NAME
			-- The path to the framework library folder
		do
			Result := install_dir.twin
			Result.extend ("library")
		ensure
			result_attached: Result /= Void
		end

feature -- Constants


	File_httpd_conf: STRING = "httpd.conf"
		-- The http.conf file (in xebra/apache/conf)

	Key_xebra_install: STRING = "XEBRA_INSTALL"
		-- A key inside httpd.conf that will be replaced

	Key_library_root: STRING = "$XEBRA_LIBRARY"
		-- A key inside various files that will be replaced	

	Key_eiffel_src: STRING = "$EIFFEL_SRC"
		-- A key inside ecf files that will be replaced



feature -- Basic Operations

	run (a_arg_parser: XD_ARGUMENT_PARSER)
			-- Runs the replacing tasks
		require
			a_arg_parser_attached_and_successfull: a_arg_parser /= Void and then a_arg_parser.is_successful
		local
			l_error_printer: XU_ERROR_PRINTER
			l_util: XU_FILE_UTILITIES
		do
			create l_util
			create install_dir.make_from_string (a_arg_parser.install_dir)
			if  l_util.is_dir (install_dir) then
				log.dprint ("Starting...",1)
				process_httpd
				process_ecfs
			else
				error_manager.add_error (create {XERROR_DIR_NOT_FOUND}.make (install_dir), false)
			end

			if not error_manager.is_successful then
				create l_error_printer
				error_manager.trace_errors (l_error_printer)
			end
			log.dprint ("Done. Bye.",1)
		end

feature -- Replacement Tasks

	process_ecfs
			-- Replaces in all ecf files all occurrences of
			--	Key_eiffel_src 	with 	Key_library_root
		local
			l_util: XU_FILE_UTILITIES
			l_files: LIST [FILE_NAME]
			l_incl: LINKED_LIST [STRING]
			l_excl: LINKED_LIST [STRING]
		do
			create l_incl.make
			l_incl.force ("*.ecf")
			create l_excl.make
			l_excl.force (".svn")
			create l_util
			log.dprint ("Scanning for ecf  files in " + dir_library, 1)
			l_files := l_util.scan_for_files (install_dir, -1, l_incl, l_excl)
			from
				l_files.start
			until
				l_files.after
			loop
				log.dprint ("Replacing in " + l_files.item_for_iteration,1)
				l_util.replace_in_file (l_files.item_for_iteration, Key_eiffel_src, Key_library_root)
				l_files.forth
			end
		end

	process_httpd
			-- Replaces in httpd.conf all occurrences of
			--	Key_xebra_install 		with 	install_dirs
		local
			l_util: XU_FILE_UTILITIES
			l_files: LIST [FILE_NAME]
			l_incl: LINKED_LIST [STRING]
		do
			create l_incl.make
			l_incl.force (File_httpd_conf)
			create l_util
			log.dprint ("Scanning for '" + File_httpd_conf + "' in " + dir_apache_conf, 1)
			l_files := l_util.scan_for_files (dir_apache_conf, 1, l_incl, create {LINKED_LIST [STRING]}.make)
			from
				l_files.start
			until
				l_files.after
			loop
				log.dprint ("Replacing in " + l_files.item_for_iteration,1)
				l_util.replace_in_file (l_files.item_for_iteration, Key_xebra_install, install_dir)
				l_files.forth
			end
		end

invariant
	install_dir_attached: install_dir /= Void
end
