indexing
	description: "Generic code generator, common ancestor of all code generators%
			%used for feature exportation purposes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CODE_FACTORY

inherit
	CODE_SHARED_GENERATION_CONTEXT
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_HELPERS
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end
	
	CODE_SHARED_EMPTY_ENTITIES
		export
			{NONE} all
		end

	CODE_STOCK_FEATURE_CLAUSES
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

	CODE_DIRECTIONS
		export
			{NONE} all
		end

feature
end

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