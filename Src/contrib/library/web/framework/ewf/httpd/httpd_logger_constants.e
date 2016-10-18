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

feature -- Conversion	

	logger_level_representation (a_level: INTEGER): STRING
			-- String representation of `a_level'.
		do
			inspect a_level
			when alert_level 		then Result := "alert"
			when critical_level 	then Result := "critical"
			when error_level 		then Result := "error"
			when warning_level 		then Result := "warning"
			when notice_level 		then Result := "notice"
			when information_level 	then Result := "information"
			when debug_level 		then Result := "debug"
			else
				Result := "level #" + a_level.out
			end
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
