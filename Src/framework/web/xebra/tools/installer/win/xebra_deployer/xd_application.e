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
			o.set_name ("DEPLOYER")
			o.set_debug_level (10)
			create install_dir.make
			if (create {PLATFORM}).is_windows then
				create l_arg_parser.make
				l_arg_parser.execute (agent run (l_arg_parser))
			else
				o.eprint ("This application is meant to run under windows only.", generating_type)
			end
		ensure
			install_dir_attached: install_dir /= Void
		end

feature -- Paths

	install_dir: FILE_NAME

	dir_apache_conf: FILE_NAME
			-- The directory to config files of apache
		do
			Result := dir_apache.twin
			Result.extend ("conf")
		ensure
			result_attached: Result /= Void
		end

	dir_apache: FILE_NAME
			-- The directory to apache
		do
			Result := install_dir.twin
			Result.extend ("apache")
		ensure
			result_attached: Result /= Void
		end

	dir_www: FILE_NAME
			-- The directory to the www folder
		do
			Result := install_dir.twin
			Result.extend ("www")
		ensure
			result_attached: Result /= Void
		end

	dir_library: FILE_NAME
			-- The directory to the framework library folder
		do
			Result := install_dir.twin
			Result.extend ("library")
		ensure
			result_attached: Result /= Void
		end


feature -- Constants

	File_httpd_conf: STRING = "httpd.conf"
		-- The http.conf file (in apache/conf)

	Key_document_root: STRING = "_DOCUMENT_ROOT_"
		-- A key inside httpd.conf that will be replaced

	Key_server_root: STRING = "_SERVER_ROOT_"
		-- A key inside httpd.conf that will be replaced

	Key_eiffel_projects: STRING  = "$XEBRA_DEV\eiffel_projects"
		-- A key inside ecf files that will be replaced

	Key_eiffel_src: STRING = "$EIFFEL_SRC"
		-- A key inside ecf files that will be replaced


feature -- Operations

	run (a_arg_parser: XD_ARGUMENT_PARSER)
			-- Runs the tasks
			--
			--  blaa
		require
			a_arg_parser_attached_and_successfull: a_arg_parser /= Void and then a_arg_parser.is_successful
		local
			l_error_printer: XU_ERROR_PRINTER
		do
			create install_dir.make_from_string (a_arg_parser.install_dir)
			o.dprint ("Starting...",1)
			process_httpd
			process_ecfs
			if not error_manager.is_successful then
				create l_error_printer
				error_manager.trace_errors (l_error_printer)
			end
			o.dprint ("Done. Bye.",1)
		end

	process_ecfs
			-- Replacesssssss
		local
			l_util: XU_FILE_UTILITIES
			l_files: LIST [FILE_NAME]
		do
			create l_util
			o.dprint ("Scanning for ecf files in " + dir_library, 1)
			l_files := l_util.scan_for_files (dir_library.out, -1, ".+\.ecf", "\.svn")
			from
				l_files.start
			until
				l_files.after
			loop
				o.dprint ("Replacing " + Key_eiffel_projects + " in " + l_files.item_for_iteration,1)
				l_util.replace_in_file (l_files.item_for_iteration, Key_eiffel_projects, install_dir)
				o.dprint ("Replacing " +Key_eiffel_src + " in " + l_files.item_for_iteration,1)
				l_util.replace_in_file (l_files.item_for_iteration, Key_eiffel_src, dir_library )
				l_files.forth
			end
		end

	process_httpd
			-- Replaces all occurrences of Key_document_root and Key_server_root in File_httpd_conf with the correct file paths
		local
			l_util: XU_FILE_UTILITIES
			l_files: LIST [FILE_NAME]
		do
			create l_util
			o.dprint ("Scanning for '"+ File_httpd_conf + "' in " + dir_apache_conf, 1)
			l_files := l_util.scan_for_files (dir_apache_conf, 0, File_httpd_conf, "")
			from
				l_files.start
			until
				l_files.after
			loop
				o.dprint ("Replacing "+Key_document_root+" in " + l_files.item_for_iteration,1)
				l_util.replace_in_file (l_files.item_for_iteration, Key_document_root, dir_www)
				o.dprint ("Replacing "+Key_server_root+" in " + l_files.item_for_iteration,1)
				l_util.replace_in_file (l_files.item_for_iteration, Key_server_root, dir_apache)
				l_files.forth
			end
		end

invariant
	install_dir_attached: install_dir /= Void
end
