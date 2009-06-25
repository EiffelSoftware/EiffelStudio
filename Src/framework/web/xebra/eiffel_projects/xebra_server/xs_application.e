note
	description: "[
		Xebra Server run class
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_server: XS_MAIN_SERVER
			l_arg_parser: XS_ARGUMENT_PARSER
		do
			create l_arg_parser.make
			create l_server.make
			l_arg_parser.execute (agent l_server.setup (l_arg_parser))
		end


	compile_common_classes
			-- Includes all classes in the system that are needed but not neccesarily included
		local
			l: ANY
		do
				-- Responses
			if attached {XCCR_CANNOT_SEND} l then end
			if attached {XCCR_CONFIG_ERROR} l then end
			if attached {XCCR_CONFIG_ERROR} l then end
			if attached {XCCR_ERROR} l then end
			if attached {XCCR_GET_MODULES} l then end
			if attached {XCCR_GET_SESSIONS} l then end
			if attached {XCCR_GET_WEBAPPS} l then end
			if attached {XCCR_HTTP_REQUEST} l then end
			if attached {XCCR_OK} l then end
			if attached {XCCR_UNKNOWN_ERROR} l then end
			if attached {XCCR_WEBAPP_NOT_FOUND} l then end

				-- Server Commands
			if attached {XCC_CLEAN_WEBAPP} l then end
			if attached {XCC_DEV_OFF_GLOBAL} l then end
			if attached {XCC_DEV_OFF_WEBAPP} l then end
			if attached {XCC_DEV_ON_GLOBAL} l then end
			if attached {XCC_DEV_ON_WEBAPP} l then end
			if attached {XCC_DISABLE_WEBAPP} l then end
			if attached {XCC_ENABLE_WEBAPP} l then end
			if attached {XCC_FIREOFF_WEBAPP} l then end
			if attached {XCC_GET_MODULES} l then end
			if attached {XCC_GET_WEBAPPS} l then end
			if attached {XCC_LAUNCH_WEBAPP} l then end
			if attached {XCC_LOAD_CONFIG} l then end
			if attached {XCC_RELAUNCH_MOD} l then end
			if attached {XCC_SHUTDOWN_MOD} l then end
			if attached {XCC_SHUTDOWN_SERVER} l then end
			if attached {XCC_SHUTDOWN_WEBAPP} l then end
			if attached {XCC_SHUTDOWN_WEBAPPS} l then end

				-- Webapp Commands
			if attached {XCWC_EMPTY} l then end
			if attached {XCWC_GET_SESSIONS} l then end
			if attached {XCWC_HTTP_REQUEST} l then end
		end
end
