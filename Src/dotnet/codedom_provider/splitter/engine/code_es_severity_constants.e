indexing
	description: "Event severity constants"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_SEVERITY_CONSTANTS

feature -- Access

	Information: INTEGER is 1
			-- Informational event
	
	Warning: INTEGER is 2
			-- Warning event, could potentially be a problem
	
	Error: INTEGER is 3
			-- Error event, something bad happened

	Stop: INTEGER is 4
			-- Stop event, stop processing

feature -- Status Report

	is_valid_severity (a_severity: INTEGER): BOOLEAN is
			-- Is `a_severity' a valid severity?
		do
			Result := a_severity = Information or a_severity = Warning or
						a_severity = Error or a_severity = Stop
		ensure
			definition: Result = (a_severity = Information or a_severity = Warning or
									a_severity = Error or a_severity = Stop)
		end

invariant
	valid_information_severity: is_valid_severity (Information)
	valid_warning_severity: is_valid_severity (Warning)
	valid_error_severity: is_valid_severity (Error)
	valid_stop_severity: is_valid_severity (Stop)

end -- class CODE_ES_SEVERITY_CONSTANTS

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------