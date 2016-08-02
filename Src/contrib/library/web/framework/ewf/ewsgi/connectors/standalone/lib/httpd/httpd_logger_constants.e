note
	description: "[
			Constant value to define the logging level.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_LOGGER_CONSTANTS

feature -- Access

	alert_level: INTEGER 		= 1		-- 0000 0001
	critical_level: INTEGER 	= 2		-- 0000 0010
	error_level: INTEGER 		= 4		-- 0000 0100
	warning_level: INTEGER 		= 8		-- 0000 1000

	notice_level: INTEGER 		= 16	-- 0001 0000
	information_level: INTEGER 	= 32	-- 0010 0000
	debug_level: INTEGER 		= 64	-- 0100 0000	

end
