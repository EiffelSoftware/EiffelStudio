indexing 
	description: "Source code generator for base reference (precursor) expression"
	date: "$$"
	revision: "$$"
	
class
	CODE_BASE_REFERENCE_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
		end
		
feature -- Access

	code: STRING is
			-- | Result C# := "base"
			-- Eiffel code of base reference expression
			-- NOT SUPPORTED YET !!!
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.not_supported, ["base reference expression"])
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Event_manager.raise_event ({CODE_EVENTS_IDS}.not_supported, ["base reference expression"])
			Result := None_type_reference
		end

end -- class CODE_BASE_REFERENCE_EXPRESSION

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