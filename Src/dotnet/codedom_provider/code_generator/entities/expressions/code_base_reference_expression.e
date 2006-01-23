indexing 
	description: "Source code generator for base reference (precursor) expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


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