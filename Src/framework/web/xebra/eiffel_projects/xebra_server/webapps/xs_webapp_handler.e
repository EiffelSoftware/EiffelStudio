note
	description: "[
			Knows how to handle webapps
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_HANDLER

inherit
	XS_SHARED_SERVER_CONFIG

	XS_SHARED_SERVER_OUTPUTTER

feature -- Status Change

	stop_apps
			-- Terminates all process from webapps
		do
			from
				config.file.webapps.start
			until
				config.file.webapps.after
			loop
				config.file.webapps.item_for_iteration.shutdown_all
				config.file.webapps.forth
			end
		end

feature  -- Basic Operations

	forward_request (a_request_message: STRING): XC_COMMAND_RESPONSE
			-- Creates a temp request object from the request message, validates it and sends the request message to the appropriate webapplication
		local
			l_response: XH_RESPONSE
			l_request_parser: XH_REQUEST_MINI_PARSER
			l_uri_webapp_name: STRING
			l_req_buf: detachable XH_MINI_REQUEST
		do
			create l_request_parser.make
			l_req_buf := l_request_parser.request (a_request_message)
	        if attached {XH_MINI_REQUEST} l_req_buf as l_request then
				if not l_request.post_too_big then
					if attached {XS_WEBAPP} config.file.webapps[l_request.webapp] as webapp then
						Result := webapp.send (create {XCWC_HTTP_REQUEST}.make_with_request (a_request_message))
					else
						Result := (create {XER_CANNOT_FIND_APP}.make ("")).render_to_command_response
					end
				else
					Result := (create {XER_POST_TOO_BIG}.make ("")).render_to_command_response
				end
            else
            	Result := (create {XER_CANNOT_DECODE}.make ("")).render_to_command_response
            end
		end

	search_webapps (a_path: STRING): HASH_TABLE [XS_WEBAPP, STRING]
			-- Traverses folders to find config files which define webapps
		require
			not_a_path_is_detached_or_empty: a_path /= Void and then not a_path.is_empty
		local
			l_files: LIST [STRING]
			l_f_utils: XU_FILE_UTILITIES
			l_webapp_config_reader: XC_WEBAPP_JSON_CONFIG_READER
			l_ex: LINKED_LIST [STRING]
			l_inc: LINKED_LIST [STRING]
		do
			create l_ex.make
			create l_inc.make
			l_ex.force ("EIFGENs")
			l_ex.force (".svn")
			l_inc.force ({XU_CONSTANTS}.Webapp_config_file)
			create Result.make (1)
			create l_f_utils
			create l_webapp_config_reader

			l_files := l_f_utils.scan_for_files (a_path, -1, l_inc, l_ex)
			from
				l_files.start
			until
				l_files.after
			loop
				if attached {XC_WEBAPP_CONFIG} l_webapp_config_reader.process_file (l_files.item_for_iteration) as l_w then
					Result.force (create {XS_WEBAPP}.make (l_w), l_w.name)
				end

				l_files.forth
			end
		ensure
			Result_attached: Result /= Void
		end
end
