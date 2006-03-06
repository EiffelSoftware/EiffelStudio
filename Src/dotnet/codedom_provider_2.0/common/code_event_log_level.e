indexing
	description: "Logging levels, 0 means no logging, 1 means error only, 2 errors and warnings and 3 everything"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EVENT_LOG_LEVEL

feature -- Access

	No_log: INTEGER is 0
			-- No logging
	
	Default_log: INTEGER is 1
			-- Default logging level, logs errors only
	
	Warning_log: INTEGER is 2
			-- Logs errors and warnings
	
	Full_log: INTEGER is 3
			-- Logs everything

feature -- Status report

	is_valid_log_level (a_level: INTEGER): BOOLEAN is
			-- Is `a_level' a valid log level?
		do
			Result := a_level = No_log or a_level = Default_log or a_level = Warning_log or a_level = Full_log
		end
		
end -- class CODE_EVENT_LOG_LEVEL

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------