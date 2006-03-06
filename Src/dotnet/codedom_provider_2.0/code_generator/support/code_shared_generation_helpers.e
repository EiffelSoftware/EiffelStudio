indexing
	description: "Shared objects used in Eiffel Codedom code generator%
					%Provide access to features, variables and types caches%
					%as well as name resolvers."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_GENERATION_HELPERS

feature -- Access

	Resolver: CODE_ENTITY_NAME_RESOLVER is
			-- Name resolvers and caches access
		once
			create Result
		ensure
			exists: Result /= Void
		end
		
end -- class CODE_SHARED_GENERATION_HELPERS

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