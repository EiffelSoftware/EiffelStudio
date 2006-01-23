indexing 
	description: "Eiffel representation of a CodeDom property set value reference expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_property_type: CODE_TYPE_REFERENCE) is
			-- Creation routine
		require
			non_void_property_type: a_property_type /= Void
		do
			property_type := a_property_type
		ensure
			property_type_set: property_type = a_property_type
		end
		
feature -- Access
			
	property_type: CODE_TYPE_REFERENCE
			-- Associated property type

	code: STRING is
			-- | Result C# := "value"
			-- Eiffel code of property set value reference expression
		do
			Result := "value"
		end
		
feature -- Status Report
	
	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := property_type
		end

invariant
	non_void_property_type: property_type /= Void

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


end -- class CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION

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