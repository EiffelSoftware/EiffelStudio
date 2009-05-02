note
	description: "Summary description for {XS_SERVER_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_SERVER_CONFIG

inherit
	ERROR_SHARED_ERROR_MANAGER
	XU_SHARED_OUTPUTTER

create
	make_empty, make_from_file

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create webapps.make (1)
		end

	make_from_file (a_path: STRING)
			-- Initialization for `Current'.
		do
			create webapps.make (1)
			process_file (a_path)
		end

feature -- Access

	assume_webapps_are_running: BOOLEAN = False


	webapps: HASH_TABLE [XS_WEBAPP, STRING]
	webapps_root: STRING

feature -- Constants

	Default_app_server_host: STRING = "localhost"

feature -- Status Change

	stop_apps
			-- Terminates all process from webapps
		do
			from
				webapps.start
			until
				webapps.after
			loop
				webapps.item_for_iteration.shutdown_all
				webapps.forth
			end
		end

feature {NONE} -- Implementation

	process_file (a_file: STRING)
			-- Parses file and sets all config attributes
		local
			l_file: KL_TEXT_INPUT_FILE
			l_parser: XM_PARSER
			l_p_callback: XS_XML_CONFIG_CALLBACK
		do
			create l_file.make (a_file)
			l_file.open_read
			if not l_file.is_open_read then
				error_manager.set_last_error (create {XERROR_FILENOTFOUND}.make (["cannot read file " + l_file.name]), false)
			else
				o.dprint ("Reading config file '" + l_file.name + "'",2)
				create {XM_EIFFEL_PARSER} l_parser.make
				create {XS_XML_CONFIG_CALLBACK} l_p_callback.make (l_parser, l_file.name)
				l_parser.set_callbacks (l_p_callback)
				l_parser.parse_from_stream (l_file)

				webapps := l_p_callback.retrieve_webapps_hash
				webapps_root := l_p_callback.webapps_root
				o.dprint ("Configured " + webapps.count.out + " webapps at '" + webapps_root + "'", 4)
				l_file.close

			end
		end


end
