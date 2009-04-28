note
	description: "Summary description for {XS_SERVER_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_SERVER_CONFIG

inherit
	ERROR_SHARED_ERROR_MANAGER
	XU_DEBUG_OUTPUTTER

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

	webapps: HASH_TABLE [XS_WEBAPP, STRING]

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
				dprint ("Reading config file '" + l_file.name + "'",2)
				create {XM_EIFFEL_PARSER} l_parser.make
				create {XS_XML_CONFIG_CALLBACK} l_p_callback.make (l_parser, l_file.name)
				l_parser.set_callbacks (l_p_callback)
				l_parser.parse_from_stream (l_file)

				webapps := l_p_callback.webapps_hash
				l_file.close

			end
		end
end
