indexing 
	description: "Shared instance of CODE_PARTIAL_TREE_STORE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_PARTIAL_TREE_STORE

feature -- Access

	partial_tree_store: CODE_PARTIAL_TREE_STORE is
			-- Shared instance of CODE_PARTIAL_TREE_STORE.
		once
			create Result.make
		end

end -- class CODE_SHARED_PARTIAL_TREE_STORE

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