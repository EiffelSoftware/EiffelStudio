indexing 
	description: "Mutex used to synchronize access to CodeDom.%
						%There should be only one access at a given time because using the EAC%
						%is not thread safe."
	date: "$$"
	revision: "$$"

class
	CODE_SHARED_ACCESS_MUTEX

feature -- Access

	Access_mutex: SYSTEM_MUTEX is
			-- .NET mutex used to synchronize codedom access
		indexing
			once_status: "global"
		once
			create Result.make (False)
		end

end -- class CODE_SHARED_ACCESS_MUTEX

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