indexing
	description: "Shared objects used in Eiffel Codedom code generator%
					%Provide access to features, variables and types caches%
					%as well as name resolvers."
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_SHARED_CODE_GENERATOR_CONTEXT

feature -- Access

	Resolver: ECD_ENTITY_NAME_RESOLVER is
			-- Name resolvers and caches access
		once
			create Result
		ensure
			exists: Result /= Void
		end
		
	Dotnet_types: ECD_DOTNET_TYPES is
			-- .NET types cache
		once
			create Result
		ensure
			exists: Result /= Void
		end

	Feature_finder: ECD_FEATURE_FINDER is
			-- Resolve .NET features from name, arguments and target type
		once
			create Result
		ensure
			exists: Result /= Void
		end
		
end -- class ECD_SHARED_CODE_GENERATOR_CONTEXT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------