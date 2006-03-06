indexing
	description: "Shared instance of CODE_EVENT_MANAGER used to raise events"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_EVENT_MANAGER

feature -- Access

	Event_manager: CODE_EVENT_MANAGER is
			-- Event manager
		once
			create Result
		end

end -- class CODE_SHARED_EVENT_MANAGER

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