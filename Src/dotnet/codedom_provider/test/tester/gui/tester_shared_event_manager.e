indexing
	description: "Shared event manager, display output in output tab"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_SHARED_EVENT_MANAGER

feature -- Access

	event_manager: TESTER_EVENT_MANAGER is
			-- Event manager
		once
			create Result
		end
		
end -- class TESTER_SHARED_EVENT_MANAGER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------