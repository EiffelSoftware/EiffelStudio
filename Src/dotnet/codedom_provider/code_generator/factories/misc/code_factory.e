indexing
	description: "Generic code generator, common ancestor of all code generators%
			%used for feature exportation purposes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CODE_FACTORY

inherit
	CODE_SHARED_ANALYSIS_CONTEXT

	CODE_SHARED_GENERATION_HELPERS

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
	
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

feature -- Empty

invariant
	is_in_code_analysis: current_state = Code_analysis

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