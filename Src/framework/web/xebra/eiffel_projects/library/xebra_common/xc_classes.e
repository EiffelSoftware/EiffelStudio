note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_CLASSES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			include_common_classes
		end

feature -- Other

	include_common_classes
			-- Includes all classes in the system that are needed but not neccesarily included by default
		local
			l: ANY
		do
			create {STRING}l.make_empty

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
			if attached {XCCR_INTERNAL_SERVER_ERROR} l then end
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
			if attached {XCC_GET_SESSIONS} l then end
			if attached {XCC_TRANSLATE_WEBAPP} l then end

				-- Webapp Commands
			if attached {XCWC_EMPTY} l then end
			if attached {XCWC_GET_SESSIONS} l then end
			if attached {XCWC_HTTP_REQUEST} l then end
			if attached {XCWC_SHUTDOWN} l then end
		end


end

